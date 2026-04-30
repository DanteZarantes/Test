$file = 'menu.html'
$content = [System.IO.File]::ReadAllText((Resolve-Path $file), [System.Text.Encoding]::UTF8)

$newFunc = @'
        const COCKTAILS = ['клубничный алиби', 'pina colada', 'long island'];

        function makeAlcoholicItem(item) {
            const div = document.createElement('div');
            div.className = 'menu-item';
            const img = document.createElement('img');
            img.className = 'menu-item-image';
            img.src = `menu_images/drinks/alcoholic drinks/${item}.jpg`;
            img.alt = item;
            img.onerror = function() { this.style.display = 'none'; };
            div.appendChild(img);
            const nameDiv = document.createElement('div');
            nameDiv.className = 'menu-item-name';
            nameDiv.textContent = item;
            div.appendChild(nameDiv);
            const details = getItemDetails()[normalizeName(item)];
            if (details && details.price) {
                const priceDiv = document.createElement('div');
                priceDiv.className = 'menu-item-price';
                priceDiv.textContent = details.price;
                div.appendChild(priceDiv);
            }
            if (details) div.addEventListener('click', function() { showModal(item, details); });
            else div.style.cursor = 'default';
            return div;
        }

        function renderAlcoholicDrinksSection(menuData) {
            const items = menuData.drinks['alcoholic drinks'];
            const section = document.createElement('section');
            section.className = 'category';
            section.id = 'category-alcoholic-drinks';

            const title = document.createElement('h2');
            title.className = 'category-title';
            title.innerHTML = `<span class="category-header" data-category-key="alcoholic-drinks">Alcoholic Drinks</span>`;
            section.appendChild(title);

            // Cocktails subgroup
            const cocktailDiv = document.createElement('div');
            cocktailDiv.className = 'drink-subcategory';
            const cocktailTitle = document.createElement('h3');
            cocktailTitle.className = 'drink-subcategory-title';
            cocktailTitle.textContent = 'Alcoholic Cocktails';
            cocktailDiv.appendChild(cocktailTitle);
            const cocktailGrid = document.createElement('div');
            cocktailGrid.className = 'menu-grid';
            COCKTAILS.forEach(item => cocktailGrid.appendChild(makeAlcoholicItem(item)));
            cocktailDiv.appendChild(cocktailGrid);
            section.appendChild(cocktailDiv);

            // Rest of alcoholic drinks
            const restDiv = document.createElement('div');
            restDiv.className = 'drink-subcategory';
            const restGrid = document.createElement('div');
            restGrid.className = 'menu-grid';
            items.filter(item => !COCKTAILS.includes(item)).forEach(item => restGrid.appendChild(makeAlcoholicItem(item)));
            restDiv.appendChild(restGrid);
            section.appendChild(restDiv);

            return section;
        }
'@

$pattern = '(?s)// Render alcoholic drinks as a separate category with images\s*\r?\n\s*function renderAlcoholicDrinksSection.*?return section;\s*\r?\n\s*\}'
$content = [regex]::Replace($content, $pattern, $newFunc.TrimStart())

[System.IO.File]::WriteAllText((Resolve-Path $file), $content, (New-Object System.Text.UTF8Encoding $false))
Write-Output 'Done'
