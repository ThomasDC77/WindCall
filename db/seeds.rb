# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Spot.create(name: "Plage Almanarre", address: "12 rue giens", latitude: "1,22222", longitude: "43,2222", photo_url: "www.photo", description: "le spot est beau", difficulty: "débutant")

# Spot.create(name: "Plage Toulon", address: "44 rue giens", latitude: "45,22222", longitude: "56,2222", photo_url: "www.photo", description: "spot de toulon", difficulty: "intermédiaire")

# Spot.create(name: "Plage Marseille", address: "65 rue giens", latitude: "34,22222", longitude: "22,2222", photo_url: "www.photo", description: "le spot de marseille", difficulty: "profesionnel")

# # Spot.create(name: "Plage Lyon", address: "44 rue giens", latitude: "1,22222", longitude: "43,2222", photo_url: "www.photo", description: "le spot est beau", difficulty: "débutant")

require 'awesome_print'
require 'nokogiri'
require 'open-uri'
require 'json'

file1 = File.open('db/datas/page_1.html')
file2 = File.open('db/datas/page_2.html')
file3 = File.open('db/datas/page_3.html')
file4 = File.open('db/datas/page_4.html')
file5 = File.open('db/datas/page_5.html')
file6 = File.open('db/datas/page_6.html')
file7 = File.open('db/datas/page_7.html')
file8 = File.open('db/datas/page_8.html')

hrefs = []

[file1, file2, file3, file4, file5, file6, file7, file8].each do |file|
  html = Nokogiri::HTML(file)
  links = html.search("h2.elementor-heading-title a")
  links.each do |link|
    hrefs << link['href']
  end
end

hrefs.first(2).each do |href|
  uri = URI(href).read
  html = Nokogiri::HTML(uri)
  title = html.search("h1.elementor-heading-title").text
  difficulty = html.search(".jet-listing-dynamic-field__content").text

  description1 = html.search("#elementor-tab-content-1451 p").text
  description2 = html.search("#elementor-tab-content-1455 p").text
  address = html.search(".elementor-icon-list-text").first.text

  description = description1 + description2

  imgs = html.search(".jet-engine-gallery-slider__item img")
  photo_urls = imgs.reduce([]) { |arr, img| arr << img['data-src'] }

  Spot.create!(name: title, address: address, description: description, difficulty: difficulty)
end



# file_show = File.open('db/datas/page_show.html')

# html = Nokogiri::HTML(file_show)

# address = html.search(".elementor-icon-list-text").first.text
# code_post = address.scan(/\d+/)
# ap code_post.first
# geocode = Geocoder.search(code_post.first)
# ap geocode.first.coordinates


# title = html.search("h1.elementor-heading-title").text
# difficulty = html.search(".jet-listing-dynamic-field__content").text

# description1 = html.search("#elementor-tab-content-1451 p").text
# description2 = html.search("#elementor-tab-content-1455 p").text
# address = html.search(".elementor-icon-list-text").first.text
# longitude = Geocoder.search(address).first.coordinates[1]
# latitude = Geocoder.search(address).first.coordinates[0]

# imgs = html.search(".jet-engine-gallery-slider__item img")
# photo_urls = imgs.reduce([]) { |arr, img| arr << img['data-src'] }

# spot = Spot.new(...)
# spot.photo.attach(io: file, filename: "nes.png", content_type: "image/png")

# <%= cl_image_tag(spot.photo) %>

# file_show = File.open('db/datas/page_show.html')

# html = Nokogiri::HTML(file_show)
