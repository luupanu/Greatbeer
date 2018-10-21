const BEERS = {}

BEERS.show = () => {
  $("#beertable tr:gt(0)").remove()
  const table = $("#beertable")

  BEERS.list.forEach((beer) => {
    table.append('<tr>'
      + '<td>' + beer['name'] + '</td>'
      + '<td>' + beer['style']['name'] + '</td>'
      + '<td>' + beer['brewery']['name'] + '</td>'
      + '</tr>')
  })
}

BEERS.sort_by_name = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toLowerCase().localeCompare(b.name.toLowerCase())
  })
}

BEERS.sort_by_style = () => {
  BEERS.list.sort((a, b) => {
    return a.style.name.toLowerCase().localeCompare(b.style.name.toLowerCase())
  })
}

BEERS.sort_by_brewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name.toLowerCase().localeCompare(b.brewery.name.toLowerCase())
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#beertable").length == 0) return

  $("#name").click((event) => {
    event.preventDefault()
    BEERS.sort_by_name()
    BEERS.show()
  })

  $("#style").click((event) => {
    event.preventDefault()
    BEERS.sort_by_style()
    BEERS.show()
  })

  $("#brewery").click((event) => {
    event.preventDefault()
    BEERS.sort_by_brewery()
    BEERS.show()
  })

  $.getJSON('beers.json', (beers) => {
    BEERS.list = beers
    BEERS.show()
  })
})