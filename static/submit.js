function submit() {
    var form_controls = $('button, textarea');
	var submit_button = $('#submit_button');
	var url_entry = $('#url_entry');

    var urls = url_entry.val().split("\n");
    $.post("_in/submit.html", { 'urls[]': urls });
	url_entry.val('');
}

$('#submit_button').click(submit);

$(window).keydown(function(e) {
	if (e.keyCode == 10 || e.keyCode == 13)
		if (e.ctrlKey)
			submit();
});