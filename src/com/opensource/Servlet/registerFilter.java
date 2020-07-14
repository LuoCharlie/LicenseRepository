package com.opensource.Servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.opensource.Dao.userDao;
import com.opensource.Domain.user;

public class registerFilter implements Filter {
	private userDao userDao = new userDao();
	public void  init(FilterConfig config) throws ServletException {
        // 获取初始化参数
		System.out.println("进入registerfilter");
    }
	public void  doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
		String code = request.getParameter("code");
    	String generatedCode=(String) ((HttpServletRequest) request).getSession().getAttribute("generatedCode");
		System.out.println("code:"+code);
		String error;
		if(code.toLowerCase().equals(generatedCode.toLowerCase())) //判断验证码正确
		{
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			user user = userDao.getUser("user",username);
			System.out.println("register-name"+username);
			if(user.getName()==null)
			{
				user adduser = new user();
				adduser.setName(username);
				adduser.setPassword(password);
				userDao.addUser("user", adduser);
				System.out.println("success:"+username+"\n\n");
				//response.getWriter().print("0");
				chain.doFilter(request,response);
			}
			else
			{
				System.out.println("用户名已存在");
				response.getWriter().print("-1"); //该用户名已存在
			}
		}
		else
		{
			error = "-2";//验证码错误
			System.out.println("error:"+error);
			response.getWriter().print(error.toString());
		}
	}
	public void destroy( ){
        /* 在 Filter 实例被 Web 容器从服务移除之前调用 */
    }
}
