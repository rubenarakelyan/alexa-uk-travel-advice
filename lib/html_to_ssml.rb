require 'nokogiri'

class HTML2SSML
  attr_reader :html

  def initialize(html)
    @html = html
  end

  def to_plain_text
    strip_html(html)
  end

  def to_ssml
    text = strip_html(html)
    text_to_speak = paragraphs_to_sentences(text)
    ssml = "<speak>#{text_to_speak}</speak>"
    ssml
  end

private

  def strip_html(html)
    Nokogiri::HTML(html).text
  end

  def paragraphs_to_sentences(text)
    paragraphs = text.split("\n\n")
    sentences = paragraphs.map do |paragraph|
      paragraph = paragraph.strip.gsub("\n", '; ')
      "<p>#{paragraph}</p>"
    end
    sentences.join
  end
end
