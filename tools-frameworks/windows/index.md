# BAT / CMD


## CMD
@echo off

set /p username= "Enter username: "
set /p password= "Enter password: "
curl --location --request POST "https://zurich.okta-emea.com/oauth2/aus31n1lbcWktwFZF0i7/v1/token" ^
--header "Content-Type: application/x-www-form-urlencoded" ^
--header "flowid: PROD-getOktaToken-byAgent" ^
--data-urlencode "username=%username%" ^
--data-urlencode "password=%password%" ^
--data-urlencode "scope=openid" ^
--data-urlencode "grant_type=password" ^
--data-urlencode "client_id=0oa31mz8mn9HeAiAg0i7" ^
--data-urlencode "client_secret=9NutLWgwRpEK848-yag1bv9aIwVTPr1RnsZJdi1b"

pause