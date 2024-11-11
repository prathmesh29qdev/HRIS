function sanitizeInput(input) {
	input = input.replace(/[^\w\s]/gi, '');

	input = input.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/"/g, '&quot;')
		.replace(/'/g, '&#x27;')
		.replace(/\//g, '&#x2F;');

	return input;
}

function sanitizeEmail(emailInput) {
	var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	return emailPattern.test(emailInput);
}
