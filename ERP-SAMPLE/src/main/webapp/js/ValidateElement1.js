function validateElement1(arr, srcfield) {
	var fv = document.getElementById(srcfield).value;
	if (fv.length == 0) { }
	else {
		for (var i = 0; i < arr.length; i++) { if (arr[i] == fv) { return true; } }
		document.getElementById(srcfield).value = ""; document.getElementById(srcfield).focus(); return false;
	}
}