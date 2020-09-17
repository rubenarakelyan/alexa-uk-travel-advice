ruby '2.4.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'alexa_skills_ruby', '~> 1.1'
gem 'faraday', '~> 0.12'
gem 'nokogiri', '~> 1.8'
gem 'rake', '~> 12.3'
gem 'sinatra', '~> 2.0'

group :production do
  gem 'unicorn', '~> 5.3'
end

group :development do
  gem 'govuk-lint', '~> 3.2'
end
