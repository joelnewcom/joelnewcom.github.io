---
layout: single
---

# Coding style
## Indentation
### 1TBS
One true brace style is a style where the opening brace is placed on the same line as the statement. 
The closing brace is placed on a line by itself, aligned with the statement that begins the block.

````java
if (condition) {
    // code
}
````

### Allman
Allman style is a style where the opening brace is placed on a new line.

````csharp
if (condition)
{
    // code
}
````

## Code style enforcement
Code style analysis and enforcement can happen at different places.
The first place is the IDE. Most IDEs have a code style built-in and if you run auto-format, it will format the code according to the style you have chosen.

But there are also tools like StyleCop, SonarQube, Checkstyle, PMD and dotnet format that can be used to enforce code style.
One way to give them the same set of rules you can place an .editorconfig file in the root of your project.

### .editorconfig
For C# project it is recommended by microsoft [here](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions#tools-and-analyzers)
Providing this [.editorconfig](https://github.com/dotnet/docs/blob/main/.editorconfig) as a starting point.

Having the same rules is the starting point, as everybody can now run its own tool to auto-format their code.

### enforcement
To actually enforce the rules, one way would be to define a guard to not allow wrongly formatted code to be merged into the main branch.

#### ADO Pipeline with dotnet format
We did it like this: 

```yaml

steps:
    - checkout: self
      displayName: "Checkout the repo"
      clean: true
      fetchDepth: 0
      fetchTags: false
    
    - task: UseDotNet@2
      displayName: "Setup .NET SDK"
      inputs:
        packageType: "sdk"
        version: "8.0.x"
    
    - script: |
        CHANGED_FILES=$(git diff --no-commit-id --name-only @~ @ -- '*.cs')
        echo "Changed C# files:"
        echo "$CHANGED_FILES"
        if [ -n "$CHANGED_FILES" ]; then
          dotnet format --verify-no-changes --include $CHANGED_FILES --report $(Build.SourcesDirectory)/.format
        else
          echo "No C# files changed in this PR."
        fi
      displayName: 'Run dotnet format on changed files'
      continueOnError: true
      env:
        DOTNET_NOLOGO: true
    
    - task: PublishBuildArtifacts@1
      inputs:
        PathtoPublish: '$(Build.SourcesDirectory)/.format'
        ArtifactName: 'FormatReport'
```