---
layout: single
---

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

If you want to test null values, you neeed to do something like this:
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
