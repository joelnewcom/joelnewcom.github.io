---
layout: single
title:  "CWE 1236 fix"
date:   2023-06-12 00:00:00 +0200
categories: java
---

https://cwe.mitre.org/data/definitions/1236.html
http://georgemauer.net/2017/10/07/csv-injection.html
https://www.veracode.com/blog/secure-development/data-extraction-command-execution-csv-injection
https://owasp.org/www-community/attacks/CSV_Injection

[VeraCode community](https://community.veracode.com/s/question/0D53n0000844oN9CAI/how-to-fix-cwe1236improper-neutralization-of-formula-elements-in-a-csv-file-in-java-code)

# Implementation
````java
package ch.zurich.cps.util;

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