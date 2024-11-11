$("#navIcon").click(function() {
	$('#navLInks').animate({ 'margin-left': "0px" }, "slow");
	$('#bdLink').show(1);

});

$("#bdLink,#closebtn").click(function() {
	$('#navLInks').animate({ 'margin-left': "-260px" }, "slow");
	$('#bdLink').hide(0);
});
