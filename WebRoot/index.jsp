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
    <meta charset="utf-8"> 
    <title>首页</title>
    <link rel="stylesheet" href="/opensource/css/bootstrap.min.css">  
    <link rel="stylesheet" type="text/css" href="/opensource/css/style.css" />
</head>
<body class="index ">
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
                        <li><a href="/opensource/license/fqa?page=1">基础解惑</a></li>
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
    <div class="cov"> </div>
    <div class="container row-style cov-height" style="padding: 0;margin:0;width: 100%">
            <h1 class="text1">开源之道</h1>
            <h2><p class="text2">We can help you learn more about open source knowledge！</p></h2>
    </div>
    <div class="index-body">
        <h1 class="main-title" style="margin-top:0px">什么是开源？</h1>    
        <div class="row index-row">
            <div>
                <img src="images/whatis.png" width=700px height=200px>
            </div>
            <div style="width:700px;padding-left: 50px">
                <p class="distext">为什么有人要放弃流血流泪的软件程序？以及如何将其赠与？此外，将软件发布给所有人后会发生什么？谁来照顾它并产生新的和改进的版本？要回答这些问题，我们必须在社区建设的背景下考虑将开源作为一种软件开发方法.</p>
                <p class="distext">开源是由许多人开发的，除了对开源项目感兴趣之外，他们可能彼此之间没有任何联系。因此，采用的软件开发方法与封闭源开发项目中发现的方法不同。</p>
                <a href="/opensource/license/fqa?page=1" class="more">查看更多</a>
            </div>
        </div>
        <h1 class="main-title">什么是开源软件？</h1> 
        <div class="row index-row">
            <div style="width:700px; padding-right: 50px">
                <p class="distext"> 问一下开源软件的主要定义特征是什么，大多数人会告诉你它是免费的！通常这是正确的，但这不是定义特征。理解开源软件含义的关键在于许可证。</p>
                <p class="distext">您甚至可能尚未意识到几乎所有软件都附带了许可证。软件是版权材料，需要许可证才能使您知道如何使用该软件。开源软件始终是根据经过开源倡议（OSI）认证的许可发布的软件。这些许可证经认证符合开放源代码定义的标准。该定义包括10条标准。其中最重要的一点可能是软件的免费重新分发，对源代码的访问以及允许对软件和衍生作品进行修改的许可，这些许可可以在相同的许可条件下进行分发。</p>
                <a href="/opensource/license/fqa?page=1" class="more">查看更多</a>
            </div>
            <div>
                <img src="images/u33.png" width=700px height=300px>
            </div> 
        </div>
        <h1 class="main-title">什么是开源许可证？</h1> 
        <div class="row index-row">
            <div>
                <img src="images/u29.png" width=600px height=300px>
            </div>
            <div style="width:700px;padding-left: 50px">
                <p class="distext">许可证即授权条款。开源软件并非完全没有限制。最基本的限制，就是开源软件强迫任何使用和修改该软件的人承认发起人的著作权和所有参与人的贡献。任何人拥有可以自由复制、修改、使用这些源代码的权利，不得设置针对任何人或团体领域的限制。不得限制开源软件的商业使用等。而许可证就是这样一个保证这些限制的法律文件。</p>
                <p class="distext">License是软件的授权许可，里面详尽表述了你获得代码后拥有的权利，可以对别人的作品进行何种操作，何种操作又是被禁止的。软件协议可分为开源和商业两类，对于商业协议，或者叫法律声明、许可协议，每个软件会有自己的一套行文，由软件作者或专门律师撰写，对于大多数人来说不必自己花时间和精力去写繁长的许可协议，选择一份广为流传的开源协议就是个不错的选择。世界上开源软件协议OPEN SOURCE LICENSE的种类非常之多，并且同一款协议有很多变种，协议太宽松会导致作者丧失对作品的很多权利，太严格又不便于使用者使用及作品的传播，所以开源作者要考虑自己对作品想保留哪些权利，放开哪些限制。</p>
                <p class="distext">世界上的开源许可证（Open Source License）大概有上百种，我们常见的开源协议。大致有GPL、BSD、MIT、Mozilla、Apache和LGPL等。</p>
                <a href="/opensource/license/fqa?page=1" class="more">查看更多</a>
            </div> 
        </div>
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
                        <td style="width: 15%"></td>
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
    <script type="text/javascript" src="/opensource/js/fqa.js"></script>
    <script type="text/javascript" src="/opensource/js/common.js"></script> 
    <jsp:include   page="downlist.jsp" flush="true"/>
    <jsp:include   page="login.jsp" flush="true"/>
    <script> 
    function changeImg() {
          //需要让每次请求的url都发生变化。否则服务器会认为访问的时一张图片，就不会刷新请求了
          //每次url一样，服务器会认为访问的url是同一张图片，没变化啊
        $("#vericodeImg").attr("src","/opensource/imageCode?"+Math.random());
    }
    $(document).ready(function(){
        $(".cov").css("height",$(window).height());
        $(".cov-height").css("height",$(window).height()); 
    });
    $(window).resize(function () {
        $(".cov").css("height",$(window).height());
        $(".cov-height").css("height",$(window).height());
    });
    </script>
</html>
