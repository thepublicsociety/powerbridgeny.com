jQuery ->

 

  $('#sortable').sortable(
    axis: 'y'
    items: '.item'

    # highlight the row on drop to indicate an update
    stop: (e, ui) ->
      ui.item.children('td').effect('highlight', {}, 1000)
    update: (e, ui) ->
      item_id = ui.item.data('item_id')
      position = ui.item.index()
      
      
  )