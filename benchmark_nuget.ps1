$solutions = @("SanitisedNet471", "NuGet.Client", "OrchardCore", "orleans")
# $solutions = @("NuGet.Client")

$iterationCount = 25
$roundCount = 2
$versionCount = 3
# -staticGraphRestore -skipNoOpRestores -skipForceRestores
# -resultsFilePath results$k_$solution.csv

For ($i=0; $i -lt $solutions.Length; $i++) {
For ($j=0; $j -lt $roundCount; $j++) {
For ($k=0; $k -lt $versionCount; $k++) 
{        
	$solution = $solutions[$i]
    .\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath "..\dev-20210303-RestoreCommandCache4.$k\NuGet.exe" -resultsFilePath results.csv -solutionFilePath $solution -skipCleanRestores -skipColdRestores -skipNoOpRestores -staticGraphRestore -iterationCount $iterationCount
}}}