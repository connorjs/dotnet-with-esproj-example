# Install reportgenerator if not present
if (-not (Get-Command reportgenerator -ErrorAction SilentlyContinue)) {
	dotnet tool install --global dotnet-reportgenerator-globaltool
}

function Write-Color($color) {
	$fc = $host.UI.RawUI.ForegroundColor; $host.UI.RawUI.ForegroundColor = $color; Write-Output $args; $host.UI.RawUI.ForegroundColor = $fc
}

# Clean coverage directory
Remove-Item -Recurse -Force coverage -ErrorAction SilentlyContinue

# Run the build
dotnet restore
dotnet build -c release --no-restore
dotnet test -c release --no-build
reportgenerator -reports:"coverage/*.cobertura.xml" -targetdir:coverage/report -reporttypes:"Cobertura;HtmlInline;JsonSummary;MarkdownSummaryGithub" -verbosity:Warning

# Output coverage information
$coverage = Get-Content -Raw coverage/report/Summary.json | ConvertFrom-Json
$coverage.summary | Format-Table @{ L = 'Line'; E = { "$($_.linecoverage.toString() )%" }; A = 'center' }, @{ L = 'Branch'; E = { "$( $_.branchcoverage )%" }; A = 'center' }, @{ L = 'Method'; E = { "$( $_.methodcoverage )%" }; A = 'center' }
if ($coverage.summary.linecoverage -lt 80 -or $coverage.summary.branchcoverage -lt 80 -or $coverage.summary.methodcoverage -lt 80) {
	Write-Color red "Coverage does not meet threshold.`n`nCI build failed."; Exit 1
}

# Print success (in green)
Write-Color green "CI build succeeded."
