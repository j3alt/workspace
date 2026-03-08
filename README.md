# Workspace

Personal mono-repo for .NET, Go, and PowerShell projects focused on Azure resources and GitHub.

## Layout

```
src/dotnet/libs/       Class libraries
src/dotnet/tools/      CLI tools / console apps
src/go/                Go modules (each subdir is a module)
scripts/powershell/    PowerShell modules and Azure scripts
infra/bicep/           Bicep templates
infra/terraform/       Terraform configs
tests/dotnet/          .NET test projects (mirrors src/dotnet/)
docs/                  Documentation
```

## Building

### .NET

```bash
dotnet build
dotnet test
```

.NET 10 SDK is pinned via `global.json`. Central Package Management is enabled via `Directory.Packages.props`.

### Go

```bash
go work sync
go build ./...
go test ./...
```

### PowerShell

```powershell
Invoke-ScriptAnalyzer -Path scripts/powershell/ -Recurse
```

## CI

Path-filtered GitHub Actions workflows run on relevant changes:

- **dotnet-ci** — build + test on `src/dotnet/**` and `tests/dotnet/**`
- **go-ci** — build + test + vet on `src/go/**`
- **pwsh-ci** — PSScriptAnalyzer lint on `scripts/powershell/**`
