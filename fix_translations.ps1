# Read file as UTF-8
$file = 'menu.html'
$content = [System.IO.File]::ReadAllText((Resolve-Path $file), [System.Text.Encoding]::UTF8)

# Fix duplicate "};" after translations block
$content = $content -replace '(?s)(        \};\s*\r?\n\s*\r?\n\s*\};\s*\r?\n\s*\r?\n\s*// Language switcher)', "        };`r`n`r`n            // Language switcher"

# Fix nav button key lookup: remove the dash-to-space replacement so keys match directly
$content = $content -replace '                        // Convert dashes to spaces to match translation keys\r\n                        key = key\.replace\(/-/g, '' ''\);\r\n', ''
$content = $content -replace "                        // Convert dashes to spaces to match translation keys`r`n                        key = key\.replace\(/-/g, ' '\);`r`n", ''

# Replace the entire translations block
$oldPattern = '(?s)            // ========== TRANSLATIONS ==========.*?        \};'
$newBlock = @"
            // ========== TRANSLATIONS ==========
            const translations = {
                eng: {
                    subtitle: 'Fresh & Green Dining Experience',
                    all: 'All',
                    drinkCategories: {
                        'tea_coffee': 'Tea & Coffee',
                        'non-alcoholic drinks': 'Non-Alcoholic Drinks',
                        'smoothies': 'Smoothies',
                        'lemonades': 'Lemonades'
                    },
                    categories: {
                        'breakfasts': 'Breakfasts',
                        'salads': 'Salads',
                        'soups': 'Soups',
                        'meat-dishes': 'Meat Dishes',
                        'fish': 'Fish',
                        'pastas': 'Pastas',
                        'burgers': 'Burgers',
                        'bruschettas': 'Bruschettas',
                        'appetizers': 'Appetizers',
                        'for-groups': 'For Groups',
                        'pizza': 'Pizza',
                        'desserts': 'Desserts',
                        'drinks': 'Drinks',
                        'alcoholic-drinks': 'Alcoholic Drinks'
                    },
                    footerText: 'All dishes prepared with fresh ingredients',
                    quickLinks: { home: 'Home', about: 'About', reviews: 'Reviews', menu: 'Menu', contact: 'Contact' }
                },
                rus: {
                    subtitle: '$([char]0x0421)$([char]0x0432)$([char]0x0435)$([char]0x0436)$([char]0x0430)$([char]0x044f) $([char]0x0438) $([char]0x0417)$([char]0x0435)$([char]0x043b)$([char]0x0435)$([char]0x043d)$([char]0x0430)$([char]0x044f) $([char]0x0413)$([char]0x0430)$([char]0x0441)$([char]0x0442)$([char]0x0440)$([char]0x043e)$([char]0x043d)$([char]0x043e)$([char]0x043c)$([char]0x0438)$([char]0x044f)',
                    all: '$([char]0x0412)$([char]0x0441)$([char]0x0435)',
                    drinkCategories: {
                        'tea_coffee': '$([char]0x0427)$([char]0x0430)$([char]0x0439) $([char]0x0438) $([char]0x041a)$([char]0x043e)$([char]0x0444)$([char]0x0435)',
                        'non-alcoholic drinks': '$([char]0x0411)$([char]0x0435)$([char]0x0437)$([char]0x0430)$([char]0x043b)$([char]0x043a)$([char]0x043e)$([char]0x0433)$([char]0x043e)$([char]0x043b)$([char]0x044c)$([char]0x043d)$([char]0x044b)$([char]0x0435) $([char]0x041d)$([char]0x0430)$([char]0x043f)$([char]0x0438)$([char]0x0442)$([char]0x043a)$([char]0x0438)',
                        'smoothies': '$([char]0x0421)$([char]0x043c)$([char]0x0443)$([char]0x0437)$([char]0x0438)',
                        'lemonades': '$([char]0x041b)$([char]0x0435)$([char]0x043c)$([char]0x043e)$([char]0x043d)$([char]0x0430)$([char]0x0434)$([char]0x044b)'
                    },
                    categories: {
                        'breakfasts': '$([char]0x0417)$([char]0x0430)$([char]0x0432)$([char]0x0442)$([char]0x0440)$([char]0x0430)$([char]0x043a)$([char]0x0438)',
                        'salads': '$([char]0x0421)$([char]0x0430)$([char]0x043b)$([char]0x0430)$([char]0x0442)$([char]0x044b)',
                        'soups': '$([char]0x0421)$([char]0x0443)$([char]0x043f)$([char]0x044b)',
                        'meat-dishes': '$([char]0x041c)$([char]0x044f)$([char]0x0441)$([char]0x043d)$([char]0x044b)$([char]0x0435) $([char]0x0411)$([char]0x043b)$([char]0x044e)$([char]0x0434)$([char]0x0430)',
                        'fish': '$([char]0x0420)$([char]0x044b)$([char]0x0431)$([char]0x0430)',
                        'pastas': '$([char]0x041f)$([char]0x0430)$([char]0x0441)$([char]0x0442)$([char]0x0430)',
                        'burgers': '$([char]0x0411)$([char]0x0443)$([char]0x0440)$([char]0x0433)$([char]0x0435)$([char]0x0440)$([char]0x044b)',
                        'bruschettas': '$([char]0x0411)$([char]0x0440)$([char]0x0443)$([char]0x0441)$([char]0x043a)$([char]0x0435)$([char]0x0442)$([char]0x0442)$([char]0x044b)',
                        'appetizers': '$([char]0x0417)$([char]0x0430)$([char]0x043a)$([char]0x0443)$([char]0x0441)$([char]0x043a)$([char]0x0438)',
                        'for-groups': '$([char]0x0421)$([char]0x0435)$([char]0x0442)$([char]0x044b)',
                        'pizza': '$([char]0x041f)$([char]0x0438)$([char]0x0446)$([char]0x0446)$([char]0x0430)',
                        'desserts': '$([char]0x0414)$([char]0x0435)$([char]0x0441)$([char]0x0435)$([char]0x0440)$([char]0x0442)$([char]0x044b)',
                        'drinks': '$([char]0x041d)$([char]0x0430)$([char]0x043f)$([char]0x0438)$([char]0x0442)$([char]0x043a)$([char]0x0438)',
                        'alcoholic-drinks': '$([char]0x0410)$([char]0x043b)$([char]0x043a)$([char]0x043e)$([char]0x0433)$([char]0x043e)$([char]0x043b)$([char]0x044c)$([char]0x043d)$([char]0x044b)$([char]0x0435) $([char]0x041d)$([char]0x0430)$([char]0x043f)$([char]0x0438)$([char]0x0442)$([char]0x043a)$([char]0x0438)'
                    },
                    footerText: '$([char]0x0412)$([char]0x0441)$([char]0x0435) $([char]0x0431)$([char]0x043b)$([char]0x044e)$([char]0x0434)$([char]0x0430) $([char]0x043f)$([char]0x0440)$([char]0x0438)$([char]0x0433)$([char]0x043e)$([char]0x0442)$([char]0x043e)$([char]0x0432)$([char]0x043b)$([char]0x0435)$([char]0x043d)$([char]0x044b) $([char]0x0438)$([char]0x0437) $([char]0x0441)$([char]0x0432)$([char]0x0435)$([char]0x0436)$([char]0x0438)$([char]0x0445) $([char]0x0438)$([char]0x043d)$([char]0x0433)$([char]0x0440)$([char]0x0435)$([char]0x0434)$([char]0x0438)$([char]0x0435)$([char]0x043d)$([char]0x0442)$([char]0x043e)$([char]0x0432)',
                    quickLinks: { home: '$([char]0x0413)$([char]0x043b)$([char]0x0430)$([char]0x0432)$([char]0x043d)$([char]0x0430)$([char]0x044f)', about: '$([char]0x041e) $([char]0x041d)$([char]0x0430)$([char]0x0441)', reviews: '$([char]0x041e)$([char]0x0442)$([char]0x0437)$([char]0x044b)$([char]0x0432)$([char]0x044b)', menu: '$([char]0x041c)$([char]0x0435)$([char]0x043d)$([char]0x044e)', contact: '$([char]0x041a)$([char]0x043e)$([char]0x043d)$([char]0x0442)$([char]0x0430)$([char]0x043a)$([char]0x0442)' }
                },
                kaz: {
                    subtitle: '$([char]0x0421)$([char]0x04d9)$([char]0x043d)$([char]0x0434)$([char]0x0456) $([char]0x0434)$([char]0x0435) $([char]0x0416)$([char]0x0430)$([char]0x0441)$([char]0x0430)$([char]0x043d)$([char]0x0493)$([char]0x0430)$([char]0x043d) $([char]0x0422)$([char]0x0430)$([char]0x043c)$([char]0x0430)$([char]0x049b) $([char]0x0422)$([char]0x0430)$([char]0x0431)$([char]0x044b)$([char]0x0441)$([char]0x044b)',
                    all: '$([char]0x0411)$([char]0x0430)$([char]0x0440)$([char]0x043b)$([char]0x044b)$([char]0x0493)$([char]0x044b)',
                    drinkCategories: {
                        'tea_coffee': '$([char]0x0427)$([char]0x0430)$([char]0x0439) $([char]0x0436)$([char]0x04d9)$([char]0x043d)$([char]0x0435) $([char]0x041a)$([char]0x043e)$([char]0x0444)$([char]0x0435)',
                        'non-alcoholic drinks': '$([char]0x0410)$([char]0x043b)$([char]0x043a)$([char]0x043e)$([char]0x0433)$([char]0x043e)$([char]0x043b)$([char]0x0441)$([char]0x0456)$([char]0x0437) $([char]0x0421)$([char]0x0443)$([char]0x0441)$([char]0x044b)$([char]0x043d)$([char]0x0434)$([char]0x0430)$([char]0x0440)',
                        'smoothies': '$([char]0x0421)$([char]0x043c)$([char]0x0443)$([char]0x0437)$([char]0x0438)',
                        'lemonades': '$([char]0x041b)$([char]0x0438)$([char]0x043c)$([char]0x043e)$([char]0x043d)$([char]0x04d9)$([char]0x0434)$([char]0x0435)$([char]0x043b)$([char]0x0435)$([char]0x0440)'
                    },
                    categories: {
                        'breakfasts': '$([char]0x0416)$([char]0x0435)$([char]0x0439)$([char]0x0442)$([char]0x04b1)$([char]0x043b)$([char]0x044b)$([char]0x043c)',
                        'salads': '$([char]0x0421)$([char]0x0430)$([char]0x043b)$([char]0x0430)$([char]0x0442)$([char]0x0442)$([char]0x0430)$([char]0x0440)',
                        'soups': '$([char]0x0421)$([char]0x04b1)$([char]0x0439)$([char]0x044b)$([char]0x049b) $([char]0x0422)$([char]0x0430)$([char]0x0493)$([char]0x0430)$([char]0x043c)$([char]0x0434)$([char]0x0430)$([char]0x0440)',
                        'meat-dishes': '$([char]0x0415)$([char]0x0442) $([char]0x0422)$([char]0x0430)$([char]0x0493)$([char]0x0430)$([char]0x043c)$([char]0x0434)$([char]0x0430)$([char]0x0440)$([char]0x044b)',
                        'fish': '$([char]0x0411)$([char]0x0430)$([char]0x043b)$([char]0x044b)$([char]0x049b)',
                        'pastas': '$([char]0x041c)$([char]0x0430)$([char]0x043a)$([char]0x0430)$([char]0x0440)$([char]0x043e)$([char]0x043d)',
                        'burgers': '$([char]0x0411)$([char]0x0443)$([char]0x0440)$([char]0x0433)$([char]0x0435)$([char]0x0440)$([char]0x043b)$([char]0x0435)$([char]0x0440)',
                        'bruschettas': '$([char]0x0411)$([char]0x0440)$([char]0x0443)$([char]0x0441)$([char]0x043a)$([char]0x0435)$([char]0x0442)$([char]0x0442)$([char]0x0430)$([char]0x043b)$([char]0x0430)$([char]0x0440)',
                        'appetizers': '$([char]0x0411)$([char]0x0430)$([char]0x049b)$([char]0x044b)$([char]0x043b)$([char]0x0430)$([char]0x0443) $([char]0x0422)$([char]0x0430)$([char]0x0493)$([char]0x0430)$([char]0x043c)$([char]0x0434)$([char]0x0430)$([char]0x0440)',
                        'for-groups': '$([char]0x0421)$([char]0x0435)$([char]0x0442)',
                        'pizza': '$([char]0x041f)$([char]0x0438)$([char]0x0446)$([char]0x0446)$([char]0x0430)',
                        'desserts': '$([char]0x0414)$([char]0x0435)$([char]0x0441)$([char]0x0435)$([char]0x0440)$([char]0x0442)$([char]0x0442)$([char]0x0435)$([char]0x0440)',
                        'drinks': '$([char]0x0421)$([char]0x0443)$([char]0x0441)$([char]0x044b)$([char]0x043d)$([char]0x0434)$([char]0x0430)$([char]0x0440)',
                        'alcoholic-drinks': '$([char]0x0410)$([char]0x043b)$([char]0x043a)$([char]0x043e)$([char]0x0493)$([char]0x043e)$([char]0x043b)$([char]0x044c)$([char]0x0434)$([char]0x0456)$([char]0x043a) $([char]0x0421)$([char]0x0443)$([char]0x0441)$([char]0x044b)$([char]0x043d)$([char]0x0434)$([char]0x0430)$([char]0x0440)'
                    },
                    footerText: '$([char]0x0411)$([char]0x0430)$([char]0x0440)$([char]0x043b)$([char]0x044b)$([char]0x049b) $([char]0x0442)$([char]0x0430)$([char]0x0493)$([char]0x0430)$([char]0x043c)$([char]0x0434)$([char]0x0430)$([char]0x0440) $([char]0x0436)$([char]0x0430)$([char]0x04a3)$([char]0x0430) $([char]0x0438)$([char]0x043d)$([char]0x0433)$([char]0x0440)$([char]0x0435)$([char]0x0434)$([char]0x0438)$([char]0x0435)$([char]0x043d)$([char]0x0442)$([char]0x0442)$([char]0x0435)$([char]0x0440)$([char]0x0434)$([char]0x0435)$([char]0x043d) $([char]0x0434)$([char]0x0430)$([char]0x0439)$([char]0x044b)$([char]0x043d)$([char]0x0434)$([char]0x0430)$([char]0x043b)$([char]0x0493)$([char]0x0430)$([char]0x043d)',
                    quickLinks: { home: '$([char]0x0411)$([char]0x0430)$([char]0x0441)$([char]0x0442)$([char]0x044b) $([char]0x0411)$([char]0x0435)$([char]0x0442)', about: '$([char]0x0411)$([char]0x0456)$([char]0x0437) $([char]0x0422)$([char]0x0443)$([char]0x0440)$([char]0x0430)$([char]0x043b)$([char]0x044b)', reviews: '$([char]0x041f)$([char]0x0456)$([char]0x043a)$([char]0x0456)$([char]0x0440)$([char]0x043b)$([char]0x0435)$([char]0x0440)', menu: '$([char]0x041c)$([char]0x04d9)$([char]0x0437)$([char]0x0456)$([char]0x0440)', contact: '$([char]0x0411)$([char]0x0430)$([char]0x0439)$([char]0x043b)$([char]0x0430)$([char]0x043d)$([char]0x044b)$([char]0x0441)' }
                }
        };
"@

$content = [regex]::Replace($content, $oldPattern, $newBlock.TrimEnd())

# Fix nav button key lookup - remove dash-to-space conversion so keys match directly
$content = $content -replace "                        // Convert dashes to spaces to match translation keys`r`n                        key = key\.replace\(/-/g, ' '\);`r`n", ''

# Remove duplicate }; if present
$content = $content -replace "        \};\r\n\r\n            // Language switcher", "            // Language switcher"

[System.IO.File]::WriteAllText((Resolve-Path $file), $content, (New-Object System.Text.UTF8Encoding $false))
Write-Output 'Done'
