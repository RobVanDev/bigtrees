# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "change", "#contact_type", ->
  contactMethod = $("#contact_type option:selected" ).text();

  if (contactMethod == "Phone")

    $('#contact-entry-name').html("Phone Number:");
    $('#contact-entry-field').html('<input type = "text" name = "contact_method" id = "phone_number" value class = "estimate-input" required="required">');
  else if (contactMethod == "Text")
    $('#contact-entry-name').html("Cell Number:");
    $('#contact-entry-field').html('<input type = "text" name = "contact_method" id = "cell_number" value class = "estimate-input" required="required">');
  else
    $('#contact-entry-name').html("Email Address:");
    $('#contact-entry-field').html('<input type = "text" name = "contact_method" id = "email_address" value class = "estimate-input" required="required">');
