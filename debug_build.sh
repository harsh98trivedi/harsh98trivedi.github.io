#!/bin/bash
rm -rf _site .jekyll-cache
bundle exec jekyll build --verbose > build.log 2>&1
