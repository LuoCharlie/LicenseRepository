<%@ page 
	language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
<%
	List list=null;

String listLength = (String)request.getAttribute("listLength");
	String showlist="";
	if(session.getAttribute("downLicense")!=null){  
		list = (List)session.getAttribute("downLicense");  
		int listlength = list.size();
    	pageContext.setAttribute("listlength",listlength);
		for(int i=0;i<listlength;i++) 
 	    {
 	    	showlist += "<tr><td><span>" + (i+1) +"、" +list.get(i)+ "</span></td><td><a class='forth-title delete'><span>删除</span></a></td></tr>";
 	    }
     }	
	Cookie cookie = null;
	Cookie[] cookies = null;
	cookies = request.getCookies();
	if( cookies != null )
	{
		for (int i = 0; i < cookies.length; i++)
		{
			cookie = cookies[i];
			if(cookie.getName().equals("JSESSIONID"))
			{
				pageContext.setAttribute("sessionID", cookie.getName());
			}
		}
	}
	pageContext.setAttribute("usertype", request.getSession().getAttribute("usertype"));
	pageContext.setAttribute("username", request.getSession().getAttribute("username"));
%>
<script> 
  $(document).ready(function(){
    var listlength = $(".download-table").children("tr").listlength-1;
            console.log("length"+listlength);
    	$(".download-table").append("<%=showlist%>");
    	$(".download-table").on("click","a",function(){  //下载列表删除
            let nowthis = $(this).parent().prev().text();
            var index = nowthis.indexOf("、");
            nowthis = nowthis.slice(index+1).replace(/[\r\n]/g,""); 
            $.post("../license/delDownloadList", { "licenseName": nowthis}, function(data){
                if(data=="-1")
                {
                    alert("删除失败!");
                }
                else
                    {
                        $(".download-table").html("<tr><td style=\"width: 85%\"></td> <td style=\"width: 15%\"></td></tr>");
                        let listjson = JSON.parse(decodeURIComponent(data));
                        let addstring = "";
                        for(var i = 0; i < listjson.length; i++) {
                            addstring += "<tr><td><span>" + (i+1) +"、" + listjson[i] + "</span></td><td><a  class='forth-title' id='logout'><span>删除</span></a></td></tr>"   
                        }
                        $(".download-table").append(addstring);
                    }
            });
        });
    	$("#choose-download").click(function()
    	{	
    		let sessionID = "${sessionID}";
    		let usertype = "${usertype}";
    		let username = "${username}";
   	   		if(sessionID==""||usertype==""||username=="")
	    	{
	    		alert('请先登录');
	    	}
   	   		else
   	   		{
	   			let name = $("#license_name").text();
                name = name.replace(/[\r\n]/g,"");        
	   			$.post("../license/addDownloadList", { "licenseName": name}, function(data){
			   		if(data==="-1")
			   		{
			   			alert("请勿重复添加！");
			   		}
            else if(data==="-2")
            {
                alert("最多添加十个！");
            }
            else
            {
            	$(".download-table").html("<tr><td style=\"width: 85%\"></td> <td style=\"width: 15%\"></td></tr>");
                alert("已添加到下载列表!");
                let listjson = JSON.parse(decodeURIComponent(data));
                let addstring = "";
                for(var i = 0; i < listjson.length; i++) {
                	addstring += "<tr><td><span>" + (i+1) +"、" + listjson[i] + "</span></td><td><a  class='forth-title delete'><span>删除</span></a></td></tr>"   
						}
                        $(".download-table").append(addstring);
                    }
	   			});
   	   		}
   		});
    	$("#try-download").click(function(){
    		let sessionID = "${sessionID}";
    		let usertype = "${usertype}";
    		let username = "${username}";
   	   		if(sessionID==""||usertype==""||username=="")
	    	{
   	   			alert('请先登录!');
	    	}
   	   		else
   	   		{
   	   			if(listlength<1)
   	   			{
   	   				alert("请先添加许可证!");
   	   			}
   	   			else
   	   			{
		    		location.href="/opensource/license/download";
		    		$(".download-table").html("<tr><td style=\"width: 85%\"></td> <td style=\"width: 15%\"></td></tr>");
   	   			}
   	   		}
    	});
  });
</script>