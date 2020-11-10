$solutions = @("SanitisedNet471", "NuGet.Client", "OrchardCore", "orleans")
For ($i=0; $i -lt $solutions.Length; $i++) 
{
	$solution = $solutions[$i]
	For ($j=0; $j -lt 2; $j++) 
	{
		.\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath ..\dev.0\NuGet.exe -resultsFilePath results0_$solution.csv -solutionFilePath $solution -skipCleanRestores -skipColdRestores -skipNoOpRestores -iterationCount 50
		.\NuGet.Client\scripts\perftests\RunPerformanceTests.ps1 -nugetClientFilePath ..\dev.1\NuGet.exe -resultsFilePath results1_$solution.csv -solutionFilePath $solution -skipCleanRestores -skipColdRestores -skipNoOpRestores -iterationCount 50
	}
}
