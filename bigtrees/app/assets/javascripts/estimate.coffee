# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "change", "#tree-value", ->
  numTrees = $("#tree-value option:selected" ).text();
  $.ajax '/estimate/new',
    type: "GET"
    dataType: 'script'
    data: { 'trees' : numTrees }