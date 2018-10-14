require 'rails_helper'

describe "BeerMappingAPI" do
  CANNED_RESPONSE_ONE = "<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>"
  CANNED_RESPONSE_MULTIPLE = "<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>21526</id><name>Olu Bryki Raum</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21526</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21526&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21526&amp;d=1&amp;type=norm</blogmap><street>Vaaljoentie 64</street><city>Honkilahti</city><state>Lansi-Suomen Laani</state><zip>27640</zip><country>Finland</country><phone>+358500122344</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21537</id><name>Panimopaja</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21537</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21537&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21537&amp;d=1&amp;type=norm</blogmap><street>Vasarakatu 6</street><city>Lahti</city><state>Etela-Suomen Laani</state><zip>15700</zip><country>Finland</country><phone>+358400404945</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>"
  CANNED_RESPONSE_NONE = "<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>"

  describe "in case of cache miss" do

    before :each do
      Rails.cache.clear
    end

    it "when HTTPS GET returns one entry, it is parsed and returned" do
      make_a_stub_request(/.*turku/, CANNED_RESPONSE_ONE)

      places = BeerMappingAPI.places_in("turku")

      expect(places.size).to eq(1)
      expect(places.first.name).to eq("Panimoravintola Koulu")
      expect(places.first.street).to eq("Eerikinkatu 18")
    end

    it "when HTTPS GET returns multiple entries, they are parsed and returned" do
      make_a_stub_request(/.*tampere/, CANNED_RESPONSE_MULTIPLE)

      places = BeerMappingAPI.places_in("tampere")

      expect(places.size).to eq(2)
      expect(places.first.name).to eq("Olu Bryki Raum")
      expect(places.first.street).to eq("Vaaljoentie 64")
      expect(places.second.name).to eq("Panimopaja")
      expect(places.second.street).to eq("Vasarakatu 6")
    end

    it "when HTTPS GET returns no entries, an empty array is returned" do
      make_a_stub_request(/.*notaplace/, CANNED_RESPONSE_NONE)

      places = BeerMappingAPI.places_in("notaplace")

      expect(places).to be_empty
    end
  end

  describe "in case of cache hit" do
    before :each do
      Rails.cache.clear
    end

    it "when one entry in cache, it is returned" do
      make_a_stub_request(/.*turku/, CANNED_RESPONSE_ONE)

      BeerMappingAPI.places_in("turku")
      places = BeerMappingAPI.places_in("turku")

      expect(Rails.cache.read("turku")).not_to be_nil

      expect(places.size).to eq(1)
      expect(places.first.name).to eq("Panimoravintola Koulu")
      expect(places.first.street).to eq("Eerikinkatu 18")
    end
  end
end

private

def make_a_stub_request(url, body)
  stub_request(:get, url).to_return(
    body: body,
    headers: { 'Content-Type' => "text/xml" }
  )
end