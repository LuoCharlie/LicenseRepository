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
import com.opensource.Dao.descriptionDao;
import com.opensource.Dao.detailDao;
import com.opensource.Dao.fqaDao;
import com.opensource.Dao.downloadDao;
import com.opensource.Dao.articleDao;
import com.opensource.Domain.description;
import com.opensource.Domain.detailLicense;
import com.opensource.Domain.featureLicense;
import com.opensource.Domain.type;
import com.opensource.Domain.fqa;
import com.opensource.Domain.downloadLicense;
import com.opensource.Domain.article;

public class licenseServlet extends HttpServlet
{
	private static final long serialVersionUID = 1174461738374924975L;
	private featureDao featureDao = new featureDao();
	private detailDao detailDao = new detailDao();
	private typeDao typeDao = new typeDao();
	private fqaDao fqaDao = new fqaDao();
	private downloadDao downloadDao = new downloadDao();
	private descriptionDao discriptionDao = new descriptionDao();
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
	
	//搜索引擎
	public void searchEngine(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
    	System.out.println("接收到请求");
        response.setContentType("text/html");
        String dataRights = request.getParameter("rights");
        String dataObligations = request.getParameter("obligations");
        String dataProhibition = request.getParameter("prohibition"); 
        String r[]  = dataRights.split(",");
        String o[]  = dataObligations.split(",");
        String p[]  = dataProhibition.split(",");
        ArrayList <String> rights = new ArrayList<String>();
        for(int i=0;i<r.length;i++){
        	rights.add(r[i]);
        }
        Collections.sort(rights,comparator);
        System.out.println("rights:"+rights);
        ArrayList <String> obligations = new ArrayList<String>();
        for(int i=0;i<o.length;i++){
        	obligations.add(o[i]);
        }
        Collections.sort(obligations,comparator);
        System.out.println("obligation:"+obligations);
        ArrayList <String> prohibition = new ArrayList<String>();
        for(int i=0;i<p.length;i++){
        	prohibition.add(p[i]);
        }
		Collections.sort(prohibition,comparator);
        System.out.println("prohibition:"+prohibition);
		System.out.println("getList : ");
		List<featureLicense> license = featureDao.searchByFeature(rights,obligations,prohibition);
		//request.setAttribute("license", license);
		HttpSession session = request.getSession(true);
		session.setAttribute("featureLicense", license);
		response.getWriter().print("0");
	}

	public void getAll(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		List<featureLicense> books = featureDao.getList();
		request.setAttribute("license", books);
		request.getRequestDispatcher("../test.jsp").forward(request, response);
	}
	
