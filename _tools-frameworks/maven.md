---
layout: single
---

# Setup maven to use a specific artifactory
Default path for settings.xml is: %user/.m2 folder. 

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

