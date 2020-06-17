package com.opensource.Servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class loginServlet extends HttpServlet
{
	//ServletContext servletContext = this.getServletContext(); //servlet全局域
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application=this.getServletContext();
		Integer onlineCount = (Integer)application.getAttribute("onlineCount");
		 if( onlineCount ==null || onlineCount == 0 )
		 {
		       onlineCount = 1;
		 }else
		 {
		       onlineCount += 1;
		 }
	    application.setAttribute("onlineCount", onlineCount);  
		//设置session
		HttpSession session = request.getSession(true);
		String sid = session.getId();
		session.setAttribute("usertype", request.getParameter("usertype"));
		session.setAttribute("username", request.getParameter("name"));
		String generatedCode=(String) request.getSession().getAttribute("generatedCode");
		//设置cookie
		Cookie JSESSIONID = new Cookie("JSESSIONID",sid); // 设置JSESSIONID的cookie
		session.setMaxInactiveInterval(30*60);
		response.addCookie(JSESSIONID);
		System.out.println("login success");
		String usertype = request.getParameter("usertype");
		if(usertype.equals("admin"))
		{
			System.out.println("进入管理员");
			String success = "1";
			response.getWriter().print(success.toString());
		}
		else if(usertype.equals("user"))
		{
			System.out.println("进入普通用户");
			String success = "0";
			response.getWriter().print(success.toString());
		}
	}
}
