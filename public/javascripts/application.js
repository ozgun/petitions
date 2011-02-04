// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* clickable_elm => checkbox
 * target_elm => textfield
 */
function clearAndDisableFieldOnChecked(clickable_elm, target_elm) {
  $(document).ready(function(){
    $(clickable_elm).click(function(){
      //'this' refers to your checkbox. 
      if(this.checked == true) {
        $(target_elm).val('');
        $(target_elm).attr('disabled', 'disabled');
      } else {
        $(target_elm).removeAttr('disabled');
      }
    });
  });
}

function enableDisableSubmitButton(clickable_elm, target_elm) {
  $(document).ready(function(){
    $(clickable_elm).click(function(){
      if(this.checked == true) {
        $(target_elm).removeAttr('disabled');
        $(target_elm).removeClass('disabled_button');
      } else {
        $(target_elm).attr('disabled', 'disabled');
        $(target_elm).addClass('disabled_button');
      }
    });
  });
}
