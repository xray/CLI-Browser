# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'nokogiri'
gem 'solargraph'

group :dev, :test do
  gem 'rake', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'guard-rspec', require: false
  gem 'rspec'
  gem 'vcr'
end
