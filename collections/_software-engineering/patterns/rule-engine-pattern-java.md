---
layout: single
---

[Source](https://www.baeldung.com/java-replace-if-statements#rule-engine)

The ```QrCodeInstructionPipe``` class defines a rule engine as a list of Rules and then stream over each Rule and call the avaluate method. 

````java
public class QrCodeInstructionPipe implements UnaryOperator<Party> {
    private static final List<Rule> rules = new ArrayList<>();
    static {
        rules.add(new IsEmailDeliveryPreferredRule());
        rules.add(new IsLanguageDeRule());
        rules.add(new HasBirthDateRule());
        rules.add(new IsLivingInSwitzerlandRule());
        rules.add(new IsPolicyHolderAndCorrespondenceReceiverRule());
        rules.add(new IsNoVCSAffinityMemberRule());
    }

    @Override
    public Party apply(Party party) {
        if (ruleEngineProcess(party)) {
            party.addInstruction(new Instruction(Instruction.InstructionType.QRCODE, true));
        }
        return party;
    }

    boolean ruleEngineProcess(Party party) {
        return rules
                .stream()
                .allMatch(r -> r.evaluate(party));
    }
}
````

````java
public interface Rule {
    boolean evaluate(Party party);
}
````

````java
public class HasBirthDateRule implements Rule {
    @Override
    public boolean evaluate(Party party) {
        return party.getBirthdate() != null;
    }
}
````