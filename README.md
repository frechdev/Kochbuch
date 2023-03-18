
#### Build a single recipe with multiplier
cmd-Command
```pdflatex \def\inputrecipe{./Rezepte/Saftgulasch.tex} \def\x{1} \input{Rezept.tex}```

#### Build Kochbuch  and all recipes to single .pdf-Files
cmd-Command
```
powershell -file BuildRecipes.ps1 
```


