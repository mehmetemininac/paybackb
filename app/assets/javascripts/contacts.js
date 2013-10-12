$(document).ready(
  function(){
    if($("#new_contact_page").length || $("#edit_contact_page").length){
      $("#contact_phone").mask("(999) 999 99 99");
      $("#contact_mobile").mask("(999) 999 99 99");
    }
  }
);