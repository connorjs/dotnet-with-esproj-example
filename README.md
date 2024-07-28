# .NET with `.esproj` Example

Example repository with C# and JS/TS with build orchestration via `dotnet` (`.csproj` and `.esproj`).

[![codecov](https://codecov.io/gh/connorjs/dotnet-with-esproj-example/graph/badge.svg?token=QFRYKH8OOY)](https://codecov.io/gh/connorjs/dotnet-with-esproj-example)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=connorjs_dotnet-with-esproj-example&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=connorjs_dotnet-with-esproj-example)

## Directory structure

The workspace (solution) has `client` and `server` directories separated to simplify the build process.
Specifically, they each have their own `Directory.*` files.
Most other configuration files live in the root directory.

The solution view offers an alternative display of the workspace.
It reorganizes the root configuration files into `client`, `server`, and `shared` under the `files` solution folder.
It groups all projects together under the `projects` solution folder (no `client` and `server` separation).
