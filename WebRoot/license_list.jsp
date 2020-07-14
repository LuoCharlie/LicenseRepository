<%@ page 
	language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	
	//List<type> types = (List<type>) request.getAttribute("type"); 
	String status = (String)request.getAttribute("status");
	//获取cookie里的有效数据
	Cookie cookie = null;
	Cookie[] cookies = null;
	cookies = request.getCookies();
    if( cookies != null ){
      for (int i = 0; i < cookies.length; i++){
        cookie = cookies[i];
        if(cookie.getName().equals("JSESSIONID"))
        {
        	pageContext.setAttribute("sessionID", cookie.getName());
        }
      }
    }
	pageContext.setAttribute("usertype", request.getSession().getAttribute("usertype"));
	pageContext.setAttribute("username", request.getSession().getAttribute("username"));
    if(application.getAttribute("onlineCount")==null)
    {
        application.setAttribute("onlineCount", 0);  
    }
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"> 
	<title>许可证列表</title>
	<link rel="stylesheet" href="/opensource/css/bootstrap.min.css">  
    <link rel="stylesheet" type="text/css" href="/opensource/css/style.css" />
</head>
<body>
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
	
    <div class="row-style"  id="license-list" style="display: flex;align-items: flex-start;justify-content: center;">
        <div class = "total-list" style="width:20%;">
            <p class="third-title" style="padding-top: 30px">许可证列表</p>
            <ul>
                <li>
                    <div class = "link">全部许可证<span class="glyphicon glyphicon-chevron-down putdown-icon"></span></div>
                    <ul class = "desc anel-collapse collapse" id = "all-license">
                    <c:forEach items="${type}" var="item"> 
                        <li>
                            <a href='/opensource/license/licenseDetail?license_name=${item.name}'>
                                ${item.name}
                            </a>
                        </li>
                    </c:forEach>  
                    </ul>
                </li>
                <li>
                    <div class = "link">强copyleft许可证<span class="glyphicon glyphicon-chevron-down putdown-icon"></span></div>
                    <ul class = "desc anel-collapse collapse" id = "strong-license">
                    <c:forEach items="${type}" var="item">
                        <c:if test="${item.type eq '强copyleft许可证'}">  
                            <li>
                                <a href='/opensource/license/licenseDetail?license_name=${item.name}'>
                                    ${item.name}
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>    
                    </ul>
                </li>
                <li>
                    <div class = "link">弱copyleft许可证<span class="glyphicon glyphicon-chevron-down putdown-icon"></span></div>
                    <ul class = "desc anel-collapse collapse" id = "weak-license">
                    <c:forEach items="${type}" var="item">
                        <c:if test="${item.type eq '弱copyleft许可证'}">  
                            <li>
                                <a href='/opensource/license/licenseDetail?license_name=${item.name}'>
                                    ${item.name}
                                </a>
                            </li>
                        </c:if>
                    </c:forEach> 
                    </ul>
                </li>
                <li>
                    <div class = "link">宽松型许可证<span class="glyphicon glyphicon-chevron-down putdown-icon"></span></div>
                    <ul class = "desc anel-collapse collapse">
                    <c:forEach items="${type}" var="item">
                        <c:if test="${item.type eq '宽松型许可证'}">  
                            <li>
                                <a href='/opensource/license/licenseDetail?license_name=${item.name}'>
                                    ${item.name}
                                </a>
                            </li>
                        </c:if>
                    </c:forEach> 
                    </ul>
                </li>
            </ul>
        </div>
        <div class="text-center col-style" style="background:#FFF;padding:0;margin-right:20%;width:60%;">
         	<br>
          	<div class="row text-align-left" style="margin-bottom:0px">
            	<p>
                    <span id = "license_name" class="common-title">${detail.name}</span>
                    <a id="choose-download" style="margin-left: 20px; color: #337ab7">下载</a>
                </p>
            </div>
            <div class="row text-align-left" style="z-index: 0">
            	<div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active list-bar" onClick="show_interpretation()" id="bt_explain">
                                <input type="radio" name="options" id="option1" > 许可证解读
                            </label>
                            <label class="btn btn-primary list-bar" onClick="show_translation()" id="bt_translation">
                                <input type="radio" name="options" id="option2" > 许可证翻译
                            </label>
                            <label class="btn btn-primary list-bar" onClick="show_origin()" id="bt_origin">
                                <input type="radio" name="options" id="option3"> 许可证原文
                            </label>
                            <label class="btn btn-primary list-bar" onClick="show_information()" id="bt_information">
                                <input type="radio" name="options" id="option3"> 许可证基本信息
                            </label>
                </div>
    		</div>
            <div id="interpretation"  style="height:700px;">
            	<div class="row">
                    <div class="text-align-left padding-left-20 second-title" >
                        <p>摘要</p>
                    </div>
                    <br>
                    <textarea class="article width-100per" readonly="readonly" rows="8">${detail.abstractName}</textarea>
                    <div class="line" >
                       <br>
                    </div>
    			</div>
                <div class="row">
                    <div class="text-align-left padding-left-20 second-title" >
                        <p>维度分析</p>
                    </div>
                    <br>

                    <div class="text-align-left bgcolor-grey border-all-thin attribution-part">
    					<h3 class="bgcolor-green">权利</h3>
    					<ul class="third-title">
                        <c:forEach items="${right}" var="item">
                            <li>
                                <div class = "link border-bottom padding-left-10 third-title">
                                    <span class="glyphicon glyphicon-chevron-down putdown-icon"></span>${item.name}
                                </div>
                                <ul class = "desc border-bottom anel-collapse collapse">
                                    <li class="padding-left-10 padding-right-10">
                                        ${item.description}
                                    </li>
                                </ul>
                            </li>       
                        </c:forEach>
                      	</ul>
            		</div>
                    
                    <div class="text-align-left bgcolor-grey border-all-thin attribution-part">
						<h3 class="bgcolor-orange">义务</h3>
    					<ul class="third-title">
                        <c:forEach items="${obligation}" var="item">
                            <li>
                                <div class = "link border-bottom padding-left-10 third-title">
                                    <span class="glyphicon glyphicon-chevron-down putdown-icon"></span>${item.name}
                                </div>
                                <ul class = "desc border-bottom anel-collapse collapse">
                                    <li class="padding-left-10 padding-right-10">
                                        ${item.description}
                                    </li>
                                </ul>
                            </li>       
                        </c:forEach>
                      	</ul>
            		</div>
                    
                    <div class="text-align-left bgcolor-grey border-all-thin attribution-part">
    					<h3 class="bgcolor-red">禁止</h3>
    					<ul class="third-title">
                      	<c:forEach items="${prohibition}" var="item">
                            <li>
                                <div class = "link border-bottom padding-left-10 third-title">
                                    <span class="glyphicon glyphicon-chevron-down putdown-icon"></span>${item.name}
                                </div>
                                <ul class = "desc border-bottom anel-collapse collapse">
                                    <li class="padding-left-10 padding-right-10">
                                        ${item.description}
                                    </li>
                                </ul>
                            </li>       
                        </c:forEach>
            		</div>
    			</div>
    		</div>
            <div id="translation" style="height:700px;">
            	<div class="row">
                	<br>
                	<textarea class="article width-100per" readonly="readonly" rows="32">${detail.translation}</textarea>
    			</div>
    		</div>
            <div id="origin" style="height:700px;">
            	<div class="row">
                	<br>
                	<textarea class="article width-100per" readonly="readonly" rows="32">${detail.origation}</textarea>
    			</div>
    		</div>
            <div id="information" style="height:700px;">
            	<div class="row text-align-left margin-top-50">
            		<span>名称:</span><input type="text" readonly="readonly" name="name" value="${detail.name}"/>
    			</div>
    			<div class="row text-align-left margin-top-50">
            		<span>简称:</span><input type="text" readonly="readonly"  name="abbreviation" value="${detail.abbreviation}"/>
    			</div>
    			<div class="row text-align-left margin-top-50">
            		<span>类别:</span><input type="text" readonly="readonly"  name="category" value="${detail.type}"/>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span>所有者:</span><input type="text" readonly="readonly"  name="owner" value="${detail.owner}"/>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span style="vertical-align:top;">发展史:</span><textarea class="article width-70per" readonly="readonly" rows="12" name="history">${detail.history}</textarea>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span>原文链接:</span><input type="text" readonly="readonly"  name="url" value="${detail.originURL}"/>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span>SPDX列表:</span><input type="text" readonly="readonly"  name="SPDX" value="${detail.SPDX}"/>
    			</div>
    			<div class="row text-align-left margin-top-50">
            		<span>整理人:</span><input type="text" readonly="readonly"  name="admin" value="${detail.admin}"/>
    			</div>
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
    <script type="text/javascript" src="/opensource/js/list.js"></script>
    <jsp:include   page="downlist.jsp" flush="true"/>
    <jsp:include   page="login.jsp" flush="true"/>
    <script> 
        function changeImg() {
          //需要让每次请求的url都发生变化。否则服务器会认为访问的时一张图片，就不会刷新请求了
          //每次url一样，服务器会认为访问的url是同一张图片，没变化啊
          $("#vericodeImg").attr("src","/opensource/imageCode?"+Math.random());
      }
    </script>
</html>
