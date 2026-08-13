# Lance dans le dossier afrinutri/
# Ajoute un .gitkeep dans chaque dossier vide

Get-ChildItem -Recurse -Directory | ForEach-Object {
    $contenu = Get-ChildItem -Path $_.FullName -Force
    if ($contenu.Count -eq 0) {
        $gitkeep = Join-Path $_.FullName ".gitkeep"
        New-Item -ItemType File -Path $gitkeep -Force | Out-Null
        Write-Host "  [OK] $($_.FullName)/.gitkeep" -ForegroundColor Green
    }
}

Write-Host "`nTous les .gitkeep ont ete ajoutes !" -ForegroundColor Cyan