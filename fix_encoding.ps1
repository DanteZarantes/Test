$file = 'menu.html'
# Read as Windows-1252
$content = [System.IO.File]::ReadAllText((Resolve-Path $file), [System.Text.Encoding]::GetEncoding(1252))
# Write as UTF-8 without BOM
[System.IO.File]::WriteAllText((Resolve-Path $file), $content, (New-Object System.Text.UTF8Encoding $false))
Write-Output 'Done'
