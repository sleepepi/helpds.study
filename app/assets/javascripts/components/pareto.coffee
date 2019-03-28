@paretoCharts = ->
  $("[data-object~=pareto-chart]").each((index, element) ->
    $(element).highcharts
      credits: enabled: false
      chart:
        type: "column"
      colors: [
        "#2196f3" # blue
        "#fff176" # yellow
      ]
      title: text: "Participant not interested"
      tooltip:
        shared: true
        formatter: ->
          @points.reduce ((s, point) ->
            if point.series.type == "pareto"
              s + "<br/><span style=\"color:#{point.color}\">\u25CF</span> #{point.series.name}: #{Math.floor(point.y)}%"
            else
              s + "<br/><span style=\"color:#{point.color}\">\u25CF</span> #{point.series.name}: #{point.y}"
          ), '<b>' + @x + '</b>'
      xAxis:
        categories: [
          "Time commitment too great"
          "Too difficult traveling to appointments"
          "Study compensation too low"
          "Not comfortable with randomization"
          "Unable to complete screening PSG"
          "Other reasons"
        ]
        crosshair: true
      yAxis: [
        { title: text: "" }
        {
          title: text: ""
          minPadding: 0
          maxPadding: 0
          max: 100
          min: 0
          opposite: true
          labels: format: "{value}%"
        }
      ]
      series: [
        {
          name: "Total"
          type: "pareto"
          yAxis: 1
          zIndex: 10
          baseSeries: 1
        }
        {
          name: "Respondents"
          type: "column"
          zIndex: 2
          data: [
            67
            59
            27
            15
            8
            4
          ]
        }
      ]
  )
