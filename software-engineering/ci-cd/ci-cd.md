[Home](/)

[Software Engineering](/software-engineering/index.md)

## checkstyle and pmd
It is necessary for a software-project to have static code analysis checks in place.
On Jenkins the reports of pmp and checkstyle can be easily evaluated by the "Warnings Next Generation Plugin" plugin.
To reuse the pmd or checkstyle configuration we created an own project called build-tools which just holds these files as resources. 

- [Checkstyle config](../software-engineering/ci-cd/checkstyle-config.xml)
- [PMD config](../software-engineering/ci-cd/pmd_rules.xml)

In JenkinsFile:
```
    stage('Analysis') {
        sh 'mvn --batch-mode -V -U -e checkstyle:checkstyle'
        recordIssues enabledForFailure: false, tools: [mavenConsole()]
        recordIssues enabledForFailure: false, unstableTotalAll: 250, tools: [pmdParser()]
        recordIssues enabledForFailure: false, unstableTotalAll: 1, tools: [java()]
        recordIssues enabledForFailure: false, unstableTotalAll: 1, tools: [checkStyle()]
    }
```

In parent-Pom:
```
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-checkstyle-plugin</artifactId>
        <version>3.0.0</version>
        <dependencies>
            <dependency>
                <groupId>...</groupId>
                <artifactId>build-tools</artifactId>
                <version>${build.tools.version}</version>
            </dependency>
        </dependencies>
        <configuration>
            <configLocation>checkstyle/checkstyle-config.xml</configLocation>
            <encoding>UTF-8</encoding>
            <consoleOutput>true</consoleOutput>
            <includeTestSourceDirectory>true</includeTestSourceDirectory>
            <failsOnError>true</failsOnError>
            <linkXRef>false</linkXRef>
        </configuration>
        <executions>
            <execution>
                <id>validate</id>
                <phase>validate</phase>
                <goals>
                    <goal>check</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-pmd-plugin</artifactId>
        <version>3.12.0</version>
        <dependencies>
            <dependency>
                <groupId>...</groupId>
                <artifactId>build-tools</artifactId>
                <version>${build.tools.version}</version>
            </dependency>
        </dependencies>
        <configuration>
            <targetJdk>${java.version}</targetJdk>
            <printFailingErrors>true</printFailingErrors>
            <failOnViolation>false</failOnViolation>
            <linkXRef>false</linkXRef>
            <rulesets>
                <ruleset>pmd/pmd_rules.xml</ruleset>
            </rulesets>
        </configuration>
        <executions>
            <execution>
                <id>validate</id>
                <phase>validate</phase>
                <goals>
                    <goal>check</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
```