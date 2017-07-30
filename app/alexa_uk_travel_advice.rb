require 'sinatra/base'
require 'alexa_skills_ruby'
require 'faraday'
require 'json'
require_relative '../lib/html_to_ssml'

class AlexaUKTravelAdviceHandler < AlexaSkillsRuby::Handler
  GOV_UK_TRAVEL_ADVICE_ENDPOINT = 'https://www.gov.uk/api/content/foreign-travel-advice/'.freeze

  on_intent('AboutIntent') do
    # Get the country that was asked for
    slots = request.intent.slots
    country_name = slots['country']
    country_slug = country_name.downcase.strip.tr(' ', '-')

    # Get the travel advice for the country from GOV.UK
    travel_advice = Faraday.get("#{GOV_UK_TRAVEL_ADVICE_ENDPOINT}#{country_slug}")

    # Output some text for Alexa to speak
    if travel_advice.status == 200
      summary = JSON.parse(travel_advice.body)['details']['summary']
      text_to_speak = HTML2SSML.new("Here's the latest travel advice for #{country_name}. #{summary}")
      ssml_to_speak = text_to_speak.to_ssml
      text_to_display = text_to_speak.to_plain_text
      response.set_output_speech_ssml(ssml_to_speak)
      response.set_simple_card("Travel advice for #{country_name}", text_to_display)
    else
      response.set_output_speech_text("Sorry, I can't find any travel advice for #{country_name}.")
    end
  end
end

class AlexaUKTravelAdvice < Sinatra::Base
  get '/' do
    # Redirect anyone who visits to the GitHub repository
    redirect 'https://github.com/rubenarakelyan/alexa-uk-travel-advice'
  end

  get '/healthcheck' do
    'OK'
  end

  post '/alexa' do
    content_type :json

    handler = AlexaUKTravelAdviceHandler.new(application_id: ENV['APPLICATION_ID'], logger: logger)

    begin
      hdrs = { 'Signature' => request.env['HTTP_SIGNATURE'], 'SignatureCertChainUrl' => request.env['HTTP_SIGNATURECERTCHAINURL'] }
      handler.handle(request.body.read, hdrs)
    rescue AlexaSkillsRuby::Error => e
      logger.error e.to_s
      403
    end
  end
end
