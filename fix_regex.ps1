$file = 'menu.html'
$lines = [System.IO.File]::ReadAllLines((Resolve-Path $file), [System.Text.Encoding]::UTF8)

# Fix line 869 (index 868) - corrupted л in regex
$lines[868] = "                .replace(/\b\d+[,.]\d+\s*" + [char]0x043b + "\b/g, '')"

# Fix line 872 (index 871) - corrupted г in regex  
$lines[871] = "                .replace(/\s+" + [char]0x0433 + "\b/g, '')"

[System.IO.File]::WriteAllLines((Resolve-Path $file), $lines, (New-Object System.Text.UTF8Encoding $false))
Write-Output 'Done'
