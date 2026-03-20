---
layout: single
---

# Java Swagger-Diff
To compare different swagger files. This tool loads the swagger file and compares the interpreted content rather than just do a file-diff. 

[GitHub Sayi/swagger-diff](https://github.com/Sayi/swagger-diff)

Download the latest Fat-Jar Release

## Run in Git bash
Run with local files:
java -jar swagger-diff.jar -old swagger-PROD-V1.json -new swagger-UAT-V4.json -v 2.0 -output-mode html > diff.html

Run with http paths:
java -jar swagger-diff.jar -old https://../swagger/docs/v1 -new https://../swagger/docs/v1 -v 2.0 -output-mode html > diff.html


## Build it on your own
To have a fat-jar you need to add following to the .pom file:
```
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-assembly-plugin</artifactId>
            <version>3.1.1</version>
            <configuration>
                <descriptorRefs>
                    <descriptorRef>jar-with-dependencies</descriptorRef>
                </descriptorRefs>
                <archive>
                    <manifest>
                        <addClasspath>true</addClasspath>
                        <mainClass>com.deepoove.swagger.diff.cli.CLI</mainClass>
                    </manifest>
                </archive>
            </configuration>
            <executions>
                <execution>
                    <id>make-assembly</id>
                    <phase>package</phase>
                    <goals>
                        <goal>single</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```