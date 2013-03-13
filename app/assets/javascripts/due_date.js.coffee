$(document).ready ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()
  $("#calendar").fullCalendar
    theme: true
    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    editable: true
    events: [
      id: 999
      title: "Monthly Payroll"
      start: new Date("03-15-2013")
      allDay: false
    ]


