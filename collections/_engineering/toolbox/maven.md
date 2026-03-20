---
layout: single
---

# Install maven

1. Enter the URL: https://maven.apache.org/download.cgi

2. On the Apache Maven Project page, find the heading Current Release of Maven (Proposal : 3.5.2)
3. Select available version
4. Click Save apache-maven-X.Y.Z-bin.zip file
5. Unzip it to the folder (installation folder) you want to store Apache Maven (For example : c:\software\maven\apache-maven-X.Y.Z-bin)
6. Add the ```MAVEN_HOME``` environment variable set to <installation folder>  (It is also common to use the environment variable M2_HOME)
7. Optional : Add the ```MAVEN_OPTS``` environment variable
8. Add the bin directory to your ```PATH``` environment variable → ```%MAVEN_HOME%\bin```


# settings.xml
If both files exists, their contents gets merged, with the user-specific settings.xml being dominant

## global
${maven.home}/conf/settings.xml	

## user
${user.home}/.m2/settings.xml

# Setup maven to use a specific artifactory
Default path for settings.xml is: %user%/.m2 folder. 

In the settings.xml you can define to which repo maven shall go:

```
<?xml version='1.0' encoding='UTF-8'?>
<settings>
<!--<localRepository>/opt/maven-repo</localRepository>-->
  <servers>
  </servers>
  <mirrors>
    <mirror>
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>https://nexus-pro.company.com/repository/public-group/</url>
    </mirror>
    <mirror>
      <id>oss</id>
      <mirrorOf>*</mirrorOf>
      <url>https://oss.sonatype.org/content/repositories/snapshots</url>
    </mirror>
  </mirrors>
   <proxies>
  </proxies>
  <profiles>
    <profile>
      <id>xyz-nexus</id>
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
    <profile>
      <id>allow-snapshots</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <repositories>
        <repository>
          <id>snapshots-repo</id>
          <url>http://oss.jfrog.org/artifactory/oss-snapshot-local</url>
          <releases>
            <enabled>false</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>xyz-nexus</activeProfile>
    <activeProfile>allow-snapshots</activeProfile>
  </activeProfiles>
</settings>
```

If you want to 

## Set new version 
```
mvn versions:set -DnewVersion=1.0.3-SNAPSHOT
```

## Run only  submodule

Run by folder name "server-app":
```
mvn clean verify -pl server-app -am -DintegrationTest=ServerSuiteSystemTest
```

Run by artifactId (where B is artifactID of submodule)
```
mvn install -pl :B -am
```

## Save maven warnings to a file
mvn clean install -Dmaven.compiler.showDeprecation=true -Dmaven.compiler.showWarnings=true --log-file maven-warnings.txt

# Check dependencies

## Via help
```mvn help:effective-pom``` 

## Via dependency plugin
``` mvn dependency:tree -Dverbose=true``` 

# Maven Dependency plugin

# Maven dependency

You can use it like this: 

````xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-dependency-plugin</artifactId>
            <version>${maven-dependency-plugin.version}</version>
            <!-- Plugin config according to: https://maven.apache.org/plugins/maven-dependency-plugin/examples/failing-the-build-on-dependency-analysis-warnings.html -->
            <!-- This execution is hooked to the "mvn verify" goal-->
            <executions>
                <execution>
                    <id>analyze</id>
                    <goals>
                        <goal>analyze-only</goal>
                    </goals>
                    <configuration>
                        <ignoreNonCompile>true</ignoreNonCompile>
                        <failOnWarning>true</failOnWarning>
                        <outputXML>true</outputXML>
                        <!-- Following dependencies are loaded by spring and maven cannot detect them-->
                        <usedDependencies>
                            <dependency>org.springframework.boot:spring-boot-starter-web</dependency>
                            <dependency>org.springframework.boot:spring-boot-starter-jdbc</dependency>
                        </usedDependencies>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
````

The above setup would hook on the ```mvn verify``` command. The plugin is configured
to fail if some plugins (for example from spring parent) are used, but not explicitly defined in the project pom.
Locally you can run ```mvn clean verify``` or just the specific goal if you want to skip the tests: ```mvn dependency:analyze-only``` and check if there are any warning.

If the output is something like:

````text
[INFO] --- dependency:3.5.0:analyze-only (analyze) @ customer-preference-service ---
[ERROR] Used undeclared dependencies found:
[ERROR]    org.springframework.boot:spring-boot-actuator:jar:3.1.0:compile
[INFO] Add the following to your pom to correct the missing dependencies:
[INFO]
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-actuator</artifactId>
  <version>3.1.0</version>
</dependency>
````
you can just do what is suggested and should be good to go. 