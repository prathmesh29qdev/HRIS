function validateDynamic(arr, srcfield) {
	var fv = document.getElementById(srcfield).value;
	if (fv.length == 0) { }
	else {
		if (arr.indexOf(fv) >= 0) { return true; } else { alert("Please Select Proper Value!"); document.getElementById(srcfield).focus(); return false; }
	}
}