---
layout: single
---

[Source](https://www.baeldung.com/java-pipeline-design-pattern)

Following example demonstrates a pipeline with just one pipe so far: 

````java
@Service
public class InstructionService {

    private final UnaryOperator<Party> pipeline;

    public InstructionService() {
        pipeline = new QrCodeInstructionPipe();
    }

    public void addInstructionsToParties(Collection<Party> parties) {
        parties.forEach(pipeline::apply);
    }
}
````

Here is the pipe itself. It implements a specific Function Interface: UnaryOperator which defines the same in and output type. The class could also just implement Function<Party, Party>, though using the specific interface is nicer.   

````java
public class QrCodeInstructionPipe implements UnaryOperator<Party> {

    @Override
    public Party apply(Party party) {
        if (ruleEngineProcess(party)) {
            party.doSomething("I was here");
        }
        return party;
    }
}
````

