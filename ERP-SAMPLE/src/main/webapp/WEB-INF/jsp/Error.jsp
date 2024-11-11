<%@ page isErrorPage="true" %>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/rightclick.js"></script> 
<title>ERP / CRM APS</title></head><body><center>
<form autocomplete="off" action="" method="post" name="form">
<br><br><br><br>
<!-- <h1><font color="yellow">Oops !!!</font></h1>  -->
<label>Something went wrong, Please try again or contact support.</label>
<%
//exception.printStackTrace(response.getWriter());
exception.printStackTrace();
%>
<br><br><br><br>
<input type="button" name="btn" value="Please Go Back" onClick="window.history.go(-1);" style="width:170px">
</form></body></html>