---
layout: single
---

# Create Test via IntelliJ
First you need declare the test-folder as ```Test Sources Root```

![Create Test](/assets/images/software-engineering/java/mark-directory-as-test-root.png)

After that you can ``` Alt + Enter``` on the Class name you want to create a test for -> ````Create Test```.

# profile JVM memory and CPU consumption
Download [VisualVM](https://visualvm.github.io/download.html) and run it. It will list all running JVMs and if your application is running you will see it there.

# Regex
In this example I wrote code to determine if a string started with ```=``` ```+``` ```-``` ```@``` ```\n``` or ```\r``` and if so prepend it with ```'```. This way we can make sure that the output to csv is protected from automatic formula execution (cwe-1236) 
[To convert regex to java regex string](https://www.regexplanet.com/advanced/java/index.html)

````java
import static java.util.regex.Pattern.matches;

public class CSVOutputEscaper {

    static final String FORMULA_INJECTION_REGEX = "^[=+\\-@\\u0009\\u000D\n\t].*$";
    static final String ALPHA_NUMERIC_REGEX = "^[a-zA-Z0-9]+$";

    private CSVOutputEscaper() {
    }

    /**
     * Wrap each cell field in double quotes
     * Prepend each cell field with a single quote
     * Escape every double quote using an additional double quote
     * Source: https://owasp.org/www-community/attacks/CSV_Injection
     */
    public static String preventFormulaInjection(String data) {
        data = String.valueOf(data).replace("\"", "\"\"");
        if (matches(FORMULA_INJECTION_REGEX, data)) {
            data = "'" + data;
        }
        return data;
    }

    /**
     * If the exported data can be limited to letters, numbers and decimal separator, consider filtering the data to remove all characters that are not allowed.
     * Source: VeraCode static scan display_text.
     */
    public static String onlyAllowAlphaNumeric(String data) {
        return matches(ALPHA_NUMERIC_REGEX, data) ? data : "Redacted because data included non alphanumeric characters";
    }

    /**
     * If a field starts with a formula character, prepend it with a ' (single apostrophe), which prevents Excel from executing the formula
     * Source: https://cwe.mitre.org/data/definitions/1236.html -> Potential Mitigation
     */
    public static String prependQuoteChar(String data) {
        return "'" + data;
    }
}
````

