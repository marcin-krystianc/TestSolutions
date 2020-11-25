$solutions = @("SanitisedNet471", "NuGet.Client", "OrchardCore", "orleans")
$iterationCount = 25
For ($i=0; $i -lt $solutions.Length; $i++) 
{
	$solution = $solutions[$i]
	For ($j=0; $j -lt 2; $j++) 
	{
		Copy-Item "global0.json" -Destination "global.json"
		.\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath "..\dotnet\dotnet.exe" -resultsFilePath results0_$solution.csv -solutionFilePath $solution -skipCleanRestores -skipColdRestores -skipNoOpRestores -staticGraphRestore -iterationCount $iterationCount
		Copy-Item "global1.json" -Destination "global.json"
		.\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath "..\dotnet\dotnet.exe" -resultsFilePath results1_$solution.csv -solutionFilePath $solution -skipCleanRestores -skipColdRestores -skipNoOpRestores -staticGraphRestore -iterationCount $iterationCount
	}
}
