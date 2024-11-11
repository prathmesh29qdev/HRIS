
function resize_window() {
	var wd = 1360;
	var ht = 768;
	if (screen.availWidth > 1360) { } else { wd = screen.availWidth; }
	if (screen.availHeight > 768) { } else { ht = screen.availHeight; }
	window.moveTo(0, 0);
	window.resizeTo(wd, ht);
}

function CallLogin() { document.form.submit(); }
