---
layout: single
---

# Check if your variable is part of enum values
Stream.of(MyEnum.values()).anyMatch(v -> v.name().equals(strValue))


# Enums with labels
````java
public enum AgreementRole {
    POLICYHOLDER("POLICYHOLDER"),
    PREMIUMPAYER("PREMIUMPAYER"),
    CORRESPONDENCERECEIVER("CORRESPONDENCERECEIVER"),
    INSURED("INSURED"),
    UNDEFINED("UNDEFINED");

    private final String label;

    AgreementRole(String label) {
        this.label = label;
    }

    @Override
    public String toString() {
        return label;
    }

    private static final Map<String, AgreementRole> stringToEnum = Stream.of(values()).collect(toMap(Object::toString, e -> e));

    public static AgreementRole fromString(String label) {
        if (label != null && stringToEnum.containsKey(label.toUpperCase(Locale.ROOT))) {
            return stringToEnum.get(label.toUpperCase(Locale.ROOT));
        }
        return UNDEFINED;
    }
}
````