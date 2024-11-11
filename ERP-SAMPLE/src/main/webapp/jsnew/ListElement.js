function listElementId(namearray, idarray, srcfield, dstfield) {
	var name = document.getElementById(srcfield).value;
	var ArraySize = namearray.length;
	for (var i = 0; i < ArraySize; i++) { if (namearray[i] == name) { document.getElementById(dstfield).value = idarray[i]; } }
}