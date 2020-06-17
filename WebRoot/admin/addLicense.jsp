<%@ page 
	language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.opensource.Domain.*" %>
<%
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
	
    <div class="row-style"  id="license-list" style="display: flex;align-items: flex-start;justify-content: center">
        <div class="text-center col-style" style="background:#FFF;padding:0px;width:1000px;">
         	<br>
          	<div class="row text-align-left" style="margin-bottom:0px">
            	<p>
                    <span style="font-size:30px;font-weight: 400">
                    <a id="license-insert" style="margin-left: 10px; color: #337ab7;">提交</a>
                    </span>
                </p>
            </div>
            <div class="row text-align-left" style="z-index: 0;margin-top: 20px">
            	<div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active list-bar" onClick="show_information()" id="bt_information">
                                <input type="radio"> 许可证基本信息
                            </label>
                            <label class="btn btn-primary list-bar" onClick="show_interpretation()" id="bt_explain">
                                <input type="radio" > 许可证解读
                            </label>
                            <label class="btn btn-primary list-bar" onClick="show_translation()" id="bt_translation">
                                <input type="radio"> 许可证翻译
                            </label>
                            <label class="btn btn-primary list-bar" onClick="show_origin()" id="bt_origin">
                                <input type="radio"> 许可证原文
                            </label>
                </div>
    		</div>
            <div id="interpretation"  style="height:700px;">
            	<div class="row">
                    <div class="text-align-left padding-left-20 second-title" >
                        <p>摘要</p>
                    </div>
                    <br>
                    <textarea name="abstractName" class="article width-100per" rows="8"></textarea>
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
    					<h3 class="bgcolor-green" id="getclick">权利</h3>
                      	<ul class="forth-title" id="right-describe">
                            <form style="padding-left: 20px">
                                <p><label class="checkbox-inline"><input type="checkbox" value="商业">商业</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="衍生">衍生</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="分发">分发</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="可读">可读</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="再复制">再复制</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="出售">出售</label></p>
                            </form>
                        </ul>
            		</div>
                    
                    <div class="text-align-left bgcolor-grey border-all-thin attribution-part">
    					<h3 class="bgcolor-orange">义务</h3>
                      	<ul class="forth-title" id="obligation-describe">
                            <form style="padding-left: 20px">
                                <p><label class="checkbox-inline"><input type="checkbox" value="附加政策">附加政策</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="附加源">附加源</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="特性">特性</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="相同授权条款">相同授权条款</label></p>
                            </form>
                        </ul>
            		</div>
                    
                    <div class="text-align-left bgcolor-grey border-all-thin attribution-part">
    					<h3 class="bgcolor-red">禁止</h3>
                      	<ul class="forth-title" id="prohibition-describe">
                            <form style="padding-left: 20px">
                                <p><label class="checkbox-inline"><input type="checkbox" value="商业">商业</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="衍生">衍生</label></p>
                                <p><label class="checkbox-inline"><input type="checkbox" value="分发">分发</label></p>
                            </form>
                        </ul>
            		</div>
    			</div>
    		</div>
            <div id="translation" style="height:700px;">
            	<div class="row">
                	<br>
                	<textarea name="translation" class="article width-100per" rows="32"></textarea>
    			</div>
    		</div>
            <div id="origin" style="height:700px;">
            	<div class="row">
                	<br>
                	<textarea name="origation" class="article width-100per" rows="32"></textarea>
    			</div>
    		</div>
            <div id="information" style="height:700px;">
            	<div class="row text-align-left margin-top-50">
            		<span>名称:</span><input type="text"  name="name" value=""/>
    			</div>
    			<div class="row text-align-left margin-top-50">
            		<span>简称:</span><input type="text"  name="abbreviation" value=""/>
    			</div>
    			<div class="row text-align-left margin-top-50" id="license-type">
            		<span>类别:</span>
                    <label class="radio-inline" style="padding-right: 30px">
                        <input type="radio" name="type" value="1">强copyleft许可证
                    </label>
                    <label class="radio-inline" style="padding-right: 30px">
                        <input type="radio" name="type" value="2">弱copyleft许可证
                    </label>
                    <label class="radio-inline" style="padding-right: 30px">
                        <input type="radio" name="type" value="3">宽松型许可证
                    </label>
                    <label class="radio-inline" style="padding-right: 30px">
                        <input type="radio" name="type" value="4">默认
                    </label>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span>所有者:</span><input type="text"  name="owner" value=""/>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span style="vertical-align:top;">发展史:</span><textarea class="article width-70per" rows="12" name="history"></textarea>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span>原文链接:</span><input type="text"  name="originURL" value=""/>
    			</div>
                <div class="row text-align-left margin-top-50">
            		<span>SPDX列表:</span><input type="text"  name="SPDX" value=""/>
    			</div>
            </div>
    	</div>
    </div>

    <div class="otherfoot">
        <img src="/opensource/images/icon/logo.png" width=60px height=60px class="img-circle" style="margin-left:20vw; border:0;">
        <div class="othercopyright">
            Copyright &copy; 西南大学<a href="http://www.swu.edu.cn/" target="_blank" title="西南大学">www.swu.edu.cn</a>         
        </div> 
        <div style="float:right;margin-right:20vw;">在线人数:&nbsp;
            <span id="online"><%=application.getAttribute("onlineCount")%></span>
        </div>
    </div> <!--页脚结束-->
    <input type="hidden" id="username" name="data" value="${username}">
</body>
    <script type="text/javascript" src="/opensource/js/jquery-3.5.1.min.js"></script> 
    <script type="text/javascript" src="/opensource/js/jquery.cookie.js"></script> 
    <script type="text/javascript" src="/opensource/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/opensource/js/common.js"></script>	
    <script type="text/javascript" src="/opensource/js/manage.js"></script>
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
    $(document).ready(function(){
        show_information();
    });
    function show_interpretation(){
        document.getElementById("interpretation").style.display="block";
        document.getElementById("translation").style.display="none";
        document.getElementById("origin").style.display="none";
        document.getElementById("information").style.display="none";
    }

    function show_translation(){
        document.getElementById("interpretation").style.display="none";
        document.getElementById("translation").style.display="block";
        document.getElementById("origin").style.display="none";
        document.getElementById("information").style.display="none";    
    }
    function show_origin(){
        document.getElementById("interpretation").style.display="none";
        document.getElementById("translation").style.display="none";
        document.getElementById("origin").style.display="block";
        document.getElementById("information").style.display="none";    
    }
    function show_information(){
        document.getElementById("interpretation").style.display="none";
        document.getElementById("translation").style.display="none";
        document.getElementById("origin").style.display="none";
        document.getElementById("information").style.display="block";
    }

    </script>
</html>
