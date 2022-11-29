require "open-uri"
require "nokogiri"
require "csv"

class ScrapZoomkiteSpots
  def initialize
    @url = "https://zoomkite.com/carte-interactive-spots-professionnel-kitesurf/"
  end

  def scrapp
    uri = URI(@url).read
    

    # 0. Faire le call sur le premier spot
    # 1. We get the HTML file thanks to open-uri
    # 2. We build a Nokogiri document from this file
    # 3. On recherche les liens des show de chaque spot
    # 4. On les stocke dans un array
    # 5. On fait ça fait 10 fois
  end
end
