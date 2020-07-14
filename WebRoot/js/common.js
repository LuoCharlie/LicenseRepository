/*浏览器兼容事件监听*/
var EventUtil={   
   addHandler:function(element,type,handler){ //添加事件
      if(element.addEventListener){ 
         element.addEventListener(type,handler,false);  //使用DOM2级方法添加事件
      }else if(element.attachEvent){                    //使用IE方法添加事件
         element.attachEvent("on"+type,handler);
      }else{
         element["on"+type]=handler;          //使用DOM0级方法添加事件
      }
   },  
   removeHandler:function(element,type,handler){  //取消事件
      if(element.removeEventListener){
         element.removeEventListener(type,handler,false);
      }else if(element.detachEvent){
         element.detachEvent("on"+type,handler);
      }else{
         element["on"+type]=null;
      }
   },
   getEvent:function(event){  //使用这个方法跨浏览器取得event对象
      return event?event:window.event;
   },     
   getTarget:function(event){  //返回事件的实际目标
      return event.target||event.srcElement;
   },     
   preventDefault:function(event){   //阻止事件的默认行为
      if(event.preventDefault){
         event.preventDefault(); 
      }else{
         event.returnValue=false;
      }
   },
   stopPropagation:function(event){  //立即停止事件在DOM中的传播
                                     //避免触发注册在document.body上面的事件处理程序
      if(event.stopPropagation){
         event.stopPropagation();
      }else{
         event.cancelBubble=true;
      }
   },         
   getRelatedTarget:function(event){  //获取mouseover和mouseout相关元素
      if(event.relatedTarget){
         return event.relatedTarget;
      }else if(event.toElement){      //兼容IE8-
         return event.toElement;
      }else if(event.formElement){
         return event.formElement;
      }else{
         return null;
      }
   },         
   getButton:function(event){    //获取mousedown或mouseup按下或释放的按钮是鼠标中的哪一个
      if(document.implementation.hasFeature("MouseEvents","2.0")){
         return event.button;
      }else{
         switch(event.button){   //将IE模型下的button属性映射为DOM模型下的button属性
            case 0:
            case 1:
            case 3:
            case 5:
            case 7:
               return 0;  //按下的是鼠标主按钮（一般是左键）
            case 2:
            case 6:
               return 2;  //按下的是中间的鼠标按钮
            case 4:
               return 1;  //鼠标次按钮（一般是右键）
         }
      }
   },        
   getWheelDelta:function(event){ //获取表示鼠标滚轮滚动方向的数值
      if(event.wheelDelta){
         return event.wheelDelta;
      }else{
         return -event.detail*40;
      }
   },         
   getCharCode:function(event){   //以跨浏览器取得相同的字符编码，需在keypress事件中使用
      if(typeof event.charCode=="number"){
         return event.charCode;
      }else{
         return event.keyCode;
      }
   }
};

/*导航栏*/
var boxStatus = 
{
	"finished" : false
};
/* handler //自适应导航栏
 *  compusePageHeight() //跨浏览器计算浏览器窗口大小
 *  disappear(dom,next,act) //处理渐隐渐显，dom为待处理节点，next为opacity和visibility的值，act为transition执行动画
 * 	addBoxActive(boxActive) //将boxStatus置为true
 * 	leftScroll() //监听左右滚动及上下滚动事件控制导航条
 * 	throttle() //进行节流和防抖
 *  footerResize()  //自适应页脚 
 *  downloadBlur() //下载列表失去焦点
 */
