package com.opensource.Servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.json.JSONArray;
import org.json.JSONObject;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.opensource.Dao.featureDao;
import com.opensource.Dao.typeDao;
import com.opensource.Dao.userDao;
import com.opensource.Dao.LicensesDao;
import com.opensource.Dao.detailDao;
import com.opensource.Dao.fqaDao;
import com.opensource.Dao.downloadDao;
import com.opensource.Domain.Licenses;
import com.opensource.Domain.detailLicense;
import com.opensource.Domain.featureLicense;
import com.opensource.Domain.type;
import com.opensource.Domain.user;
import com.opensource.Domain.fqa;
import com.opensource.Domain.downloadLicense;

public class manageServlet extends HttpServlet
{
	private static final long serialVersionUID = 1174461738374924975L;
	private detailDao detailDao = new detailDao();
	private typeDao typeDao = new typeDao();
	private fqaDao fqaDao = new fqaDao();
	private LicensesDao LicensesDao = new LicensesDao();
	private userDao userDao = new userDao();
	private static Comparator<Object> comparator=Collator.getInstance(java.util.Locale.CHINA);   
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		this.doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String uri = request.getRequestURI();
		System.out.println("Method URI : " + uri);
		String methodName = uri.substring(uri.lastIndexOf("/") + 1);
		String location = request.getParameter("location"); 
		if(location!=null)
		{
			methodName = location.substring(location.lastIndexOf("/") +1, location.lastIndexOf("?"));
		}
		System.out.println("Method Name : " + methodName);
		try {
			
			Method method = this.getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
			
		} catch (IllegalAccessException | IllegalArgumentException | 
				InvocationTargetException | SecurityException | NoSuchMethodException e) {
			e.printStackTrace();
		} 
	}
	
	//管理员基础解惑
	public void manageLicense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getQueryString();
		String location = request.getParameter("location"); 
		if(location!=null)
		{
			uri = location.substring(location.lastIndexOf("=")+1);
		}
		uri = URLDecoder.decode(uri, "UTF-8" );
		System.out.println("licenseDetailURL : " + uri);
		String name = uri.substring(uri.lastIndexOf("=") + 1);
		System.out.println("licenseDetailName : " + name);
		detailLicense license = detailDao.getByName(name);
		request.setAttribute("right", license.getRight());
		request.setAttribute("obligation", license.getObligation());
		request.setAttribute("prohibition", license.getProhibition());
		List<type> types = typeDao.getList();
		request.setAttribute("detail", license);
		request.setAttribute("type", types);
		request.getRequestDispatcher("/admin/manage_license.jsp").forward(request, response);
	}
	
	public void redirectAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/addLicense.jsp").forward(request, response);
	}
	
	public void addLicense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入addLicense");
		HttpSession session = request.getSession(false);
		Licenses licenses = new Licenses();
		String username = (String) session.getAttribute("username");
		user user = userDao.getUser("admin",username);
		licenses.setAdmin(user.getId());  
		licenses.setName(request.getParameter("name").replaceAll("\\n",""));  
		licenses.setAbstractName(request.getParameter("abstractName").replaceAll("\\n",""));  
		licenses.setAbbreviation((String) request.getParameter("abbreviation").replaceAll("\\n",""));  //
		licenses.setOwner((String)request.getParameter("owner").replaceAll("\\n",""));  
		licenses.setHistory(request.getParameter("history").replaceAll("\\n",""));  
		licenses.setOrigation((String) request.getParameter("origation").replaceAll("\\n",""));  
		licenses.setTranslation(request.getParameter("translation").replaceAll("\\n",""));  
		licenses.setType(Integer.parseInt(request.getParameter("type")));  
		licenses.setOriginURL(request.getParameter("originURL").replaceAll("\\n",""));  
		licenses.setSPDX(request.getParameter("SPDX").replaceAll("\\n",""));  
		licenses.setRight(request.getParameter("rightChecked").replaceAll("\\n",""));  
		licenses.setObligation(request.getParameter("obligationChecked").replaceAll("\\n",""));  
		licenses.setProhibition(request.getParameter("prohibitionChecked").replaceAll("\\n",""));  
		System.out.println(licenses.toString());
		LicensesDao.addOne(licenses);
		String success = "0";
		response.getWriter().print(success);
	}
	
	public void alterLicense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入alterLicense");
		HttpSession session = request.getSession(false);
		Licenses licenses = new Licenses();
		String username = (String) session.getAttribute("username");
		user user = userDao.getUser("admin",username);
		String license_name = (String) request.getParameter("license_name").replaceAll("\\n","");
		licenses.setAdmin(user.getId());  
		licenses.setName(request.getParameter("name").replaceAll("\\n",""));  
		licenses.setAbstractName(request.getParameter("abstractName").replaceAll("\\n",""));  
		licenses.setAbbreviation((String) request.getParameter("abbreviation").replaceAll("\\n",""));  //
		licenses.setOwner((String)request.getParameter("owner").replaceAll("\\n",""));  
		licenses.setHistory(request.getParameter("history").replaceAll("\\n",""));  
		licenses.setOrigation((String) request.getParameter("origation").replaceAll("\\n",""));  
		licenses.setTranslation(request.getParameter("translation").replaceAll("\\n",""));  
		licenses.setType(Integer.parseInt(request.getParameter("type")));  
		licenses.setOriginURL(request.getParameter("originURL").replaceAll("\\n",""));  
		licenses.setSPDX(request.getParameter("SPDX").replaceAll("\\n",""));  
		licenses.setRight(request.getParameter("rightChecked").replaceAll("\\n",""));  
		licenses.setObligation(request.getParameter("obligationChecked").replaceAll("\\n",""));  
		licenses.setProhibition(request.getParameter("prohibitionChecked").replaceAll("\\n",""));  
		System.out.println(licenses.toString());
		LicensesDao.alterOne(license_name,licenses);
		String success = "0";
		response.getWriter().print(success);
	}
	
	public void deleteLicense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入alterLicense");
		String license_name = (String) request.getParameter("license_name").replaceAll("\\n","");
		LicensesDao.deleteOne(license_name);
		String success = "0";
		response.getWriter().print(success);
	}

	public void manageFqa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getQueryString();
		String param = uri.substring(uri.lastIndexOf("=") + 1);
		int page = Integer.parseInt(param);
		List<fqa> fqas = fqaDao.getPage((page-1)*10,10);
		fqa count = fqaDao.getCount();
		int allpage = count.getCount();
		request.setAttribute("fqa", fqas);
		request.setAttribute("indexpage", String.valueOf(page));
		request.setAttribute("allpage", String.valueOf(allpage));
		request.getRequestDispatcher("/admin/manage_fqa.jsp").forward(request, response);
	}
	
	public void addFqa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入addFqa");
		HttpSession session = request.getSession(false);
		fqa addfqa = new fqa();
		long time = System.currentTimeMillis();
		java.sql.Date date = new java.sql.Date(time);
		String admin = (String) session.getAttribute("username");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		addfqa.setAdmin(admin);  //设置管理员名
		addfqa.setQuestion(question);  //设置问题
		addfqa.setAnswer(answer);  //设置回答
		addfqa.setDate(date);  //设置日期
		fqaDao.addOne(addfqa);
		System.out.println("admin:"+admin+";question:"+question+";answer:"+answer+";date:"+date.toString());
		String success = "0";
		response.getWriter().print(success);
	}
	
	public void alterFqa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入alterFqa");
		HttpSession session = request.getSession(false);
		fqa addfqa = new fqa();
		long time = System.currentTimeMillis();
		java.sql.Date date = new java.sql.Date(time);
		String admin = (String) session.getAttribute("username");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		addfqa.setAdmin(admin);  //设置管理员名
		addfqa.setQuestion(question);  //设置问题
		addfqa.setAnswer(answer);  //设置回答
		addfqa.setDate(date);  //设置日期
		fqaDao.alterOne(addfqa);
		System.out.println("admin:"+admin+";question:"+question+";answer:"+answer+";date:"+date.toString());
		String success = "0";
		response.getWriter().print(success);
	}
	
	public void deleteFqa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("deleteFqa");
		String question = request.getParameter("question");
		fqaDao.deleteOne(question);
		String success = "0";
		response.getWriter().print(success);
	}
}
