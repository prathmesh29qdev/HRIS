function getBalance(balanceArray, selectedPartId, selectedPrinterId, dstfield) {
	for (var i = 0; i < balanceArray.length; i++) {
		if (balanceArray[i][0] == selectedPartId && balanceArray[i][1] == selectedPrinterId) {
			document.getElementById(dstfield).value = balanceArray[i][2];
			return true;   // Found it
		}
	}
	document.getElementById(dstfield).value = '0';
	//    return false;   // Not found
}
