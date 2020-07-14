package com.opensource.Servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.opensource.Domain.user;

public class logoutAdminFilter implements Filter 
{
	public void  init(FilterConfig config) throws ServletException {
        // 获取初始化参数
		System.out.println("进入logoutAdminFilter");
    }
	public void  doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
		HttpSession session = ((HttpServletRequest) request).getSession(true);
		if(session.getAttribute("usertype")!=null)
		{
			if(session.getAttribute("usertype").equals("admin"))
			{
				session.invalidate();
				// 把请求传回过滤链
			}
			chain.doFilter(request,response);
		}
		else
		{
			chain.doFilter(request,response);
		}
    }
    public void destroy( ){
        /* 在 Filter 实例被 Web 容器从服务移除之前调用 */
    }
}
