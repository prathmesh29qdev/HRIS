am = "Sorry! Right Click Not Allowed Here!!!!!";
bV = parseInt(navigator.appVersion)
bNS = navigator.appName == "Netscape"
bIE = navigator.appName == "Microsoft Internet Explorer"
function nrc(e) {
	if (bNS && e.which > 1) { alert(am); return false; }
	else
		if (bIE && (event.button > 1)) { alert(am); return false; }
}
document.onmousedown = nrc;
if (document.layers) window.captureEvents(Event.MOUSEDOWN);
if (bNS && bV < 5) window.onmousedown = nrc;
