package com.opensource.Servlet;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.opensource.Dao.userDao;
import com.opensource.Domain.user;

public class loginFilter implements Filter {
	private String error;
	private userDao userDao = new userDao();
	public void  init(FilterConfig config) throws ServletException {
        // 获取初始化参数
		System.out.println("进入loginfilter");
    }
	
    public void  doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
    	System.out.println("进入logindofilter");
    	String code = request.getParameter("code");
    	String generatedCode=(String) ((HttpServletRequest) request).getSession().getAttribute("generatedCode");
		System.out.println("code:"+code);
		if(code.toLowerCase().equals(generatedCode.toLowerCase())) //判断验证码正确
		{
			String usertype = request.getParameter("usertype");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String location = request.getParameter("location");
			System.out.println("usertype:"+usertype+";  name:"+username+"\n\n");
			if(isUser(usertype,username,password,location))
			{
				System.out.println("chain");
				chain.doFilter(request,response);
			}
			else
			{
				error = "-1";//用户名或密码错误
				System.out.println("error:"+error);
				response.getWriter().print(error.toString());
			}
		}
		else
		{
			error = "-2";//验证码错误
			System.out.println("error:"+error);
			response.getWriter().print(error.toString());
		}
        // 把请求传回过滤链
    }
    
    public boolean isUser(String type,String name,String password,String location) throws IOException {
		System.out.println("进入isUser");
		user user = userDao.getUser(type,name);
		System.out.println("数据库密码:"+user.getPassword()+",用户输入:"+password);
		if(password.equals(user.getPassword()))
		{
			System.out.println("相等，location:"+location+"\n\n");
			return true;
		}
		else
		{
			error = "-1";//密码错误
			return false;
		}
	}
    public void destroy( ){
        /* 在 Filter 实例被 Web 容器从服务移除之前调用 */
    }
}


