var renderReactEvents = function (data) {
  React.render(<EventCardContainer events={data}/>, document.getElementById('content'))
}

var renderReactPeople = function (data) {
  React.render(<PersonCardContainer people={data}/>, document.getElementById('content'))
}

// var getEvents = function () {
//   $.get('/events/cards.json', function( data ) {
//     if (data === null || data === undefined || data.length === 0) { return getCalendar() }
//     renderReactEvents(data)
//   })
// }

// var getMentors = function () {
//   $.get('/mentors.json', function (data) {
//     if (data === null || data === undefined || data.length === 0) { return getCalendar() }
//     renderReactPeople(data)
//   })
// }

// var getStaff = function () {
//   $.get('/staff.json', function (data) {
//     if (data === null || data === undefined || data.length === 0) { return getCalendar() }
//     renderReactPeople(data)
//   })
// }

// var getToday = function () {
//   $.get('/cards.json', function (data) {
    // console.log(data)
//     if (data === null || data === undefined || data.length === 0) { return getCalendar() }
//     renderReactEvents(data)
//   })
// }

// var getCalendar = function () {
//   $.get( '/calendars.json', function (data) {
//     renderReactEvents(data)
//   })
// }


var getEvents = function () {
  console.log('hit getEvents')
  $.get('https://dbc-infowall-api.herokuapp.com/events', function( data ) {
    renderReactEvents(data)
  })
}

var getMentors = function () {
  console.log('hit getMentors')
  $.get('https://dbc-infowall-api.herokuapp.com/mentors', function (data) {
    if (data === null || data === undefined || data.length === 0) { return getEvents() }
    renderReactPeople(data)
  })
}

var getStaff = function () {
  console.log('hit getStaff')
  $.get('https://dbc-infowall-api.herokuapp.com/staff', function (data) {
    console.log(data)
    if (data === null || data === undefined || data.length === 0) { return getEvents() }
    renderReactPeople(data)
  })
}

var getToday = function () {
  console.log('hit getToday')
  $.get('https://dbc-infowall-api.herokuapp.com/today', function (data) {
    console.log(data)
    if (data === null || data === undefined || data.length === 0) { return getEvents() }
    renderReactEvents(data)
  })
}

var getWorkshops = function () {
  console.log('hit getWorkshops')
  $.get('https://dbc-infowall-api.herokuapp.com/workshops', function (data) {
    console.log(data)
    if (data === null || data === undefined || data.length === 0) { return getEvents() }
    renderReactEvents(data)
  })
}

var getCalendar = function () {
  console.log('hit getCalendar')
  $.get( '/calendars.json', function (data) {
    renderReactEvents(data)
  })
}
var cycleCardView = function (counter) {
  console.log(counter)
  if (counter === 0) {
    counter += 1
    getToday()
    getCardsIf(counter)
  } else if (counter === 1) {
    counter += 1
    getStaff()
    getCardsIf(counter)
  } else if (counter === 2) {
    counter += 1
    getMentors()
    getCardsIf(counter)
  } else if (counter === 3) {
    counter = 0
    getWorkshops()
    getCardsIf(counter)
  }
}

var getCardsIf = function (counter) {
  if (window.location.pathname === '/events') {
    getEvents()
  } else if (window.location.pathname === '/mentors') {
    getMentors()
  } else if (window.location.pathname === '/staff') {
    getStaff()
  } else if (window.location.pathname === '/workshops') {
    getWorkshops()
  } else if (window.location.pathname === '/today') {
    getToday()
  } else if (window.location.pathname === '/cards' || window.location.pathname === '/') {
    setTimeout(function () { cycleCardView(counter) }, 40000)
  }
}
