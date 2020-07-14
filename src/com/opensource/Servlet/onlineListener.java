package com.opensource.Servlet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

public class onlineListener implements HttpSessionAttributeListener
{
	public void attributeAdded(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		if ( !"username".equals(event.getName())) return;
		ServletContext application=session.getServletContext();
		Integer onlineCount = (Integer)application.getAttribute("onlineCount");
		if( onlineCount ==null || onlineCount == 0 )
		{
		      onlineCount = 1;
		}else
		{
		      onlineCount++;
		}  
		application.setAttribute("onlineCount", onlineCount);
	}
	public void attributeRemoved(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		if ("username".equals(event.getName())) {
			ServletContext application=session.getServletContext();
			Integer onlineCount = (Integer)application.getAttribute("onlineCount");
			if( onlineCount ==null || onlineCount == 0 )
			{
			      onlineCount = 0;
			}else
			{
			      onlineCount--;
			}
			application.setAttribute("onlineCount", onlineCount);
		}else
			return;
	}
	public void attributeReplaced(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		attributeAdded(event);
	}
}
