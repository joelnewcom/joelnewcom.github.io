[Home](/)

## Set new version 
```
mvn versions:set -DnewVersion=1.0.3-SNAPSHOT
```

## Run only  submodule

Run by foldername:
(reghub-server-app = Folder name)
```
mvn clean verify -pl reghub-server-app -am -DintegrationTest=ServerSuiteSystemTest
```

Run by artifactId (where B is artifactID of submodule)
```
mvn install -pl :B -am
```

## Save maven warnings to a file
mvn clean install -Dmaven.compiler.showDeprecation=true -Dmaven.compiler.showWarnings=true --log-file maven-warnings.txt

