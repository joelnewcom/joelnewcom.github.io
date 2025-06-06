---
layout: single
title:  "Rest Client with OAuth2"
date:   2024-07-15 00:00:00 +0200
categories: dev
---

# Simple RestClient
Simplest way is to configure a RestClient like this: 

```java
@Configuration
public class RestClientConfig {

	@Bean
	public RestClient restClient(OAuth2AuthorizedClientManager authorizedClientManager) {
		OAuth2ClientHttpRequestInterceptor requestInterceptor =
				new OAuth2ClientHttpRequestInterceptor(authorizedClientManager);
		return RestClient.builder()
				.requestInterceptor(requestInterceptor)
				.build();
	}

    @Bean
    public OAuth2AuthorizedClientManager authorizedClientManager(
            ClientRegistrationRepository clientRegistrationRepository,
            OAuth2AuthorizedClientService clientService) {
    
        OAuth2AuthorizedClientProvider authorizedClientProvider =
                OAuth2AuthorizedClientProviderBuilder.builder()
                        .refreshToken()
                        .clientCredentials()
                        .build();
    
        AuthorizedClientServiceOAuth2AuthorizedClientManager authorizedClientManager =
                new AuthorizedClientServiceOAuth2AuthorizedClientManager(clientRegistrationRepository, clientService);
    
        authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);
    
        return authorizedClientManager;
    }
}

@Service
public class ApiClient {
    private final RestClient restClient;

    public EngagementApiClientImpl(RestClient restClient) {
        this.restClient = restClientbuilder.build();
    }
    
    public List<User> getUsers() {
        return this.restClient.get()
                .uri("https://service.com/v1/users")
                .attributes(clientRegistrationId("myOAuthClient"))
                .retrieve()
                .body(Users.class);
    }
}

```

Together with this ```application.properties```:
```properties
spring.security.oauth2.client.registration.myOAuthClient.authorization-grant-type=client_credentials
spring.security.oauth2.client.registration.myOAuthClient.client-id=id
spring.security.oauth2.client.registration.myOAuthClient.client-secret=secret
spring.security.oauth2.client.registration.myOAuthClient.provider=myOAuthProvider
spring.security.oauth2.client.provider.myOAuthProvider.tokenUri=https://ch/auth/realms/myrealm/protocol/openid-connect/token
```

# Testable RestClient
Problem with above simple RestClient is that it is not easy testable.
When we want to use ```@RestClientTest````annotation, we need to inject RestClient.Builder instead of using a RestClient directly.

```java
@RestClientTest(ApiClient.class)
class ApiClientTest {
    @Autowired
    private EngagementApiClientImpl client;

    @Autowired
    private MockRestServiceServer server;

    @Test
    void GetUsers_EmptyList()  {
        // Arrange
        this.server.expect(requestTo("https://service.com/v1/engagement/users"))
                .andRespond(withSuccess("[]", MediaType.APPLICATION_JSON));

        // Act
        List<EngagementUser> result = client.getUsers();

        // Assert
        assertEquals(0, result.size());
    }
}
```

Above ApiClient class would look like this: 

```java
@Service
public class ApiClient {
    private final RestClient restClient;

    public EngagementApiClientImpl(RestClient.Builder restClientbuilder, OAuth2AuthorizedClientManager authorizedClientManager) {
        OAuth2ClientHttpRequestInterceptor requestInterceptor =
                new OAuth2ClientHttpRequestInterceptor(authorizedClientManager);

        this.restClient = restClientbuilder.requestInterceptor(requestInterceptor).build();
    }

    public List<User> getUsers() {
        return this.restClient.get()
                .uri("https://service.com/v1/users")
                .attributes(clientRegistrationId("myOAuthClient"))
                .retrieve()
                .body(Users.class);
    }
}
```