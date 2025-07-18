#!/usr/bin/env bash
set -o errexit

# Ensure gems are installed
bundle install

# Start the server
bundle exec puma -C config/puma.rb
