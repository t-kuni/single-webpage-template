keyboard = require '../jade/template/keyboard.jade'

$ ->
  $ '#message2'
    .text 'coffeeからこんにちは'
    .css
      width: '100px'
      height: '100px'
      'background-color': '#0F0'
  
  $ 'body'
    .append keyboard()
