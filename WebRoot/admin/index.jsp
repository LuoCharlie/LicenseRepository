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
	<title>管理中心</title>
    <link rel="stylesheet" href="/opensource/css/bootstrap.min.css">  
    <link rel="stylesheet" type="text/css" href="/opensource/css/style.css" />
</head>
<body style="background-color:#FFF">
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
