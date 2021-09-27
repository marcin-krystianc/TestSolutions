$solutions = @( "OrchardCore", "orleans", "SanitisedNet471", "NuGet.Client")
# $solutions = @("NuGet.Client")

$iterationCount = 1
$roundCount = 1
$versionCount = 1
# -staticGraphRestore -skipNoOpRestores -skipForceRestores
# -resultsFilePath results$k_$solution.csv

For ($i=0; $i -lt $solutions.Length; $i++) {
For ($j=0; $j -lt $roundCount; $j++) {
For ($k=0; $k -lt $versionCount; $k++) 
{        
	$solution = $solutions[$i]
    .\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath "D:\nuget-artifacts-timestamptouch.1\NuGet.CommandLine\bin\Release\net472\NuGet.exe" -resultsFilePath results.csv -solutionFilePath $solution -skipColdRestores -skipNoOpRestores -staticGraphRestore -iterationCount $iterationCount
}}}

