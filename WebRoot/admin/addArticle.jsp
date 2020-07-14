<%@ page 
    language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    if(application.getAttribute("onlineCount")==null)
    {
        application.setAttribute("onlineCount", 0);  
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增文章</title>
    <link rel="stylesheet" href="/opensource/css/bootstrap.min.css">  
    <link rel="stylesheet" type="text/css" href="/opensource/css/style.css" />
</head>
<body style="background-color:#f5f5f5">
    <!--导航栏-->
    <div class="row box" style="background-color:#000; font-size:16px">
        <div class="" id="myNavbar" style="min-height:81px;">
            <img src="/opensource/images/icon/logo.png" width=52px height=52px class="img-circle nav navbar-nav" 
            style="margin-left:12vw;transform: translateY(14px);">
            <ul class="nav navbar-nav sethover" style="text-align:center; margin-right:160px" >
                <li class="active dropdown"><a href="/opensource/admin/index.jsp">管理中心</a></li>
                <li class="active dropdown"><a href="/opensource/admin/manage/manageFqa?page=1">知识库</a></li>
                <li class="active dropdown"><a href="/opensource/admin/manage/manageArticle?page=1">文章库</a></li>
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
        <div class="row" style="font-size: 16px">
            <div class="col-md-10 text-center col-md-offset-1 col-style" style="background-color: #fff" id="content">
                <p class="second-title text-align-center">
                    <span>新增文章</span>
                </p>
                <p class="third-title" style="text-align: left;">文章标题：</p>
                <textarea id="add-title" style="width: 100%;padding:0;line-height: 25px" rows="2"></textarea>
                <br>
                <br>
                <p class="third-title" style="text-align: left;">摘要：</p>
                <textarea id="add-introduction" style="width:100%;padding:0;line-height: 25px" rows="2"></textarea>
                <br>
                <br>
                <p class="third-title" style="text-align: left;">回答：</p>
                <textarea id="add-content" style="width:100%;padding:0;line-height: 25px" rows="13"></textarea>
                <br>
                <br>
                <p class="third-title" style="text-align:center;">
                <button id="article-add" class="btn button-blue" style="margin:10px 0 20px 0">提交</button> 
                </p>
                <p id="article-response" style="text-align:center;bottom: -9px;color: red"></p>
                <br>
            </div>
        </div>
    </div>
    <!--页脚-->
    <div class="otherfoot">
        <img src="/opensource/images/icon/logo.png" width=60px height=60px class="img-circle" style="margin-left:20vw; border:0;">
        <div class="othercopyright">
            Copyright &copy; 西南大学<a href="http://www.swu.edu.cn/" target="_blank" title="西南大学">www.swu.edu.cn</a> 
           
        </div> 
        <div style="float:right;margin-right:20vw;">在线人数:&nbsp;
            <span id="online">${onlineCount}</span>
        </div>
    </div> <!--页脚结束-->
    <input type="hidden" name="username" value="${username}"/>
</body>
    <script type="text/javascript" src="/opensource/js/jquery-3.5.1.min.js"></script> 
    <script type="text/javascript" src="/opensource/js/jquery.cookie.js"></script> 
    <script type="text/javascript" src="/opensource/js/bootstrap.min.js"></script>
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
                window.location.href="/opensource/index.jsp";
            }
        });
    }); 
    $(document).ready(function(){
        $("#content").css("min-height",$(window).height()-181);
    });
    $(window).resize(function () {
        $("#content").css("min-height",$(window).height()-181);
    });
</script>

</html>
