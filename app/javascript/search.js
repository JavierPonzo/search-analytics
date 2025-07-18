document.addEventListener("turbo:load", function() {
  const searchBox = document.getElementById('search-box');
  const articles = Array.from(document.querySelectorAll('#article-list li'));
  let debounceTimeout = null;
  let lastSent = '';

  if (searchBox) {
    searchBox.addEventListener('input', function() {
      clearTimeout(debounceTimeout);
      const query = searchBox.value.toLowerCase();

      // Live filter articles in the DOM
      articles.forEach(article => {
        const text = article.textContent.toLowerCase();
        article.style.display = text.includes(query) ? '' : 'none';
      });

      debounceTimeout = setTimeout(() => {
        if (query.length > 2 && query !== lastSent) {
          lastSent = query;
          fetch('/search', {
            method: 'POST',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ query: searchBox.value })
          });
        }
      }, 600);
    });
  }
});
