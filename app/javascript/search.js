document.addEventListener("turbo:load", function() {
  const searchBox = document.getElementById('search-box');
  const articles = Array.from(document.querySelectorAll('#article-list li'));
  let debounceTimeout = null;
  let lastSent = '';

  if (searchBox) {
    searchBox.addEventListener('input', function() {
      clearTimeout(debounceTimeout);
      const query = searchBox.value.trim();

      // Live filter articles in the DOM (instant search results)
      articles.forEach(article => {
        const text = article.textContent.toLowerCase();
        article.style.display = text.includes(query.toLowerCase()) ? '' : 'none';
      });

      // Only track searches that are meaningful (3+ chars and different from last sent)
      debounceTimeout = setTimeout(() => {
        if (query.length >= 3 && query !== lastSent) {
          lastSent = query;
          
          // Send search analytics
          fetch('/search', {
            method: 'POST',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ query: query })
          }).catch(error => {
            // Silently handle errors to not disrupt user experience
            console.log('Analytics tracking error:', error);
          });
        }
      }, 800); // Slightly longer debounce to capture more complete thoughts
    });
  }
});