var Handler = {
	compusePageHeight : function (){
		var pageHeight = window.outerHeight;
		/*if(typeof pageHeight!="number"){
           if(document.compatMode=="CSS1Compat")
		   {
               pageHeight=document.documentElement.clientHeight;
           }else
		   {
               pageHeight=document.body.clientHeight;
           }
		}*/
		return pageHeight;
	},
	disappear : function (dom,next,act){
		dom.css({"opacity":next,"visibility":next});
		dom.css("transition",act);		
	}, 
	addBoxActive : function (boxActive){ 
		boxStatus.finished = true;
		//console.log("addBoxActive,finished=true");
	},
	leftScroll : function () {
		let t = $(document).scrollTop();   // 目前监听的是整个body的滚动条距离
		//console.log(t);
		let box = $(".box");
		if(t>0){  //垂直滚动
			let left = -$(document).scrollLeft();  //水平滚动
			if(!$('.box').is('.box-active'))    //表示还没有fixed，界面还未滚动
			{	
				//console.log("first");
				//console.log("don't has box-active");
				Handler.disappear(box,0,"opacity 10ms ease-out,visibility 10ms ease-out");
				setTimeout(function()
				{			
					box.addClass("box-active");
					var boxActive = $(".box-active");
					$(document.body).css({'margin-top':'81px'});
					Handler.disappear(boxActive,1,"opacity 0.5s ease-out,visibility 0.5s ease-out");
					setTimeout(Handler.addBoxActive(boxActive),500);  //500毫秒后将hasfinished变为true
				},10);			
			}
			if(boxStatus.finished===true)
			{
				box.addClass('box-active');
				var boxActive = $(".box-active");
				boxActive.css("left",left);
				boxActive.css({"opacity":1,"visibility":1});	
				//console.log("left<0");
				
				//console.log("after");	
			}
		}else{	
			Handler.disappear($(".box-active"),0,"opacity 1s ease-out,visibility 1s ease-out");
			$(".box-active").css("left","0px");
			$('.box').removeClass('box-active');	
			$(document.body).css({'margin-top':'0px'});
			boxStatus.finished = false;
			Handler.disappear(box,1,"opacity 1s ease-out,visibility 1s ease-out");
		}
	},
	throttle : function (fn, delay) {
	  // last为上一次触发回调的时间, timer是定时器
		let last = 0, timer = null
	  // 将throttle处理结果当作函数返回
		return function () { 
		// 保留调用时的this上下文
			let context = this
			// 保留调用时传入的参数
			let args = arguments
			// 记录本次触发回调的时间
			let now = +new Date()
			// 判断上次触发的时间和本次触发的时间差是否小于时间间隔的阈值
			if (now - last < delay) {
			// 如果时间间隔小于我们设定的时间间隔阈值，则为本次触发操作设立一个新的定时器
			   clearTimeout(timer)
			   timer = setTimeout(function () {
				  last = now
				  fn.apply(context, args)
				}, delay)
			} else {
				// 如果时间间隔超出了我们设定的时间间隔阈值，那就不等了，无论如何要反馈给用户一次响应
				last = now
				fn.apply(context, args)
			}
		}
	},
	footerResize : function ()
	{
		let real = document.body.scrollHeight+100;  //实际大小，包括滚动条
		let client = Handler.compusePageHeight();  //可视大小
		console.log("real:"+real);
		console.log("client:"+client);
		if(real-client>0)
		{
			var foot = $(".otherfoot");
			//console.log("add");
			foot.addClass('otherfoot-active');
		}
		else
		{
			//console.log("remove");
			$(".otherfoot").removeClass('otherfoot-active');
			
		}
		
	},
	maskAct:function(act){
		let login = $("#login-table").css("opacity");
		let downloadList = $("#download-list").css("opacity");
		if(act===false)
		{
			
			console.log("login:"+login + "   downloadList:" +downloadList+"  bool:");
			if(login==="1"&&downloadList!=="1")
			{
				let mask = $(".mask");
				mask.css("visibility",0);
				mask.css("opacity",0);
				setTimeout(function(){mask.css("z-index",-1);},250);
			}
			else if(login==="0"&&downloadList==="1")
			{
				let mask = $(".mask");
				mask.css("visibility",0);
				mask.css("opacity",0);
				setTimeout(function(){mask.css("z-index",-1);},250);
			}
			return;
			
		}
		else if(act===true)
		{
			let mask = $(".mask");
			mask.css("visibility",1);
			mask.css("opacity",0.7);
			mask.css("z-index",10);
		}
		//}

	},
	downloadBlur:function(){
		let downloadList = $("#download-list");
		downloadList.width("10px");
		downloadList.css("opacity",0);
		Handler.maskAct(false);
		//console.log("blur");
   },
   loginAct:function(dom,act){
   		if(act==="0")
   		{
   			dom.css({"opacity":1,"visibility":1,"z-index":20});
   			Handler.maskAct(true);
   			//console.log("0");
   		}
   		else if(act==="1")
		{dom.css({"opacity":0,"visibility":0,"z-index":-1});
		console.log(dom.css("opacity"));
			Handler.maskAct(false);
			
			//console.log("1");
		}
   } 
} 

