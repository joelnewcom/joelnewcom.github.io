---
layout: single
title:  "Builder pattern in Java"
date:   2022-07-20 20:41:53 +0200
categories: java
header:
  teaser: "/assets/images/java-teaser-500x300.JPG"
---
 
Shows how to create an immutable object (Solution by Joshua Bloch from effective java)

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
```