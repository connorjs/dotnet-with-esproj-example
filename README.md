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

## Targets

The workspace uses the standard `dotnet` targets for both .NET and npm.

- `restore` installs dependencies
- `build` compiles, lints, and builds the projects
- `test` runs unit tests with coverage

.NET uses `build` for Analyzers and formatting (via `CSharpier.MSBuild`), so npm uses `build` for ESLint, tsc, and Prettier.

`dotnet format` exists to help auto-fix, but is not used to verify the build.

## Notes

### Path separators

Per my understanding, Windows happily accepts `/` for path separators.
Unix requires `/`.

Thus, this workspace uses `/` in all configuration files except the `*.sln` file which uses `\`.
This preserves the IDE edits made to the `*.sln` file.
