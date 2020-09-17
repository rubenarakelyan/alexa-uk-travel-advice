# Amazon Alexa Skill for UK Travel Advice

This is a small Ruby and [Sinatra](http://www.sinatrarb.com) app that provides an Alexa skill to read out [foreign travel advice](https://www.gov.uk/foreign-travel-advice) published by the UK Government on GOV.UK.

It uses the [`alexa_skills_ruby`](https://github.com/DanElbert/alexa_skills_ruby) gem to receive and decode requests from Alexa, and then gets the travel advice summary for the chosen country from the GOV.UK [content store](https://github.com/alphagov/content-store) API, cleans it up, turns it into [SSML](https://en.wikipedia.org/wiki/Speech_Synthesis_Markup_Language) and sends it back.

It's a pretty rough-and-ready app without much error checking or any tests for now.

### Requirements

- Ruby 2.4.1
- Everything in the [Gemfile](https://github.com/rubenarakelyan/alexa-uk-travel-advice/blob/master/Gemfile)

### Linting

`bundle exec rake lint`

### Contribution Guidelines

When contributing please consider the following guidelines:

- Please conform to the code style of the project.
- When planning a pull request to add new functionality, it may be wise to [submit a proposal](https://github.com/rubenarakelyan/alexa-uk-travel-advice/issues/new) to ensure compatibility with the project's goals.

### License

This package is licensed under the [MIT license](https://github.com/rubenarakelyan/alexa-uk-travel-advice/blob/master/LICENSE).
