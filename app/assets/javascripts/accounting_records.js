function set_new_contact_area(){
	var combo_box = null;
	var hidden_attribtues = null;
	if($('input#with_new_contact').is(':checked')){
		combo_box = $('#contact_area').html();
		hidden_attribtues = $('#hidden_contact_attributes').html();
		$('#contact_area').html(hidden_attribtues);
		$('#hidden_contact_attributes').html(combo_box);
	}
	else{
		combo_box = $('#hidden_contact_attributes').html();
		hidden_attribtues = $('#contact_area').html();
		$('#contact_area').html(combo_box);
		$('#hidden_contact_attributes').html(hidden_attribtues);
	}
}

$(window).load(
  function(){
    if($("#new_contact_page").length || $("#edit_contact_page").length){
      $("#contact_phone").mask("(999) 999 99 99");
      $("#contact_mobile").mask("(999) 999 99 99");
    }
  }
);