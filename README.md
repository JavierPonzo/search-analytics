# Search Analytics

A simple Rails app I built to track search queries and let users add their own questions.

## What it does

- Browse through articles and questions
- Search in real-time (no page refreshes)
- Track your search history
- Add new questions via a form
- View analytics of what you've searched for

## Tech I used

- **Rails 8.0.2** - Backend framework
- **PostgreSQL** - Database
- **Bootstrap** - For styling
- **Stimulus/Turbo** - JavaScript interactions
- **RSpec** - Testing
- **Heroku** - Deployment

## Setup locally

```bash
# Clone and setup
git clone https://github.com/JavierPonzo/search-analytics.git
cd search-analytics
bundle install

# Database setup
rails db:create db:migrate db:seed

# Run tests
bundle exec rspec

# Start server
rails server
```

## Features I implemented

- **Real-time search**: Type and see results instantly
- **Search analytics**: Tracks what you search for with session tokens
- **User content**: Add new questions through a collapsible form
- **Clean UI**: Bootstrap styling with responsive design
- **Tests**: RSpec coverage for models and controllers

## Live demo

Check it out: https://search-analytics-d56c2a6d306b.herokuapp.com/

## What I learned

This was a good exercise in building a modern Rails app with:
- AJAX forms and real-time search
- Session-based analytics without user accounts
- Rails 8 with Solid adapters for cache/queue/cable
- Deployment challenges and configuration

Pretty straightforward but covers the basics of what you'd want in a search application.
