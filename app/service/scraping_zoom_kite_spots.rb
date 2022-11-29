require 'awesome_print'
require 'nokogiri'
require 'open-uri'
require 'json'

class ScrapingZoomKiteSpots
  def initialize
    @url = "https://zoomkite.com/carte-des-spots-filtres/"
  end

  def scrap
    uri = URI(@url).read
    html = Nokogiri::HTML(uri)
    title_array = []

    links = html.search("h2.elementor-heading-title a")

    links.each do |link|
      title_array << link['href']
    end

    return title_array

    # element.xpath('//a[@href]').each do |link|
    #   h[link.text.strip] = link['href']
    # end

    # title_array.each_with_index do |index, element|
    #   puts "#{index} - #{element}"
    # end
  end
end
