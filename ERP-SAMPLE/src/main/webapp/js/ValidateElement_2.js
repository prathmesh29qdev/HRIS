function validateElement(arr, srcfield) {
	var fv = document.getElementById(srcfield).value;
	if (fv.length == 0) { }
	else {
		for (var i = 0; i < arr.length; i++) { if (arr[i] == fv) { return true; } }
		alert("Please Select Proper Value!"); document.getElementById(srcfield).focus(); return false;
	}
}