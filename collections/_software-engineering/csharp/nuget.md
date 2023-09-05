---
layout: single
---

# Nuget Config file

| Scope    | NuGet.Config file location                                                                                                                                                                                                                                                                                   | Description                                                                                                                                                                                                                                                                                                                                                    |
|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Solution | Current folder (aka Solution folder) or any folder up to the drive root.                                                                                                                                                                                                                                     | In a solution folder, settings apply to all projects in subfolders. Note that if a config file is placed in a project folder, it has no effect on that project. When restoring a project on the command line, the project's directory is treated as the solution directory, which can lead to differences in behaviour when restoring the project vs solution. |
| User     | Windows: %appdata%\NuGet\NuGet.Config (which resolves to: C:\Users\joel.neukom\AppData\Roaming\NuGet\NuGet.Config) <br /> Mac/Linux: ~/.config/NuGet/NuGet.Config or ~/.nuget/NuGet/NuGet.Config (varies by tooling)                                                                                                                                                | Settings apply to all operations, but are overridden by any solution-level settings.                                                                                                                                                                                                                                                                           |
| Computer | Windows: %ProgramFiles(x86)%\NuGet\Config <br /> Mac/Linux: $XDG_DATA_HOME. If $XDG_DATA_HOME is null or empty, ~/.local/share or /usr/local/share will be used (varies by OS distribution)    Settings apply to all operations on the computer, but are overridden by any user- or solution-level settings. | Settings apply to all operations on the computer, but are overridden by any user- or solution-level settings.                                                                                                                                                                                                                                                  |


# Dotnet nuget commands
## List sources
Open a terminal in the root folder of a project

````shell
dotnet nuget list source                                                                                   
> Registrierte Quellen:
  1.  nuget.org [Aktiviert]
      https://api.nuget.org/v3/index.json
````

## Add source
````shell
dotnet nuget add source https://nexus.company.com/repository/reponame/ -n PrivateNexus
````

## Disable source
````shell
dotnet nuget disable source nuget.org
````

## Add authentication to a source
````shell
dotnet nuget update source PublicBcnNexus --username 'USERNAME' --password 'PASSWORD'
````

# packages location
C:\Users\%user%\.nuget\packages

# delete local
````shell
dotnet nuget locals all -c
````

# Licensing

A NuGet package available on nuget.org can have any license.
There is no restriction on whether the NuGet package is free, open source or commercially licensed.
You should review the license that each NuGet package has.
Typically a NuGet package that does not have an open source license will require you to accept the license agreement
before installing it but you should still review the license even if you are not prompted to accept one.