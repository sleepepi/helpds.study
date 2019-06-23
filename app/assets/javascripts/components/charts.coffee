@chartsReady = ->
  Highcharts.setOptions(
    lang:
      thousandsSep: ','
    colors: ['#7cb5ec', '#90ed7d', '#f7a35c', '#8085e9',
      '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1']
  )
  if $('[data-object~="draw-chart"]').length > 0
    $.each($('[data-object~=draw-chart]'), () ->
      $(@).highcharts(
        credits:
          enabled: false
        chart:
          backgroundColor: "transparent"
          zoomType: 'x'
          type: $(@).data('chart-type')
        title:
          text: $(@).data('title')
        subtitle:
          text: if $(@).data('subtitle') then $(@).data('subtitle') else (if document.ontouchstart == undefined then 'Click and drag in the plot area to zoom in' else 'Pinch the chart to zoom in')
          style:
            color: '#999'
        xAxis:
          categories: $(@).data('categories')
          title:
            text: $(@).data('xaxis')
        yAxis:
          allowDecimals: false
          min: $(@).data('yaxis-min') || 0
          max: $(@).data('yaxis-max')
          minTickInterval: 1
          title:
            text: $(@).data('yaxis')
        tooltip:
          shared: true
          crosshairs: true
        plotOptions:
          column:
            pointPadding: 0.2
            borderWidth: 0
            # stacking: 'normal'
        series: $(@).data('series')
      )
    )
