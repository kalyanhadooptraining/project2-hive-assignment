$(document).ready(function() {
	$('#path').click(function(event) {
		var name = $('#ipath').val();
		$.get('result.jsp', {
			path : name,
			isparent : false
		}, function(responseText) {
			$('#display').html(responseText);
		});
	});
});
