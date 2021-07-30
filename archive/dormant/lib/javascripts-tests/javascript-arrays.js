window.onload = () => {
    const arrays = {
        numbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
        languageNames: ['JavaScript', 'HTML', 'CSS', 'SQL', 'Java', 'Bash/Shall', 'Python', 'Java', 'C', 'C++', 'Python', 'Visual Basic .NET', 'C#', 'JavaScript'],
        languagePopularity: [
            {
                language: 'JavaScript',
                rank: 1,
            },
            {
                language: 'HTML',
                rank: 2,
            },
            {
                language: 'CSS',
                rank: 3,
            },
            {
                language: 'SQL',
                rank: 4,
            },
            {
                language: 'Java',
                rank: 5,
            },
            {
                language: 'Bash/Shall',
                rank: 6,
            },
            {
                language: 'Python',
                rank: 7,
            },
            {
                language: 'Java',
                rank: 8,
            },
            {
                language: 'C',
                rank: 9,
            },
            {
                language: 'C++',
                rank: 10,
            },
            {
                language: 'Python',
                rank: 11,
            },
            {
                language: 'Visual Basic .NET',
                rank: 12,
            },
            {
                language: 'C#',
                rank: 13,
            },
            {
                language: 'JavaScript',
                rank: 14,
            }
        ]
    };


    const numbersAction = document.getElementById('numbers-action');
    const languageNamesAction = document.getElementById('tech-language-names-action');
    const techLanguagePopularityAction = document.getElementById('tech-language-popularity-action');

    numbersAction.onclick = () => {
        const numbersDisplay = document.getElementById('numbers-display');
        for (let number of arrays.numbers) {
            const li = document.createElement("li");
            li.appendChild(document.createTextNode(number));
            numbersDisplay.appendChild(li);
        }
    };

    languageNamesAction.onclick = () => {
        const techLanguageNameDisplay = document.getElementById('tech-language-names-display');
        for (let name of arrays.languageNames) {
            const li = document.createElement("li");
            li.appendChild(document.createTextNode(name));
            techLanguageNameDisplay.appendChild(li);
        }
    };

    techLanguagePopularityAction.onclick = () => {
        const techLanguagePopularityDisplay = document.getElementById('tech-language-popularity-display');
        for (let ranking of arrays.languagePopularity) {
            const li = document.createElement("li");
            li.appendChild(document.createTextNode(ranking.rank + '\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0' + ranking.language));
            techLanguagePopularityDisplay.appendChild(li);
        }
    };

};
