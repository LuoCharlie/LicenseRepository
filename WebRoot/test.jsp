<%@ page 
	language="java" 
	contentType="text/html; charset=GBK"
    pageEncoding="GBK" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>JSP</title>
</head>
<body>
<center>
<h1>
	<%
		List<featureLicense> licenses = (List<featureLicense>) request.getAttribute("license");
		for (featureLicense license : licenses) {
			out.println(license.getName() + "<br>");
		}
	%>
</h1>
</center>
</body>
</html>