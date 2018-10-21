json.extract! brewery, :name, :year, :active
json.beers do
  json.count brewery.beers.count
end
