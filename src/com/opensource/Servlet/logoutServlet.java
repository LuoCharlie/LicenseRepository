package com.opensource.Servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class logoutServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置session
		HttpSession session = request.getSession(true);
		session.invalidate();
		/*
		ServletContext application=this.getServletContext();
		Integer onlineCount = (Integer)application.getAttribute("onlineCount");
	    onlineCount--;
	    System.out.println("退出+onlineCount:"+onlineCount);
	    application.setAttribute("onlineCount", onlineCount);*/
		String success = "0";
		response.getWriter().print(success.toString());
	}
}
