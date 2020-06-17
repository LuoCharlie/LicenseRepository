package com.opensource.Servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.opensource.Dao.userDao;
import com.opensource.Domain.user;

public class adminFilter implements Filter {
	private String error;
	private userDao userDao = new userDao();
	public void  init(FilterConfig config) throws ServletException {
        // 获取初始化参数
		System.out.println("进入adminfilter");
    }
    public void  doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
    	HttpSession session = ((HttpServletRequest) request).getSession(false);
    	String username = (String) session.getAttribute("username");
    	String usertype = (String) session.getAttribute("usertype");
		if(username!=null&&usertype.equals("admin"))
		{
			chain.doFilter(request,response);
		}
		else
		{
			((HttpServletResponse) response).sendRedirect("/admin/../opensource/index.jsp");
		}
        // 把请求传回过滤链
    }
  
    public void destroy( ){
        /* 在 Filter 实例被 Web 容器从服务移除之前调用 */
    }

}
