# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('.best_in_place').best_in_place()

	$('.best_in_place').focus(->
  		$(this).parent('tr').css 'background-color', '#E0FFE0'
 		 return
	).blur ->
  		$(this).parent('tr').css 'background-color', 'white'
  		return

