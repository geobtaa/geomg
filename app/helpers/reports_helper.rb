module ReportsHelper

  def date_range_opts
    [
      {value:'custom', display: 'Custom', selected: false},
      {value:'today', display: 'Today', selected: false},
      {value:'yesterday', display: 'Yesterday', selected: false},
      {value:'lastweek', display: 'Last Week', selected: false},
      {value:'lastmonth', display: 'Last Month', selected: false},
      {value:'lastyear', display: 'Last Year', selected: false},
      {value:'last7days', display: 'Last 7 Days', selected: false},
      {value:'last4weeks', display: 'Last 4 Weeks', selected: true},
      {value:'last30days', display: 'Last 30 Days', selected: false},
      {value:'last365days', display: 'Last 365 Days', selected: false}
    ]
  end
end
