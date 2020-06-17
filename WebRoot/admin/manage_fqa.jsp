<%@ page 
    language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
<%
    List<fqa> fqas = (List<fqa>) request.getAttribute("fqa"); 
    String paramindex = (String)request.getAttribute("indexpage"); 
    String paramall = (String)request.getAttribute("allpage"); 
    int indexpage = Integer.parseInt(paramindex);
    int allpage = (int)Math.ceil(Integer.parseInt(paramall)/10)+1;
    if(application.getAttribute("onlineCount")==null)
    {
        application.setAttribute("onlineCount", 0);  
    }
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>管理中心</title>
    <link rel="stylesheet" href="/opensource/css/bootstrap.min.css">  
    <link rel="stylesheet" type="text/css" href="/opensource/css/style.css" />
</head>
<body style="background-color:#f5f5f5">
    <!--导航栏-->
    <div class="row box" style="background-color:#000; font-size:16px">
        <div class="" id="myNavbar" style="min-height:81px;">
            <img src="/opensource/images/icon/logo.png" width=52px height=52px class="img-circle nav navbar-nav" 
            style="margin-left:12vw;transform: translateY(14px);">
            <ul class="nav navbar-nav sethover" style="text-align:center; margin-right:260px" >
                <li class="active dropdown"><a href="/opensource/admin/index.jsp">管理中心</a></li>
                <li class="active dropdown"><a href="/opensource/admin/manage/manageFqa?page=1">知识库</a></li>
                <li class="active dropdown"><a href="/opensource/admin/manage/manageLicense?license_name=许可证1">许可证管理</a></li>
            </ul>
            <ul class="nav navbar-nav">
                <form class="bs-example bs-example-form" role="form">  
                    <div class="input-group input-group-btn">
                        <button type="button" class="btn btn-default dropdown-toggle" 
                        data-toggle="dropdown" id="search-choose">
                            许可证<span class="glyphicon glyphicon-chevron-down" style=" margin-left:5px"></span>
                        </button>
                        <ul class="dropdown-menu search-list">
                            <li>
                                <a href="#">许可证</a>
                            </li>
                            <li>
                                <a href="#">认证方</a>
                            </li>
                            <li>
                                <a href="#">全部</a>
                            </li>
                        </ul>
                    </div><!-- /input-group -->
                </form>
            </ul>
            <input type="text" placeholder="请输入内容" class="form-control" style="display:inline; margin:25px 0 0 35px; width:120px">
            <button style=" margin:0 30px 0 0; background-color:transparent;color:#999;border:0;" href="#"> 
                <span class="glyphicon glyphicon-search search-icon"></span>
            </button>
            <div style="display:inline-block; width:150px" id="userinfo">
                <a href="#" class="login" id="login-admin">管理员</a>
                <span style="padding:0 5px 0 5px">●</span>
                <a href="#" class="login" id="login-common">普通用户</a>
            </div>
        </div>
    </div>
    <div class="mask"> </div><!--导航栏结束-->
    <div class="container row-style ">
        <div class="row">
          <div class="col-md-10 text-center col-md-offset-1 col-style" style="background-color: #fff" id="content">
            <div class="row title">
                <p class="common-title text-align-center" style="line-height: 50px">
                    <span>基础解惑</span>
                    <a class="content-total-time" style="position: absolute;right:36px" id="fqa-add"><span>新增</span></a>
                </p>
            </div>
            <%
                int num = (indexpage-1)*10+1;
                for (fqa fqa : fqas) {
                    out.println("<div class=\"row\"><div class=\"content-total text-align-right\" ><p style=\"width:600px;  word-wrap: break-word; display:inline-block\">"
                        +num+"、"+"<span class='question'>"+fqa.getQuestion()+"</span>"
                        +"</p><span class=\"float-right  content-total-time \" style=\"padding-top:7px\"><a class='fqa-alter'><span>修改</span></a>"
                        +"<a class='fqa-delete'><span class=\"padding-left-50\">删除"
                        +"</span></a></span></div><div><p status=\"0\" class=\"text close_text content-article text-align-right answer\">"
                        +fqa.getAnswer()
                        +"</p><div class=\"text-align-right show_more\"><a href=\"javascript:void(0);\" class=\"show_more_btn\">查看更多</a>"
                        +"</div></div><div class=\"line\"></div></div>");
                    num++;
                }
            %>
            <div class="row" style="margin:18px 0 68px 0;">
                <ul class="pagination">
                    <li>
                        <a href="/opensource/license/fqa?page=1">首页</a>
                    </li>
                    <% 
                        int prev = (indexpage-1>0) ? (indexpage-1):1;
                        int next = (indexpage+1>=allpage) ? allpage:(indexpage+1);
                        out.println("<li><a href=\"/opensource/license/fqa?page="+prev+"\">&laquo;</a></li>"); 
                        if(allpage<=5)
                        {
                            for(int i=1;i<=allpage;i++)
                            { 
                                if(i==indexpage)
                                {
                                    out.println("<li><a class=\"page-a\" href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                }
                                else
                                {
                                    out.println("<li><a href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                }
                            } 
                        }
                        else
                        { 
                            if(indexpage<allpage-2&&indexpage-2>0)
                            {
                                for(int i=indexpage-2;i<=indexpage+2;i++)
                                { 
                                    if(i==indexpage)
                                    {
                                        out.println("<li><a class=\"page-a\" href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                    }
                                    else
                                    {
                                        out.println("<li><a href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                    }
                                }
                            }
                            else if(indexpage<allpage-2&&indexpage-2<1)
                            {
                                for(int i=1;i<=5;i++)
                                { 
                                    if(i==indexpage)
                                    {
                                        out.println("<li><a class=\"page-a\" href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                    }
                                    else
                                    {
                                        out.println("<li><a href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                    }
                                }
                            }
                            else
                            {
                                for(int i=allpage-5;i<=allpage;i++)
                                { 
                                    if(i==indexpage)
                                    {
                                        out.println("<li><a class=\"page-a\" href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                    }
                                    else
                                    {
                                        out.println("<li><a href=\"/opensource/license/fqa?page="+i+"\">"+i+"</a></li>");
                                    }
                                }
                            }
                        } 
                        out.println("<li><a href=\"/opensource/license/fqa?page="+next+"\">&raquo;</a></li>");
                        out.println("<li><a href=\"/opensource/license/fqa?page="+allpage+"\">尾页</a></li>");
                    %>
                    </ul>
                </div>
           </div>
        </div>
    </div>
    <!--填写框-->
    <div id="fqa-table">  
        <div class="third-title color-white" style="background-color:#000;color:#fff">
            <span style="margin-left: 20px" id="fqa-type">新增</span>
            <a class="fqa-close">
                <span class="glyphicon glyphicon-remove-circle" style="float: right;top:16px;right: 16px">
                </span>
            </a>
        </div>
        <form id="fqainfo" action="/opensource/login">
            <p class="third-title" style="text-align: left; padding-left: 25px">问题：</p>
            <textarea id="submit-question" style="width: 90%;padding:0;line-height: 25px" rows="2"></textarea>
            <p class="third-title" style="text-align: left; padding-left: 25px">回答：</p>
            <textarea id="submit-answer" style="width: 90%;padding:0;line-height: 25px" rows="4"></textarea>
            <p class="third-title" style="text-align:center;">
                <a id="fqa-button"><span>提交</span></a>
            </p>
            <p style="left:40%;bottom: -9px; position: absolute;color: red" id="fqa-response"></p>
        </form>
    </div><!---->
    <div id="aaaa"></div>
    <!--页脚-->
    <div class="otherfoot">
        <img src="/opensource/images/icon/logo.png" width=60px height=60px class="img-circle" style="margin-left:20vw; border:0;">
        <div class="othercopyright">
            Copyright &copy; 西南大学<a href="http://www.swu.edu.cn/" target="_blank" title="西南大学">www.swu.edu.cn</a> 
           
        </div> 
        <div style="float:right;margin-right:20vw;">在线人数:&nbsp;
            <span id="online"><%=application.getAttribute("onlineCount")%></span>
        </div>
    </div> <!--页脚结束-->
</body>
    <script type="text/javascript" src="/opensource/js/jquery-3.5.1.min.js"></script> 
    <script type="text/javascript" src="/opensource/js/jquery.cookie.js"></script> 
    <script type="text/javascript" src="/opensource/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/opensource/js/fqa.js"></script>
    <script type="text/javascript" src="/opensource/js/manage.js"></script>
    <script type="text/javascript" src="/opensource/js/common.js"></script>  
    <%
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
    let sessionID = "${sessionID}";
    let usertype = "${usertype}";
    let username = "${username}";
    //alert("sessionID:"+sessionID+";usertype:"+usertype+";username:"+username);
    if(sessionID!=""&&usertype!=""&&username!="")
    {
        $("#userinfo").html("");
        let append = "<span class='login hover-white'>" + username + "</span>";
        append += "<span style='padding:0 5px 0 5px'>●</span>";
        append += "<a class='login' id='admin-logout'>退出</a>";
        $("#userinfo").append(append);
        console.log("进入判断  sessionID:"+sessionID+",  username:"+username+",  usertype:"+usertype);
    }
    $("#admin-logout").click(function(){
        $.post("/opensource/logout", null, function(data){
            if(data==="0")
            {
                window.location.href("/opensource/index.jsp");
            }
        });
    }); 
</script>

</html>
