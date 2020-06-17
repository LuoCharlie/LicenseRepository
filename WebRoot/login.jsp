<%@ page 
	language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
<%
	Cookie cookie = null;
	Cookie[] cookies = null;
	cookies = request.getCookies();
	if( cookies != null )
	{
		for (int i = 0; i < cookies.length; i++)
		{
			cookie = cookies[i];
			if(cookie.getName().equals("JSESSIONID"))
			{
				pageContext.setAttribute("sessionID", cookie.getName());
			}
		}
	}
	pageContext.setAttribute("usertype", request.getSession().getAttribute("usertype"));
	pageContext.setAttribute("username", request.getSession().getAttribute("username"));
%>

<script>
	let sessionID = "${sessionID}";
	let usertype = "${usertype}";
	let username = "${username}";
	if(sessionID!=""&&usertype!=""&&username!="")
	{
		$("#userinfo").html("");
		let append = "<span class='login hover-white'>" + username + "</span>";
		append += "<span style='padding:0 5px 0 5px'>●</span>";
		append += "<a href='/opensource/logout' class='login' id='logout'>退出</a>";
		$("#userinfo").append(append);
		console.log("进入判断  sessionID:"+sessionID+",  username:"+username+",  usertype:"+usertype);
	}
	
</script>