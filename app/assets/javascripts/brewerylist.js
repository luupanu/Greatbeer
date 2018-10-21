const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    active = brewery['active'] ? 'yes' : 'no'

    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>'
      + '<td>' + brewery['year'] + '</td>'
      + '<td>' + brewery['beers']['count'] + '</td>'
      + '<td>' + active + '</td>'
      + '</tr>')
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toLowerCase().localeCompare(b.name.toLowerCase())
  })
}

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year > b.year
  })
}

BREWERIES.sort_by_beer_count = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers.count > b.beers.count
  })
}

BREWERIES.sort_by_active = () => {
  BREWERIES.list.sort((a, b) => {
    return b.active
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) return

  $("#name").click((event) => {
    event.preventDefault()
    BREWERIES.sort_by_name()
    BREWERIES.show()
  })

  $("#year").click((event) => {
    event.preventDefault()
    BREWERIES.sort_by_year()
    BREWERIES.show()
  })

  $("#beer_count").click((event) => {
    event.preventDefault()
    BREWERIES.sort_by_beer_count()
    BREWERIES.show()
  })

  $("#active").click((event) => {
    event.preventDefault()
    BREWERIES.sort_by_active()
    BREWERIES.show()
  })

  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.show()
  })
})