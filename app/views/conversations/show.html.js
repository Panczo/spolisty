$('#single_conversation').find('.media').html("<%= j render partial: 'conversations/receipt', collection: @receipts %>");

Poll = ->
  alert 'Poooolll'
  setTimeout ->
    $.get('users/28/conversations/23')
  , 5000
 
jQuery ->
  Poll()
  /* if $('.media').size() > 0*/