	//许可证列表详情
	public void licenseDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		List<type> types = typeDao.getList();
		String[] rights = license.getRight().split(",");
		System.out.println(rights.toString());
		String[] obligations = license.getObligation().split(",");
		System.out.println(obligations.toString());
		String[] prohibitions = license.getProhibition().split(",");
		System.out.println(prohibitions.toString());
		List<description> right = discriptionDao.getByList("权利",rights);
		List<description> obligation = discriptionDao.getByList("义务",obligations);
		List<description> prohibition = discriptionDao.getByList("禁止",prohibitions);
		request.setAttribute("right", right);
		request.setAttribute("obligation", obligation);
		request.setAttribute("prohibition", prohibition);
		request.setAttribute("detail", license);
		request.setAttribute("type", types);
		request.getRequestDispatcher("/license_list.jsp").forward(request, response);
	}
	
	//基础解惑
	public void fqa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getQueryString();
		String param = uri.substring(uri.lastIndexOf("=") + 1);
		int page = Integer.parseInt(param);
		List<fqa> fqas = fqaDao.getPage((page-1)*10,10);
		fqa count = fqaDao.getCount();
		int allpage = count.getCount();
		request.setAttribute("fqa", fqas);
		request.setAttribute("indexpage", String.valueOf(page));
		request.setAttribute("allpage", String.valueOf(allpage));
		request.getRequestDispatcher("/basis_to_reassure.jsp").forward(request, response);
	}
	
	//文章列表
		public void article(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String uri = request.getQueryString();
			String param = uri.substring(uri.lastIndexOf("=") + 1);
			int page = Integer.parseInt(param);
			List<article> articles = articleDao.getPage((page-1)*10,10);
			article count = articleDao.getCount();
			int allpage = count.getCount();
			request.setAttribute("article", articles);
			request.setAttribute("indexpage", String.valueOf(page));
			request.setAttribute("allpage", String.valueOf(allpage));
			request.getRequestDispatcher("/article_list.jsp").forward(request, response);
		}
	//文章详情
	public void articleMore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getQueryString();
		String param = uri.substring(uri.lastIndexOf("=") + 1);
		int id = Integer.parseInt(param);
		article article = articleDao.getOne(id);
		request.setAttribute("article", article);
		request.getRequestDispatcher("/article.jsp").forward(request, response);
	}
	
	//下载
	public void download(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		List<downloadLicense> downtable = (List<downloadLicense>) session.getAttribute("downtable");
		if(downtable==null)
		{
			String error = "-1";
			response.getWriter().print(error);
		}
		System.out.println("\n进入download");
		String url = com.opensource.Tool.createExcel.getExcel(downtable,"./");
		System.out.println(url);
		File f = new File(url);  
        if(f.exists()){  
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
            com.opensource.Tool.createExcel.deleteFile(filename);
        }
        List<String> list = new ArrayList<>();
        session.setAttribute("downLicense", list);
	}
	
	
	//添加许可证到下载列表
	public void addDownloadList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		List<String> list = (List<String>) session.getAttribute("downLicense");
		List<downloadLicense> downtable=(List<downloadLicense>) session.getAttribute("downtable");
		if(list==null||downtable==null)
		{
			list=new ArrayList<>();
			downtable=new ArrayList<>();
			
		}
		String licenseName = request.getParameter("licenseName");
		if(list.contains(licenseName))
		{
			String error = "-1";
			response.getWriter().print(error);
		}
		else
		{
			if(list.size()<11)  //最多只能添加10个进入列表
			{
				//查询并获取许可证
				downloadLicense license = downloadDao.getOne(licenseName);
				downtable.add(license);
				//向下载列表添加许可证名
				list.add(licenseName);
				//将下载内容和列表放入session
				session.setAttribute("downtable", downtable);
				session.setAttribute("downLicense", list);
				session.setAttribute("listLength", list.size());
				JSONArray json = new JSONArray();
				for(String value:list)
				{
					json.put(value);
				}
				System.out.println(json.toString());
				response.getWriter().print(URLEncoder.encode(json.toString(), "UTF-8" ));
			}
			else
			{
				String error = "-2";
				response.getWriter().print(error);
			}
		}
        System.out.println(list.toString());
	}
	
	//删除下载列表中的许可证
	public void delDownloadList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		List<String> list = (List<String>) session.getAttribute("downLicense");
		List<downloadLicense> downtable=(List<downloadLicense>) session.getAttribute("downtable");
		String licenseName = request.getParameter("licenseName");
		for (String s : list) {
			System.out.println("string s:"+s+",  licenseName:"+licenseName);
			System.out.println("isequal"+s.equals(licenseName));
            if (s.equals(licenseName)) {
            	System.out.println("相等");
                list.remove(s);
                break;
            }
        }
		for (downloadLicense item : downtable) {
			System.out.println("string s:"+item.getName()+",  licenseName:"+licenseName);
			System.out.println("isequal"+item.getName().equals(licenseName));
            if (item.getName().equals(licenseName)) {
            	System.out.println("相等");
            	downtable.remove(item.getName());
                break;
            }
        }
		System.out.println("list:"+list.toString());
		session.setAttribute("downLicense", list);
		session.setAttribute("downtable", downtable);
		JSONArray json = new JSONArray();
		for(String value:list)
		{
			json.put(value);
		}
		System.out.println(json.toString());
		response.getWriter().print(URLEncoder.encode(json.toString(), "UTF-8" ));
	}
}
