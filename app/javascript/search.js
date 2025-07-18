document.addEventListener("turbo:load", function() {
  const searchBox = document.getElementById('search-box');
  const articles = Array.from(document.querySelectorAll('#article-list li'));
  const newArticleForm = document.getElementById('new-article-form');
  const formMessage = document.getElementById('form-message');
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

  // Handle new article form submission
  if (newArticleForm) {
    newArticleForm.addEventListener('submit', function(e) {
      e.preventDefault();
      
      const title = document.getElementById('article-title').value;
      const content = document.getElementById('article-content').value;
      
      if (!title || !content) {
        showMessage('Please fill in both fields.', 'danger');
        return;
      }

      fetch('/articles', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          article: {
            title: title,
            content: content
          }
        })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          showMessage(data.message, 'success');
          
          // Add the new article to the list
          const articleList = document.getElementById('article-list');
          const newItem = document.createElement('li');
          newItem.className = 'list-group-item';
          newItem.innerHTML = `
            <strong class="h5">${data.article.title}</strong>
            <p class="mb-1">${data.article.content}</p>
          `;
          articleList.appendChild(newItem);
          
          // Update the articles array for search
          articles.push(newItem);
          
          // Clear the form
          document.getElementById('article-title').value = '';
          document.getElementById('article-content').value = '';
          
          // Close the form
          setTimeout(() => {
            const collapseElement = document.getElementById('addQuestionForm');
            const collapse = bootstrap.Collapse.getInstance(collapseElement) || new bootstrap.Collapse(collapseElement);
            collapse.hide();
          }, 2000);
        } else {
          showMessage(data.message, 'danger');
        }
      })
      .catch(error => {
        showMessage('An error occurred. Please try again.', 'danger');
      });
    });
  }

  function showMessage(message, type) {
    formMessage.innerHTML = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>`;
  }
});
