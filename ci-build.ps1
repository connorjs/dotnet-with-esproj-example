param(
	[Alias('v')]
	# Set the MSBuild verbosity level. Allowed values are q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic]
	[string]$verbosity = "minimal"
)

# Install reportgenerator if not present
if (-not (Get-Command reportgenerator -ErrorAction SilentlyContinue)) {
	dotnet tool install --global dotnet-reportgenerator-globaltool
}

function Write-Color($color) {
	$fc = $host.UI.RawUI.ForegroundColor; $host.UI.RawUI.ForegroundColor = $color; Write-Output $args; $host.UI.RawUI.ForegroundColor = $fc
}

# Clean coverage directory
Remove-Item -Recurse -Force artifacts/test-results -ErrorAction SilentlyContinue

# Run the build
dotnet restore --verbosity $verbosity
dotnet build --verbosity $verbosity --configuration Release --no-restore
dotnet test --verbosity $verbosity --configuration Release --no-build
Get-ChildItem artifacts/test-results -Filter *.cobertura.xml -Name | Foreach-Object {
   $projectName = $_ -replace ".{14}$"
	(Get-Content artifacts/test-results/$_).replace("package name=`"main`"", "package name=`"${projectName}`"") | Set-Content artifacts/test-results/$_
}
reportgenerator -reports:"artifacts/test-results/*.cobertura.xml" -targetdir:artifacts/test-results/report -reporttypes:"Cobertura;HtmlInline;JsonSummary;MarkdownSummaryGithub;SonarQube" -verbosity:Warning

# Output coverage information
$coverage = Get-Content -Raw artifacts/test-results/report/Summary.json | ConvertFrom-Json
$coverage.coverage.assemblies | Format-Table @{ L = ' Project '; E = { "$($_.name)" }; A = 'center' }, @{ L = ' Line '; E = { "$($_.coverage.toString() )%" }; A = 'center' }, @{ L = ' Branch '; E = { "$( $_.branchcoverage )%" }; A = 'center' }, @{ L = ' Method '; E = { "$( $_.methodcoverage )%" }; A = 'center' }
if ($coverage.summary.linecoverage -lt 80 -or $coverage.summary.branchcoverage -lt 80 -or $coverage.summary.methodcoverage -lt 80) {
	Write-Color red "Coverage does not meet threshold.`n`nCI build failed."; Exit 1
}

# Print success
Write-Color green "CI build succeeded."
