---
layout: single
---        

String dataScopes = stream(InstructionType.values())
                .filter(party::getInstruction)
                .map(Enum::name)
                .collect(Collectors.joining(","));