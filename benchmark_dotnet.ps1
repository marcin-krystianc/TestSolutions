$solutions = @("NuGet.Client", "SanitisedNet471", "OrchardCore", "orleans", "GRLargeApp")
#$solutions = @("SanitisedNet471", "SanitisedNet471Locked")
# $solutions = @("SanitisedNetCoreApp3.1", "SanitisedNetCoreApp3.1Centralised")
#$solutions = @("SanitisedNetCoreApp3.1", "SanitisedNetCoreApp3.1Centralised", "NuGet.Client", "SanitisedNet471", "OrchardCore", "orleans", "GRLargeApp")
$solutions = @("orleans")
#$solutions = @("NuGet.Client", "OrchardCore", "orleans", "SanitisedNet471", "SanitisedNetCoreApp3.1")

$iterationCount = 10
$roundCount = 1
$versionCount = 2
# -staticGraphRestore 
# -skipCleanRestores -skipColdRestores -skipNoOpRestores -skipForceRestores
# -resultsFilePath results$k_$solution.csv

For ($i=0; $i -lt $solutions.Length; $i++) {
For ($j=0; $j -lt $roundCount; $j++) {
For ($k=0; $k -lt $versionCount; $k++) 
{        
	$solution = $solutions[$i]
	Copy-Item "global$k.json" -Destination "global.json"   
    .\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath "C:\Program Files\dotnet\dotnet.exe" -resultsFilePath results.csv -solutionFilePath $solution -iterationCount $iterationCount
#    .\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath "D:\dotnet\dotnet.exe" -resultsFilePath results.csv -solutionFilePath $solution -iterationCount $iterationCount -skipCleanRestores -skipColdRestores -skipNoOpRestores -staticGraphRestore 
}}}