/*搜索框*/
function searchInput(){
	/*初始化搜索框*/
	let input = $(".form-control");
	//input.val("请输入内容");
	input.focus(function(){
		//$(this).val("");
		$("#search-choose").css({"color":"#fff"});
	});
	input.blur(function(){
		$("#search-choose").css({"color":"#999"});
		//console.log(input.val());
	});
	$("#search-choose").focus(function(){$(this).css("color","#fff");});
	$("#search-choose").blur(function(){$(this).css("color","#999");});
	
}
function downloadListAct(){
	$("#download-list").blur(function(){   //下载列表失去焦点
		Handler.downloadBlur();
	});
	$("#open-download").click(function(){   //下载列表得到焦点
		let downloadList = $("#download-list");
		downloadList.width("350px");
		downloadList.css("opacity",1);
		//console.log("download:");
		Handler.maskAct(true);
		downloadList.focus();
	});
	$("#download-out").click(function(){  //点击退出
		Handler.downloadBlur();
	});

}
 
$(document).ready(function(){
	/*页面监听*/
	const better_scroll = Handler.throttle(Handler.leftScroll, 0);
	const better_resize = Handler.throttle(Handler.footerResize, 50);
	EventUtil.addHandler(window,"scroll",better_scroll);
	EventUtil.addHandler(window,"resize",better_resize);
	searchInput();  //搜索框监听
	downloadListAct(); //下载列表监听
	Handler.footerResize();
	$(".search-list").on("click","li",function(){   //搜索类型选择
		$("#search-choose").html($(this).text()+"<span class=\"glyphicon glyphicon-chevron-down\" style=\" margin-left:5px\"></span>");
	});
	$(".download-table").on("click","a",function(){  //下载列表删除
		let nowthis = $(this).parent().parent();
		nowthis.remove();
	});
	$("#login-admin").click(function(){   //管理员登录获得焦点
		let bool = $("#login-table").css("opacity");
		//console.log(bool);
		if(bool==="0")
		{
			$("#login-type").text("管理员登录");
			$("#register-button").css("visibility","hidden");
		}
		Handler.loginAct($("#login-table"),bool);
	});
	$("#login-common").click(function(){   //普通用户登录获得焦点
		let bool = $("#login-table").css("opacity");
		if(bool==="0")
		{
			$("#login-type").text("用户登录");
			$("#register-button").css("visibility","visible");
		}
		//console.log(bool);
		Handler.loginAct($("#login-table"),bool);
	});
	$(".login-close").click(function(){  //登录失去焦点
		let loginClose = $(this).parent().parent();
		let bool = loginClose.css("opacity");
		Handler.loginAct(loginClose,bool);
	});
	$("#login-button").click(function(){  //点击登录按钮
		let usertype = $("#login-type").text();
		if(usertype==="管理员登录")
		{
			usertype = "admin";
		}
		else
		{
			usertype = "user";
		}
		let username = $("input[name='username']").val();
		let password = $("input[name='password']").val();
		if(username===""||password==="")
		{
			$("#response").text("请输入用户名或密码！");
			setTimeout(function(){$("#response").text("");},3000);
			return;
		}
		let code = $("input[name='code']").val();
		let location = encodeURI(window.location.pathname + window.location.search);
		console.log("usertype:"+usertype+".  name:"+username+",  password:"+password+",  code"+code+";  location"+location);
		$.post("/opensource/login", { "usertype":usertype, "username":username,"password":password,"code":code,"location":location}, function(data){
			let response = parseInt(data);
			if(response===-2)  //验证码错误
			{
				$("#response").html("&emsp;验证码错误！&emsp;");
				setTimeout(function(){
					$("#response").text("");
				},3000);
			}
			else if(response===-1)  //用户名或密码错误
			{
				$("#response").text("用户名或密码错误！");
				$("#vericodeImg").attr("src","/opensource/imageCode?"+Math.random());
				setTimeout(function(){
					$("#response").text("");
				},3000);
			}
			else if(response===0)  //进入普通用户登录成功
			{
				console.log(response);
				$("#login-admin").text(name);
				$("#login-common").text("退出");
				window.location.reload();
				//Handler.loginAct($("#login-table"),"1");
			}
			else if(response===1)//进入管理员
			{
				console.log(response);
				window.location.href="/opensource/admin/index.jsp";
			}
		});
	});
	
	$("#logout").click(function(){
		$.post("/opensource/logout", null, function(data){
				window.location.reload();
		});
	});
});

/**/