---
layout: single
---

# Azure DevOps

## Pipelines

Jobs run on independent agents (separate computers) and do not have any kind of shared filesystem.
https://learn.microsoft.com/en-us/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml

Any files created in one job that you want to make available on a dependent job must be explicitly staged (in job 'A') and then explicitly downloaded (in job 'B').
See publish: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/publish-build-artifacts?view=azure-devops

And download: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/download-build-artifacts?view=azure-devops


## ARM Templates
* In full-mode, the template would delete resources not mentioned in the template.
* In incremental mode, ARM would not delete the not mentioned resources.
* Doesn't support modules. Files will get really long. The language is Azure Resource Manager specific.
* New features are available immediately

## Bicep
* Uses ARM underneath and is straight forward. It only works with Azure.
* Doesn't know about the current Infrastructure deployment (no state)
* Support modules

## Terraform
* Uses ARM for Azure resources. Has a state about the current infrastructure deployment.
* Doesn't have the latest feature from the providers

# Java code analysis on Jenkins
## checkstyle and pmd 
It is necessary for a software-project to have static code analysis checks in place.
On Jenkins the reports of pmd and checkstyle can be easily evaluated by the "Warnings Next Generation Plugin" plugin.
To reuse the pmd or checkstyle configuration, we created an own project called build-tools which just holds these files as resources. 

- [Checkstyle config](/software-engineering/devops/checkstyle-config.xml)
- [PMD config](/software-engineering/devops/pmd_rules.xml)

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