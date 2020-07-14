<%@ page 
    language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
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
	<title>搜索引擎</title>
    <link rel="stylesheet" href="/opensource/css/bootstrap.min.css">  
    <link rel="stylesheet" type="text/css" href="/opensource/css/style.css" />
</head>
<body style="background-color:#FFF">
    <!--导航栏-->
    <div class="row box" style="background-color:#000; font-size:16px">
        <div class="" id="myNavbar" style="min-height:81px;">
            <img src="/opensource/images/icon/logo.png" width=52px height=52px class="img-circle nav navbar-nav" 
            style="margin-left:12vw;transform: translateY(14px);">
            <ul class="nav navbar-nav sethover" style="text-align:center; margin-right:60px" >
                <li class="active dropdown"><a href="/opensource/index.jsp">首页</a></li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">开源解惑</a>
                    <ul class="dropdown-menu">
                        <li><a href="/opensource/license/fqa?page=1"">基础解惑</a></li>
                        <li><a href="/opensource/license/article?page=1">开源知识</a></li>
                    </ul>                  
                </li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">许可证</a>
                    <ul class="dropdown-menu">
                        <li><a href="/opensource/license/licenseDetail?license_name=许可证1">许可证列表</a></li>
                    </ul>
                </li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">许可证工具</a>
                    <ul class="dropdown-menu">
                        <li><a href="/opensource/search_engine.jsp">搜索引擎</a></li>
                    </ul>
                </li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">关于我们</a>
                    <ul class="dropdown-menu">
                    </ul>
                </li>
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

	<div style="display: flex;display: flex;justify-content: center;"> 
    	<div class="mask"> </div>  
        
        <form id="registerinfo" action="/opensource/login">
            <p class="common-title" style="text-align:center;margin-top: 50px; ">注册</p>
            <table style="margin-top: 8%;margin-left: 100px" class="forth-title">
                <tbody>
                    <tr>
                            <td style="width: 5%"></td>
                            <td style="width: 80px">用户名：</td>
                            <td><input type="text" name="registername" value="" placeholder="请输入登录名"  maxlength="16" 
                                style="width: 120px;">
                                <span style="font-weight:200;font-size: 12px">以数字、字母开头，不能使用特殊字符
                                </span>
                            </td>
                            <td></td>
                    </tr>
                    <tr>
                            <td></td>
                            <td>密码：</td>
                            <td id="passwd"><input type="password" name="registerpassword" value="" placeholder="请输入大于6位的密码" 
                                maxlength="16" style="width: 150px;">
                                <span class="glyphicon glyphicon-ok-sign"></span>
                            </td>
                            <td></td>
                    </tr>
                    <tr>
                            <td></td>
                            <td>确认密码：</td>
                            <td id="passwd-check"><input type="password" value="" placeholder="请重复密码" 
                                maxlength="16" style="width: 150px;">
                                <span class="glyphicon glyphicon-ok-sign"></span>
                            </td>
                            <td></td>
                    </tr>
                    <tr>
                            <td></td>
                            <td>验证码：</td>
                            <td>
                                <input type="text" name="registercode" maxlength="4" style="width: 50px;">
                                <img id="registercodeImg" src="/opensource/imageCode">
                                <a id="notsee" href="javascript:registerchangeImg();">点击更换</a>
                            </td>
                            <td></td>
                    </tr>           
                </tbody>       
            </table>
            <p style="text-align: center;color: red;height: 20px" id="register-response"></p>
            <button id="register"  type="button" class="btn button-blue" style="margin-bottom: 20px;margin-left: 40%;margin-top: 10px">提交</button>     
         </form>
	</div>

    <!--下载栏-->
    <div id="download-list" tabindex="0">
        <div class="second-title color-white text-align-center" style="width:350px;">
            <span style="margin-left:60px;margin-right:50px;">下载列表</span>
            <a id="download-out"><span class="glyphicon glyphicon-log-out" style="top:4px"></span></a>
        </div>
        <table class="third-title color-white download-table" style="width:330px;margin-left: 20px">
            <tr>
                <td style="width: 85%"></td> <td style="width: 15%"></td>
            </tr>
        </table>
        <div class="second-title color-white text-align-center" style="width:350px;bottom:0;position: fixed">
            <table class="third-title color-white"  style="width:330px;margin-left: 20px">
                <tr>
                    <td><a><span>上一页</span></a></td>
                    <td class="second-title" id="try-download"><a><span>下载</span></a></td>
                    <td><a><span>下一页</span></a></td>
                </tr>
            </table>
        </div>
    </div> <!--下载栏结束-->

    <!--登录注册-->
    <div id="login-table">  
        <div class="third-title color-white" style="background-color:#000;color:#fff">
            <span style="margin-left: 20px" id="login-type">管理员登录</span>
            <a class="login-close">
                <span class="glyphicon glyphicon-remove-circle" style="float: right;top:16px;right: 16px">
                </span>
            </a>
        </div>
        <form id="logininfo" action="/opensource/login">
        <table style=" margin-left: 30px; margin-top: 10px" class="forth-title">
            <tbody>
                <tr>
                        <td style="width: 5%"></td>
                        <td style="width: 80px">登录名：</td>
                        <td><input type="text" name="username" value="admin" placeholder="请输入登录名"  maxlength="16" 
                            style="width: 120px;"></td>
                        <td></td>
                </tr>
                 <tr>
                        <td></td>
                        <td>密码：</td>
                        <td><input type="password" name="password" value="123456" placeholder="请输入密码" 
                            maxlength="16" style="width: 120px;"></td>
                        <td></td>
                </tr>
                 <tr>
                        <td></td>
                        <td>验证码：</td>
                        <td>
                            <input type="text" name="code" maxlength="4" style="width: 50px;">
                            <img id="vericodeImg" src="/opensource/imageCode">
                        </td>
                        <td><a id="notsee" href="javascript:changeImg();">点击更换</a></td>
                </tr>                       
            </tbody>
        </table>
    
        <div class="third-title">
            <a id="login-button"><span style="margin-left: 30%">登录</span></a>
            <a href="/opensource/register.jsp" id="register-button" class="fifth-title"><span style="margin-left: 40px">点击注册</span></a>
         </div>
         <p style="left:35%;bottom: -9px; position: absolute;color: red" id="response"></p>
         </form>
    </div><!--登录注册结束-->

    <!--页脚-->
    <div class="otherfoot">
        <a id="open-download">  <!--点击出现下载列表-->
            <div id = "download-button" class="shadow second-title">
                <span class="glyphicon glyphicon-download-alt"></span>
            </div>
        </a>
        <img src="/opensource/images/icon/logo.png" width=60px height=60px class="img-circle" style="margin-left:20vw; border:0;">
        <div class="othercopyright">
            Copyright &copy; 西南大学<a href="http://www.swu.edu.cn/" target="_blank" title="西南大学">www.swu.edu.cn</a> 
           
        </div> 
        <div style="float:right;margin-right:20vw;">在线人数:&nbsp;
            <span id="online">${onlineCount}</span>
        </div>
    </div> <!--页脚结束-->
