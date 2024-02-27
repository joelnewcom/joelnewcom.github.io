---
layout: single
---

This creates an immutable object which can only be created via a builder object. This is nicer than put everything into a constructor.  

```java
public class Rocket {
    private final int height;
    private final int maxSpeed;
    private final List<Cargo> cargo;

    public static class Builder {
        // Required parameters
        private final int height;
        private final int maxSpeed;

        // Optional parameters - initialized to default values
        private List<Cargo> cargo = new ArrayList<Cargo>();
       
        public Builder(int height, int maxSpeed) {
            this.height = height;
            this.maxSpeed = maxSpeed;
        }

        public Builder withCargo(List<Cargo> cargo) { 
            this.cargo = cargo;
            return this; 
        }

        public Rocket build() {
            return new Rocket(this);
        }
    }

    private Rocket(Builder builder) {
        height = builder.height;
        maxSpeed = builder.maxSpeed;
        cargo = builder.cargo;
    }
}