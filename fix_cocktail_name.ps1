$file = 'menu.html'
$content = [System.IO.File]::ReadAllText((Resolve-Path $file), [System.Text.Encoding]::UTF8)

# Extract the exact string used in menuData for клубничный алиби
$match = [regex]::Match($content, "'alcoholic drinks': \[\s*'([^']+)'")
$klubnichny = $match.Groups[1].Value
Write-Output "Found: $klubnichny"

# Replace COCKTAILS array with exact same strings from menuData
$content = [regex]::Replace($content, "const COCKTAILS = \['[^']*', 'pina colada', 'long island'\]", "const COCKTAILS = ['$klubnichny', 'pina colada', 'long island']")

[System.IO.File]::WriteAllText((Resolve-Path $file), $content, (New-Object System.Text.UTF8Encoding $false))
Write-Output 'Done'