</body>
    <script type="text/javascript" src="/opensource/js/jquery-3.5.1.min.js"></script> 
    <script type="text/javascript" src="/opensource/js/jquery.cookie.js"></script> 
    <script type="text/javascript" src="/opensource/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/opensource/js/common.js"></script>  
    <jsp:include   page="downlist.jsp" flush="true"/>
    <jsp:include   page="login.jsp" flush="true"/>
    <script type="text/javascript">
        function changeImg() {
          //需要让每次请求的url都发生变化。否则服务器会认为访问的时一张图片，就不会刷新请求了
          //每次url一样，服务器会认为访问的url是同一张图片，没变化啊
            $("#vericodeImg").attr("src","/opensource/imageCode?"+Math.random());
        }
        function registerchangeImg() {
          //需要让每次请求的url都发生变化。否则服务器会认为访问的时一张图片，就不会刷新请求了
          //每次url一样，服务器会认为访问的url是同一张图片，没变化啊
            $("#registercodeImg").attr("src","/opensource/imageCode?"+Math.random());
        }
        $("#passwd span").css("opacity",0);
        $("#passwd-check span").css("opacity",0);
        $("#passwd input").bind("input propertychange", function(){
            $("#passwd span").css("opacity",1);
            let length = $("#passwd input").val().trim().length;
            if(length>=6)
            {
               $("#passwd span").css("color","#66CC33");
               if($("#passwd input").val()===$("#passwd-check input").val())
                {
                   $("#passwd-check span").css("color","#66CC33");
                   $("#passwd span").css("color","#66CC33");
                }
                else
                {
                     $("#passwd span").css("color","#CC0000");
                }
            }
            
        });
        $("#passwd-check input").bind("input propertychange", function(){
            $("#passwd-check span").css("opacity",1);
            $("#passwd-check span").css("color","#CC0000");
            if($("#passwd input").val()===$("#passwd-check input").val())
            {
               $("#passwd-check span").css("color","#66CC33");
               $("#passwd span").css("color","#66CC33");
            }
            else
            {
                 $("#passwd-check span").css("color","#CC0000");
            }
        });
        $("#register").click(function(){
            let regex = /^[^_][A-Za-z]*[a-z0-9_]*$/;
            let regex2 = /[@#\$%\^&\*]+/gi;
            let ret2 = regex2.test($("[name='registername']").val());
            let ret = regex.test($("[name='registername']").val());
            if(!ret2&&ret)
            {
                let username = $("[name='registername']").val();
                if($("#passwd input").val()===$("#passwd-check input").val())
                { 
                    //alert("输入正确");
                    let password = $("#passwd input").val();
                    let code = $("[name='registercode']").val();
                    //let location = encodeURI(window.location.pathname + window.location.search);
                    $.post("/opensource/register", {"usertype":"user","username":username,"password":password,"code":code,"location":"/opensource/index.jsp"}, function(data){
                            let response = parseInt(data);
                            //alert(data);
                            if(response===-1)  //用户名或密码错误
                            {
                                $("#register-response").text("用户名已存在,请更换！");
                                registerchangeImg();
                                setTimeout(function(){
                                    $("#register-response").text("");
                                },2000);
                            }
                            else if(response===0)
                            {
                                alert("恭喜你，注册成功！");
                                window.location.href="/opensource/index.jsp";
                            }
                    });
                }
                else
                {
                    //alert("密码不一致！");  
                    $("#register-response").text("密码不一致！");   
                    setTimeout(function(){
                        $("#register-response").text("");
                    },2000);   
                }
            } else 
            {
                //alert("用户名格式错误！");
                $("#register-response").text("用户名格式错误！");   
                setTimeout(function(){
                    $("#register-response").text("");
                },2000);   
            }
            
            
        });
    </script>

</html>
