#!/bin/bash
set -e

echo "🧹 Cleaning up old artifacts..."
rm -rf vendor .bundle Gemfile.lock _site .jekyll-cache

echo "⚙️  Configuring Bundler..."
# Ensure we ignored global gems and install strictly locally
bundle config set --local path 'vendor/bundle'
bundle config set --local disable_shared_gems 'true'

echo "📥 Installing dependencies..."
bundle install

echo "✅ Verifying installation..."
bundle exec jekyll --version

echo "🎉 Done! You can now run 'npm run dev'"
