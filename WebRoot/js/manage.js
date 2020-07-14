var EventUtil1={   
    addHandler:function(element,type,handler){ //添加事件
      if(element.addEventListener){ 
         element.addEventListener(type,handler,false);  //使用DOM2级方法添加事件
      }else if(element.attachEvent){                    //使用IE方法添加事件
         element.attachEvent("on"+type,handler);
      }else{
         element["on"+type]=handler;          //使用DOM0级方法添加事件
      }
   }, 
   getTarget:function(event){  //返回事件的实际目标
      return event.target||event.srcElement;
   },  
   getEvent:function(event){  //使用这个方法跨浏览器取得event对象
      return event?event:window.event;
   }    
}

String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase)   
{       
    if (!RegExp.prototype.isPrototypeOf(reallyDo))      
    {           
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);       
    }       
    else        
    {           
        return this.replace(reallyDo, replaceWith);         
    }   
}
function getTextAreaValue(str)    
{       
    if(str!=null)
    {
        str = str.replaceAll(" ", "&nbsp;",true);        
        str = str.replaceAll("\n", "<br/>",true);       
        return str; 
    }else
    {return str;}
}

function fqaAct(dom,act){
   		if(act==="0")
   		{
   			dom.css({"opacity":1,"visibility":1,"z-index":20});
   			fqaMask(true);
   			//console.log("0");
   		}
   		else if(act==="1")
		{
			dom.css({"opacity":0,"visibility":0,"z-index":-1});
			console.log(dom.css("opacity"));
			fqaMask(false);
		}
} 

function fqaMask(act){
		let fqa = $("#fqa-table").css("opacity");
		if(act===false)
		{

			let mask = $(".mask");
			mask.css("visibility",0);
			mask.css("opacity",0);
			setTimeout(function(){mask.css("z-index",-1);},250);
		}
		else if(act===true)
		{
			let mask = $(".mask");
			mask.css("visibility",1);
			mask.css("opacity",0.7);
			mask.css("z-index",10);
		}
	}


$("#fqa-add").click(function(){   //点击新增出现输入面板
	let bool = $("#fqa-table").css("opacity");
	if(bool==="0")
	{
		$("#fqa-type").text("新增");
        $("#submit-question").val("");
        $("#submit-answer").val("");
	}
	//console.log(bool);
	fqaAct($("#fqa-table"),bool);
});
$(".fqa-close").click(function(){  
	let loginClose = $(this).parent().parent();
	let bool = loginClose.css("opacity");
	fqaAct(loginClose,bool);
});
$("#fqa-button").click(function(){ 
	let actType = $("#fqa-type").text();
	if(actType==="新增")
	{
		let question = $("#submit-question").val();
	    question = getTextAreaValue(question);
	    let href = "/opensource/admin/manage/"+"addFqa";
		let answer = $("#submit-answer").val();
		if(question===""||answer==="")
		{
			alert("wrong");
			$("#fqa-response").text("请输入问题或答案！");
			setTimeout(function(){$("#fqa-response").text("");},3000);
			return;
		}
		console.log("href:"+href+", question:"+question+",  answer:"+answer);
		$.post(href, {"question":question,"answer":answer}, function(data){
			alert("新增成功！");
			console.log(data);
			$("#submit-question").val("");
			$("#submit-answer").val("");
		});
	}
	else if(actType==="修改")
	{
		let question = $("#submit-question").val();
	    question = getTextAreaValue(question);
	    let href = "/opensource/admin/manage/"+"alterFqa";
		let answer = $("#submit-answer").val();
		answer = getTextAreaValue(answer);
		if(question===""||answer==="")
		{
			alert("wrong");
			$("#fqa-response").text("请输入问题或答案！");
			setTimeout(function(){$("#fqa-response").text("");},3000);
			return;
		}
		console.log("href:"+href+", question:"+question+",  answer:"+answer);
		$.post(href, {"question":question,"answer":answer}, function(data){
			alert("修改成功！");
			console.log(data);
			window.location.reload();
		});
	}
});

$(".fqa-alter").click(function(){
	let question = $(this).parent().prev().children(".question").text();
	let answer = $(this).parent().prev().parent().next().children(".answer").text();
	$("#submit-question").val(question);
	$("#submit-answer").val(answer);
	let bool = $("#fqa-table").css("opacity");
	if(bool==="0")
	{
		$("#fqa-type").text("修改");
	}
	//console.log(bool);
	fqaAct($("#fqa-table"),bool);
});

