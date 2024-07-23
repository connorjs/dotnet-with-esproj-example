try {
   $env:CI = true
	dotnet restore
	dotnet build -c release --no-restore
	dotnet test -c release --no-build
} finally {
	$env:CI = $null
}
