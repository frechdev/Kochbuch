$CurrentDirectory = Get-Location
$SourceDirectory = Join-Path -Path $CurrentDirectory -ChildPath "Rezepte"
$TargetDirectory = Join-Path -Path $CurrentDirectory -ChildPath "RezepteEinzeln"
$MainTexFileName = 'Rezept.tex'
$RecipeTexFileSubDir = './Rezepte/'


Write-Host 'CurrentDirectory:' $CurrentDirectory;
Write-Host 'SourceDirectory:' $SourceDirectory;
Write-Host 'TargetDirectory:' $TargetDirectory;

New-Item -Path $TargetDirectory -ItemType "directory" -Force

$SourceFiles = (Get-ChildItem -Path (Join-Path -Path $SourceDirectory -ChildPath "*.tex")).Name
foreach ($SourceFile in $SourceFiles)
{
    $RecipeTexFile = $RecipeTexFileSubDir + $SourceFile
    $texCommand = '\def\inputrecipe{' + $RecipeTexFile + '}\def\x{1}\input{' + $MainTexFileName + '}'
    Write-Host 'Compiling' $SourceFile;
    pdflatex --interaction=batchmode $texCommand;

    $RezeptPdfSourceFilePath = Join-Path -Path $CurrentDirectory -ChildPath $MainTexFileName.Replace('.tex', '.pdf')
    $RezeptPdfTargetFilePath = Join-Path -Path $TargetDirectory -ChildPath $SourceFile.Replace('.tex', '.pdf')
    Move-Item -Path $RezeptPdfSourceFilePath -Destination  $RezeptPdfTargetFilePath -Force
}

pdflatex --interaction=batchmode '\input{Kochbuch.tex}';
pdflatex --interaction=batchmode '\input{Kochbuch.tex}';

Write-Host 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');