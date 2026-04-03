param(
  [string]$ProfilePath = (Join-Path $PSScriptRoot "..\\configs\\companion-profile.json"),
  [string]$TargetPath = (Join-Path $HOME ".claude.json")
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ProfilePath)) {
  throw "Profile file not found: $ProfilePath"
}

$profile = Get-Content -LiteralPath $ProfilePath -Raw | ConvertFrom-Json
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupPath = "$targetPath.bak.$timestamp"

if (Test-Path -LiteralPath $targetPath) {
  Copy-Item -LiteralPath $targetPath -Destination $backupPath -Force
  $current = Get-Content -LiteralPath $targetPath -Raw | ConvertFrom-Json
} else {
  $current = [pscustomobject]@{}
}

$changedKeys = @()

if ($current.userID -ne $profile.userID) {
  $changedKeys += "userID"
}

$currentCompanionJson = ($current.companion | ConvertTo-Json -Depth 10 -Compress)
$profileCompanionJson = ($profile.companion | ConvertTo-Json -Depth 10 -Compress)
if ($currentCompanionJson -ne $profileCompanionJson) {
  $changedKeys += "companion"
}

$current | Add-Member -NotePropertyName "userID" -NotePropertyValue $profile.userID -Force
$current | Add-Member -NotePropertyName "companion" -NotePropertyValue $profile.companion -Force

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText(
  $targetPath,
  (($current | ConvertTo-Json -Depth 100) + "`n"),
  $utf8NoBom
)

Write-Host "Applied companion profile to $targetPath"
if (Test-Path -LiteralPath $backupPath) {
  Write-Host "Backup created at $backupPath"
}
if ($changedKeys.Count -eq 0) {
  Write-Host "No effective changes were needed."
} else {
  Write-Host ("Changed keys: " + ($changedKeys -join ", "))
}
