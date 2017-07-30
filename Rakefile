desc "Run linter"
task :lint do
  sh "bundle exec govuk-lint-ruby --format clang app lib config.ru Gemfile"
end

task :default => [:lint]
