---
layout: single
---

# Spring basic 3 tier pattern
You can split your application into 3 layers: 

* Controllers
* Service
* Repository

[3tier](/assets/images/software-engineering/architecture/3tier/software-architecture.PNG)

I would keep your business code in a project called Services, your DAL code in a project called Repositories, and your interfaces and business objects(or entities) in a project called Core.
Your REST project should reference only Core (and Services for resolving dependencies). 
You program exclusively to interfaces.
Your Services and Repositories should each only depend on Core. These concrete implementations need only implement Core interfaces and act on Core entities.
[Source](https://stackoverflow.com/a/26908990/4132067)

# Tell java compiler and IDE not warn about Spring dependency injection
Annotate a method or classes with: ```@SuppressWarnings("unused")```

````java
    @GetMapping("/csv")
    @SuppressWarnings("unused")
    public String index() {
        return "csv";
    }
````

# Parameterized tests
In the normal case you have multiple parameters like: ```inputvalue``` and ```expectedResult```. To pass multiple parameters you can use ```@CsvSource```

````java
@ParameterizedTest
@CsvSource({"a,1", "b,2", "foo,3"})
public void testParameters(String name, int value) {
    System.out.println("csv data " + name + " value " + value);
}
````

If you want to test null values, you need to do something like this:
````java
    @ParameterizedTest
    @CsvSource(value = {"de,true", "null,false", "fr,false"},
            nullValues = {"null"})
    void isLanguageDeRule(String language, boolean result) {
        Party testParty = new Party();
        testParty.setLanguage(language);
        assertThat(isLanguageDeRule.evaluate(testParty), is(result));
    }
````

You can also define a method to provide the parameters:

````java
    private static String[] nullEmptyBlankSource() {
        return new String[] { null, "", " " };
    }
    
    @ParameterizedTest
    @MethodSource("nullEmptyBlankSource")
    void invalidValuesAreNotAllowed(String person) {
        assertThatThrownBy(() -> greet(person))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessage("person is mandatory");
    }
````

# Exception assertions
Source: https://www.baeldung.com/junit-assert-exception

## Test no exception thrown
````java
    @ParameterizedTest
    @CsvSource({"PROD", "UAT", "SIT", "DEV"})
    void getEnvironmentOk(String env) {
        Config config = new Config();
        assertDoesNotThrow(() -> config.setEnvironment(env));
    }
````

## Test exception thrown
````java
    @ParameterizedTest
@CsvSource(value = {"prod", "uat", "sit", "dev", "''", "null"},
        nullValues = {"null"})
    void getEnvironmentNok(String env) {
        Config config = new Config();
        Exception exception = assertThrows(IllegalStateException.class, () -> config.setEnvironment(env));
        String actualMessage = exception.getMessage();
        assertThat(actualMessage, is("Environment needs to be one of the values of DEV, SIT, UAT or PROD"));
        }
````

# Setup a local env via spring property file
1. Create a file ```src/main/resources/application-local.properties```
2. Define following variables within the new properties file. They will override the ones in ```src/main/resources/application.properties```:
   ```    
   servicename.config.environment=xxx
   servicename.config.configname=xxx 
   ```
3. Add new Run Configuration with Environment variables equals ```--spring.profiles.active=local```

![getting started - local env](/assets/images/software-engineering/java/getting-started-run-config.PNG)

# ### Setup a local env via environment variables

Add new Run configuration and define each attribute as Environment variable:
```
   ENVNAME=value;ENVNAME2=value;
```

![getting started - local env](/assets/images/software-engineering/java/getting-started-run-config-env-variables.PNG)

### Generate a new BCrypted password
Follow this [instructions](https://docs.spring.io/spring-security/reference/servlet/authentication/passwords/in-memory.html)