$(".fqa-delete").click(function(){
	let question = $(this).parent().prev().children(".question").text();
	//alert(question);
    question = getTextAreaValue(question);
    let href = "/opensource/admin/manage/"+"deleteFqa";
	console.log("href:"+href+", question:"+question);
	$.post(href, {"question":question}, function(data){
		alert("删除成功！");
		console.log(data);
		window.location.reload();
	});
});



$("#license-alter").click(function(){
    let username = $("#username").val();
    let license_name = $("#license_name").text();    
    license_name.replace(/[\r\n]/g,"") ;
    let name = $("input[name='name']").val();
    let abbreviation = $("input[name='abbreviation']").val();
    let abstractName = $("textarea[name='abstractName']").val();
    let owner = $("input[name='owner']").val();
    let history = $("textarea[name='history']").val();
    let origation = $("textarea[name='origation']").val();
    let translation = $("textarea[name='translation']").val();
    let originURL = $("input[name='originURL']").val();
    let SPDX = $("input[name='SPDX']").val();
    let type = $("#license-type").find("input[type='radio']:checked").val();
    let rightChecked = $("#right-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    let obligationChecked = $("#obligation-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    let prohibitionChecked = $("#prohibition-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    console.log("username:"+username);
    console.log("abbreviation:"+abbreviation);
    console.log("originURL:"+originURL);
    $.post("/opensource/admin/manage/alterLicense",
                    {"username":username,
                    "license_name":license_name,
                    "name":name,
                    "abbreviation":abbreviation,
                    "abstractName":abstractName,
                    "owner":owner,
                    "history":history,
                    "origation":origation,
                    "translation":translation,
                    "type":type,
                    "originURL":originURL,
                    "SPDX":SPDX,
                    "rightChecked":rightChecked,
                    "obligationChecked":obligationChecked,
                    "prohibitionChecked":prohibitionChecked
                }, function(data){
        alert("修改成功！");
        console.log(data);
        window.location.reload();
    });
    console.log("rightChecked:"+rightChecked);
    console.log("obligationChecked:"+obligationChecked);
    console.log("prohibitionChecked:"+prohibitionChecked);
});

$("#license-delete").click(function(){
	let license_name = $("#license_name").text();    
    license_name.replace(/[\r\n]/g,"") ;
	$.post("/opensource/admin/manage/deleteLicense",{"license_name":license_name,}, function(data){
        alert("删除成功！");
        console.log(data);
        window.location.reload();
    });
});	

$("#license-insert").click(function(){
	let username = $("#username").val(); 
    let name = $("input[name='name']").val();
    let abbreviation = $("input[name='abbreviation']").val();
    let abstractName = $("textarea[name='abstractName']").val();
    let owner = $("input[name='owner']").val();
    let history = $("textarea[name='history']").val();
    let origation = $("textarea[name='origation']").val();
    let translation = $("textarea[name='translation']").val();
    let originURL = $("input[name='originURL']").val();
    let SPDX = $("input[name='SPDX']").val();
    let type = $("#license-type").find("input[type='radio']:checked").val();
    let rightChecked = $("#right-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    let obligationChecked = $("#obligation-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    let prohibitionChecked = $("#prohibition-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    console.log("username:"+username);
    console.log("abbreviation:"+abbreviation);
    console.log("originURL:"+originURL);
    $.post("/opensource/admin/manage/addLicense",
                    {"username":username,
                    "name":name,
                    "abbreviation":abbreviation,
                    "abstractName":abstractName,
                    "owner":owner,
                    "history":history,
                    "origation":origation,
                    "translation":translation,
                    "type":type,
                    "originURL":originURL,
                    "SPDX":SPDX,
                    "rightChecked":rightChecked,
                    "obligationChecked":obligationChecked,
                    "prohibitionChecked":prohibitionChecked
                }, function(data){
        alert("新增成功！");
        console.log(data);
        window.location.href="/opensource/admin/manage/manageLicense?license_name=许可证1";
    });
    console.log("rightChecked:"+rightChecked);
    console.log("obligationChecked:"+obligationChecked);
    console.log("prohibitionChecked:"+prohibitionChecked);
});
/*
$("#license-insert").click(function(){
    let username = $("#username").val(); 
    let name = $("input[name='name']").val();
    let abbreviation = $("input[name='abbreviation']").val();
    let abstractName = $("textarea[name='abstractName']").val();
    let owner = $("input[name='owner']").val();
    let history = $("textarea[name='history']").val();
    let origation = $("textarea[name='origation']").val();
    let translation = $("textarea[name='translation']").val();
    let originURL = $("input[name='originURL']").val();
    let SPDX = $("input[name='SPDX']").val();
    let type = $("#license-type").find("input[type='radio']:checked").val();
    let rightChecked = $("#right-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    let obligationChecked = $("#obligation-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    let prohibitionChecked = $("#prohibition-describe").find("input[type='checkbox']:checked").map(function () {
        return $(this).val();
    }).get().join(',');
    console.log("username:"+username);
    console.log("abbreviation:"+abbreviation);
    console.log("originURL:"+originURL);
    $.post("/opensource/admin/manage/addLicense",
                    {"username":username,
                    "name":name,
                    "abbreviation":abbreviation,
                    "abstractName":abstractName,
                    "owner":owner,
                    "history":history,
                    "origation":origation,
                    "translation":translation,
                    "type":type,
                    "originURL":originURL,
                    "SPDX":SPDX,
                    "rightChecked":rightChecked,
                    "obligationChecked":obligationChecked,
                    "prohibitionChecked":prohibitionChecked
                }, function(data){
        alert("新增成功！");
        console.log(data);
        window.location.href="/opensource/admin/manage/manageLicense?license_name=许可证1";
    });
    console.log("rightChecked:"+rightChecked);
    console.log("obligationChecked:"+obligationChecked);
    console.log("prohibitionChecked:"+prohibitionChecked);
});
*/
$("#license-delete").click(function(){
    let license_name = $("#license_name").text();    
    license_name.replace(/[\r\n]/g,"") ;
    $.post("/opensource/admin/manage/deleteLicense",{"license_name":license_name,}, function(data){
        alert("删除成功！");
        console.log(data);
        window.location.reload();
    });
});

$("#admin-index").click(function(e){
    var e = e || window.e;
    var target = e.target || e.srcElement;
    if (target.nodeName.toLowerCase() == "button") {
      switch(target.id){
        case "fqa-template" :
            location.href="/opensource/admin/manage/downTemplate?template=template-fqa.xls";
            break;
        case "article-template" :
            location.href="/opensource/admin/manage/downTemplate?template=template-article.xls";
            break;
        case "license-template" :
            location.href="/opensource/admin/manage/downTemplate?template=template-license.xls";
            break;
        case "fqa-choose":
             $('#fqa-file').click();
            break;
        case "license-choose":
             $('#license-file').click();
            break;
        case "article-choose":
             $('#article-file').click();
            break;
        case "fqa-upload":
            let fqapath = $("#fqa-file").val();
            if (fqapath!="")
            {
                let r = confirm("请确认所选文件为："+fqapath);
                if(r == true){
                    $("#fqa-form").submit();
                }
            } 
            else {alert("请选择文件！");}
            break;
        case "article-upload":
            let articlepath = $("#article-file").val();
            if (articlepath!="")
            {
                let r = confirm("请确认所选文件为："+articlepath);
                if(r == true){
                    $("#article-form").submit();
                }
            } 
            else {alert("请选择文件！");}
            break;
        case "license-upload":
            let licensepath = $("#license-file").val();
            if (licensepath!="")
            {
                let r = confirm("请确认所选文件为："+licensepath);
                if(r == true){
                    $("#license-form").submit();
                }
            } 
            else {alert("请选择文件！");}
            break;
        }
    }
});

$("#delete-article").click(function(){
	alert("删除成功！");
});

$("#article-alter").click(function()
{
    let title = getTextAreaValue($("#alter-title").val());
    let content = getTextAreaValue($("#alter-content").val());
    let id =getTextAreaValue($("[name='alter-id']").val());
    let introduction = getTextAreaValue($("#alter-introduction").val());
    console.log("title:"+title+",introduction:"+introduction+",content:"+content+",id:"+id);
    $.post("/opensource/admin/manage/doAlterArticle",
        {"id":id,"title":title,"content":content,"introduction":introduction
        }, function(data){
        alert("修改成功！");
        console.log(data);
        window.location.reload();
    });
});

$("#article-add").click(function()
{
    let title = getTextAreaValue($("#add-title").val());
    let content = getTextAreaValue($("#add-content").val());
    let introduction = getTextAreaValue($("#add-introduction").val());
    console.log("title:"+title+",introduction:"+introduction+",content:"+content);
    $.post("/opensource/admin/manage/addArticle",
        {"title":title,"content":content,"introduction":introduction
        }, function(data){
        alert("新增成功！");
        console.log(data);
        window.location.reload();
    });
});



