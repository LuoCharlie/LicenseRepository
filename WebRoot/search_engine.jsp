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
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">开源资源</a>
                    <ul class="dropdown-menu">
                        <li><a href="/opensource/opensource_software.html">开源软件</a></li>
                        <li><a href="/opensource/open_source_license.html">开源许可证</a></li>
                        <li><a href="/opensource/open_source_works.html">开源作品</a></li>
                    </ul>
                    
                </li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">开源大事</a>
                    <ul class="dropdown-menu">
                        <li><a href="/opensource/license/fqa?page=1">基础解惑</a></li>
                        <li><a href="/opensource/Classification_of_the_preview.html">分类预览</a></li>
                        <li><a href="/opensource/license/licenseDetail?license_name=许可证1">许可证列表</a></li>
                        <li><a href="/opensource/compatibility_analysis.html">兼容分析</a></li>
                    </ul>
                </li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">许可证工具</a>
                    <ul class="dropdown-menu">
                        <li><a href="/opensource/search_engine.jsp">搜索引擎</a></li>
                        <li><a href="/opensource/the_selector.html">选择器</a></li>
                    </ul>
                </li>
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">关于我们</a>
                    <ul class="dropdown-menu">
                        <li><a href="#">开源新资讯</a></li>
                        <li><a href="#">许可证维度</a></li>
                        <li><a href="#">许可证生成</a></li>
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

	<div class="container search_engine-style"> 
    	<div class="mask"> </div>  	
		<div class="row">
            <div id="select">
                <div class="row common-title text-align-center">
                    <p><span>许可证搜索引擎</span></p>
                </div>
                <br>
				<div class="col-xs-7 text-center title-margin-top-50">
					<div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-primary active search_engine-button" onClick="show_rights()" id="clickrights">
                            <input type="radio" name="options" id="option1" > 权利
                        </label>
                        <label class="btn btn-primary search_engine-button" onClick="show_obligations()" id="clickobligations">
                            <input type="radio" name="options" id="option2" > 义务
                        </label>
                        <label class="btn btn-primary search_engine-button" onClick="show_prohibition()" id="clickprohibition">
                            <input type="radio" name="options" id="option3"> 禁止
                        </label>
					</div>
 					<p class="title-margin-top-30 text-align-left search_engine_content title-margin-top-50">
                    	<span>为您的数据选择权限</span>
                    </p>				
                    <div id="rights" style="display:block">
                        <select class="search_engine-select">
                            <option value ="-- 选择 --">-- 选择 --</option> <!--Commercialize-->
                            <option value ="商业">商业</option> <!--Commercialize-->
                            <option value="衍生">衍生</option><!--Derive-->
                            <option value="分发">分发</option><!--Distribute-->
                            <option value="可读">可读</option><!--Read-->
                            <option value="再复制">再复制</option><!--Reproduce-->
                            <option value="出售">出售</option><!--Sell-->
                        </select>
                    </div>
                    <div id="obligations" style="display:none">
                    <select class="search_engine-select">
                        <option value ="-- Choose an option --">-- 选择 --</option>
                        <option value ="Attach policy">附加政策</option>
                        <option value="Attach source">附加源</option>
                        <option value="Attribute">特性</option>

                        <option value="Share alike">相同授权条款</option>
                    </select>
                    </div>
                    <div id="prohibition" style="display:none">
                    <select class="search_engine-select">
                        <option value ="-- Choose an option --">-- 选择 --</option>
                        <option value ="Commercialize">商业</option>
                        <option value="Derive">衍生</option>
                        <option value="Distribute">分发</option>
                    </select>
                    </div>
                    <div class="row title-margin-top-50 " id="select">
                        <button type="button" class="btn search_engine_button-previous" id="click_previous">
                            <span class="glyphicon glyphicon-chevron-left"></span>上一步
                        </button>
                        <button type="button" class="btn search_engine_button-ok" id="click_ok">
                            签出兼容许可证
                        </button>
                        <button type="button" class="btn search_engine_button-next" id="click_next">
                            下一步<span class="glyphicon glyphicon-chevron-right"></span>
                        </button>
                    </div>
                </div>
                <div class="col-xs-5 search_engine-table">
                    <table style="width:463px;" >
                        <thead>
                            <tr style="background-color:#000; color:#FFF; height:50px; line-height:50px; border:0px;">
                                <th>当前选择</th>
                            </tr>
                        </thead>
                        <thead>
                            <tr style="background-color:#099; color:#FFF;">
                                <th>权利</th>
                            </tr>
                        </thead>
                        <tbody id="add_rights" class="rights">
                            <tr class="remove">
                                <td></td>
                            </tr>
                        </tbody>
                        <thead>
                            <tr style="background-color:#ECB806; color:#FFF;">
                            <th>义务</th>
                            </tr>
                        </thead>
                        <tbody id="add_obligations" class="obligation">
                            <tr class="remove">
                                <td></td>
                            </tr>
                        </tbody>
                        <thead>
                            <tr style="background-color:#C30; color:#FFF;">
                            <th>禁止</th>
                            </tr>
                        </thead>
                        <tbody id="add_prohibition" class="prohibition">
                            <tr class="remove">
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
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
                        <td><input type="text" name="username" value="admin" placeholder="请输入登录名"  maxlength="10" 
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
            <a id="register-button" class="fifth-title"><span style="margin-left: 40px">点击注册</span></a>
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
            <span id="online"><%=application.getAttribute("onlineCount")%></span>
        </div>
    </div> <!--页脚结束-->
</body>
    <script type="text/javascript" src="/opensource/js/jquery-3.5.1.min.js"></script> 
    <script type="text/javascript" src="/opensource/js/jquery.cookie.js"></script> 
    <script type="text/javascript" src="/opensource/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/opensource/js/choose.js"></script>
    <script type="text/javascript" src="/opensource/js/common.js"></script>  
    <jsp:include   page="downlist.jsp" flush="true"/>
    <jsp:include   page="login.jsp" flush="true"/>
    <script type="text/javascript">
        /*
        $("#notsee").click(function(){
            $(this).attr('href',changeImg());
        });*/       
        function changeImg() {
          //需要让每次请求的url都发生变化。否则服务器会认为访问的时一张图片，就不会刷新请求了
          //每次url一样，服务器会认为访问的url是同一张图片，没变化啊
          $("#vericodeImg").attr("src","/opensource/imageCode?"+Math.random());
      }
    </script>

</html>
