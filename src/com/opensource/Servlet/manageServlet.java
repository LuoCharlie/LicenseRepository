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
import com.opensource.Dao.typeDao;
import com.opensource.Dao.userDao;
import com.opensource.Dao.LicensesDao;
import com.opensource.Dao.articleDao;
import com.opensource.Dao.detailDao;
import com.opensource.Dao.fqaDao;
import com.opensource.Domain.Licenses;
import com.opensource.Domain.article;
import com.opensource.Domain.detailLicense;
import com.opensource.Domain.type;
import com.opensource.Domain.user;
import com.opensource.Domain.fqa;
import com.opensource.Tool.createExcel;

import jxl.read.biff.BiffException;

public class manageServlet extends HttpServlet
{
	private static final long serialVersionUID = 1174461738374924975L;
	private detailDao detailDao = new detailDao();
	private typeDao typeDao = new typeDao();
	private fqaDao fqaDao = new fqaDao();
	private LicensesDao LicensesDao = new LicensesDao();
	private articleDao articleDao = new articleDao();
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
	
	public void redirectAddArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/addArticle.jsp").forward(request, response);
	}
	
	public void addLicense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入addLicense");
		HttpSession session = request.getSession(false);
		Licenses licenses = new Licenses();
		licenses.setAdmin((String) session.getAttribute("username"));  
		licenses.setName(request.getParameter("name").replaceAll("\\n",""));  
		licenses.setAbstractName(request.getParameter("abstractName"));  
		licenses.setAbbreviation((String) request.getParameter("abbreviation").replaceAll("\\n",""));  //
		licenses.setOwner((String)request.getParameter("owner").replaceAll("\\n",""));  
		licenses.setHistory(request.getParameter("history"));  
		licenses.setOrigation((String) request.getParameter("origation"));  
		licenses.setTranslation(request.getParameter("translation"));  
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
		String license_name = (String) request.getParameter("license_name").replaceAll("\\n","");
		licenses.setAdmin((String) session.getAttribute("username"));  
		licenses.setName(request.getParameter("name").replaceAll("\\n",""));  
		licenses.setAbstractName(request.getParameter("abstractName"));  
		licenses.setAbbreviation((String) request.getParameter("abbreviation").replaceAll("\\n",""));  //
		licenses.setOwner((String)request.getParameter("owner").replaceAll("\\n",""));  
		licenses.setHistory(request.getParameter("history"));  
		licenses.setOrigation((String) request.getParameter("origation"));  
		licenses.setTranslation(request.getParameter("translation"));  
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
	
	public void downTemplate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getQueryString();
		String template = uri.substring(uri.lastIndexOf("=") + 1);
		System.out.println("templateName : " + template);
		String path = this.getServletContext().getRealPath("/admin/template");
		String file = "/" + template;
		System.out.println(path + file);
		File f = new File(path + file);  
        if(f.exists()){  
        	System.out.println("存在文件");
        	FileInputStream  fis = new FileInputStream(f);  
            String filename = URLEncoder.encode(f.getName(),"utf-8"); //解决中文文件名下载后乱码的问题  
            byte[] b = new byte[fis.available()];  
            fis.read(b);  
            response.setCharacterEncoding("utf-8");  
            response.setHeader("Content-Disposition","attachment; filename="+filename+"");  
            //获取响应报文输出流对象  
            ServletOutputStream  out =response.getOutputStream();  
            //输出  
            out.write(b);  
            out.flush();  
            out.close(); 
            fis.close();
		}
        else
        {
        	response.sendRedirect("/opensource/admin/index.jsp");
        }
	}
	
	public void upload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, BiffException {
		HttpSession session = request.getSession(false);
		String uri = request.getQueryString();
		String uploadType = uri.substring(uri.lastIndexOf("=") + 1);
		String admin = (String) session.getAttribute("username");
		String filepath = com.opensource.Tool.uploadFile.upload(request,response);
		System.out.println("uploadType : " + uploadType);
		switch(uploadType)
		{
			case "fqa":
				System.out.println("filepath : " + filepath);
				List<List> excelFqa = com.opensource.Tool.createExcel.readExcel("fqa",admin,filepath);
				//System.out.println("excelDate:"+excelData.toString());
				fqaDao.addList(excelFqa);
				break;
			case "article":
				System.out.println("filepath : " + filepath);
				List<List> excelArticle = com.opensource.Tool.createExcel.readExcel("article",admin,filepath);
				//System.out.println("excelDate:"+excelData.toString());
				articleDao.addList(excelArticle);
				break;
			case "license":
				System.out.println("filepath : " + filepath);
				List<List> excelLicense = com.opensource.Tool.createExcel.readExcel("license",admin,filepath);
				LicensesDao.addList(excelLicense);
				break;
				
		}
		com.opensource.Tool.createExcel.deleteFile(filepath);
		response.sendRedirect("/opensource/admin/index.jsp");
	}
	
	public void manageArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getQueryString();
		String param = uri.substring(uri.lastIndexOf("=") + 1);
		int page = Integer.parseInt(param);
		List<article> articles = articleDao.getPage((page-1)*10,10);
		article count = articleDao.getCount();
		int allpage = count.getCount();
		request.setAttribute("article", articles);
		request.setAttribute("indexpage", String.valueOf(page));
		request.setAttribute("allpage", String.valueOf(allpage));
		request.getRequestDispatcher("/admin/manage_article.jsp").forward(request, response);
	}
	
	//文章详情
	public void alterArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String uri = request.getQueryString();
		String param = uri.substring(uri.lastIndexOf("=") + 1);
		int id = Integer.parseInt(param);
		article article = articleDao.getOne(id);
		request.setAttribute("article", article);
		session.setAttribute("usertype", session.getAttribute("usertype"));
		session.setAttribute("username", session.getAttribute("username"));
		request.getRequestDispatcher("/admin/alterArticle.jsp").forward(request, response);
	}
	
	public void doAlterArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入doAlterArticle");
		HttpSession session = request.getSession(false);
		article addarticle = new article();
		long time = System.currentTimeMillis();
		java.sql.Date date = new java.sql.Date(time);
		int id = Integer.parseInt(request.getParameter("id"));
		addarticle.setAdmin((String) session.getAttribute("username"));  //设置管理员名
		addarticle.setTitle(request.getParameter("title"));  //设置问题
		addarticle.setContent(request.getParameter("content"));  //设置回答
		addarticle.setIntroduction(request.getParameter("introduction"));  //设置回答
		addarticle.setDate(date);  //设置日期
		articleDao.alterOne(id,addarticle);
		//System.out.println("admin:"+admin+";question:"+question+";answer:"+answer+";date:"+date.toString());
		String success = "0";
		response.getWriter().print(success);
	}
	
	public void addArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入addArticle");
		HttpSession session = request.getSession(false);
		article addarticle = new article();
		long time = System.currentTimeMillis();
		java.sql.Date date = new java.sql.Date(time);
		String admin = (String) session.getAttribute("username");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		addarticle.setAdmin((String) session.getAttribute("username"));  //设置管理员名
		addarticle.setTitle(request.getParameter("title"));  //设置问题
		addarticle.setContent(request.getParameter("content"));  //设置回答
		addarticle.setIntroduction(request.getParameter("introduction"));  //设置回答
		addarticle.setDate(date);  //设置日期
		articleDao.addOne(addarticle);
		System.out.println("admin:"+admin+";question:"+question+";answer:"+answer+";date:"+date.toString());
		String success = "0";
		response.getWriter().print(success);
	}
	
	public void deleteArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("deleteArticle");
		String uri = request.getQueryString();
		String param = uri.substring(uri.lastIndexOf("=") + 1);
		int id = Integer.parseInt(param);
		article article = articleDao.deleteOne(id);
		String success = "0";
		String requestUrl = request.getHeader("referer");
		response.sendRedirect(requestUrl);
	}
}
