$ErrorActionPreference = "Stop"
$source = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "Copying Solifay UI assets into the selected V2rayNG project..."
$project = Read-Host "Enter the V2rayNG project root path (folder containing app)"
if (!(Test-Path (Join-Path $project "app"))) { throw "The path does not look like a V2rayNG project root (app folder missing)." }
Get-ChildItem -LiteralPath $source -Recurse -File | Where-Object { $_.FullName -notmatch '\apply-solify-ui\.ps1$' } | ForEach-Object {
    $relative = $_.FullName.Substring($source.Length).TrimStart('\')
    $target = Join-Path $project $relative
    $dir = Split-Path -Parent $target
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    Copy-Item $_.FullName $target -Force
}
Write-Host "Solifay UI files copied successfully." -ForegroundColor Green
