var addwhere = "#add_rights";
var nowwhere = "#rights";
$(document).ready(function(){
	$("#result").hide();
	$("#click_previous").attr({"disabled":"disabled"});	
	$(".search_engine-select").change(function(){
		var select = $(this.options[this.selectedIndex]);
		var choose = select.text();
		if(choose != "-- 选择 --")
		{
			var test = "<tr><td>"+choose+"<span></span></td></tr>";	
			var temp = addwhere+" span";
			var num =$(addwhere).children("tr").length;
			if(num == 1)
			{
				var delete_blank = addwhere +" .remove";
				$(delete_blank).remove();
			}
				$(addwhere).append(test);
				$(temp).addClass("glyphicon glyphicon-remove");
				$(temp).addClass("delete-style");
				$(select).css({"color":"#CCC"});
				$(select).attr({"disabled":"disabled"});
		}
	});
	$(".search_engine-table").on("click","span",function(){
		var delete_tr = $($(this).parent()).parent();
		var delete_td = $(this).parent();
		var delete_father = $($($(this).parent()).parent()).parent();
		var child = $(delete_tr).find("td");
		var num =$(delete_father).children("tr").length;
		var td_text = $(delete_td).text();
		var tbody_class = $(delete_father).attr("class");
		nowwhere = "#" + tbody_class;			
		var restore = "#" + tbody_class + " option[value='" + td_text + "']";
		$(restore).attr("disabled",false);
		$(restore).css({"color":"#000"});
		if(num>1)
		{			
			$(delete_tr).remove();
			$(temp).addClass("glyphicon glyphicon-remove");
		}
		else 
		{
			$(child).remove();
			$(delete_tr).addClass("remove");
		}
	});
	
	$("#click_next").click(function(){
		var temp = "#" + $(nowwhere).next().attr("id");
		var next ="#click" + $(nowwhere).next().attr("id");
		 //alert(next);
		$(next).click();
		nowwhere = temp;
		if(nowwhere == "#prohibition")
		{
		 	$("#click_next").attr({"disabled":"disabled"});
		}
	});
	 
	$("#click_previous").click(function(){
		var temp = "#" + $(nowwhere).prev().attr("id");
		var prev ="#click" + $(nowwhere).prev().attr("id");
		 //alert(next);
		$(prev).click();
		nowwhere = temp;
		if(nowwhere == "#rights")
		{
		 	$(this).attr({"disabled":"disabled"});
		}		
	});
	 
	 $("#click_ok").click(function(){
		var postData = new Array();
		var rights = "";
		var obligations = "";
		var prohibition = "";
		$("#add_rights tr td").each(function() {
			rights = rights + ($(this).text())+ "," ;
			
		});
		postData.push(rights);
		$("#add_obligations tr td").each(function() {
			obligations = obligations + ($(this).text()) + ",";
			// postData.push(obligations);
		});
		postData.push(obligations);
		$("#add_prohibition tr td").each(function() {
			prohibition = prohibition + ($(this).text()) + ",";
			// postData.push(prohibition)
		});
		$.post("/opensource/license/searchEngine", 
			{
				"rights":rights,
				"obligations":obligations,
				"prohibition":prohibition
			}, 
			function(data){
				console.log(data);
				window.location.href="/opensource/search_engine_result.jsp";
		});

		/* postData.push(prohibition);
		 Submit(postData);*/
	});
});	

/*
function Submit(postData) {
    //window.location.href = contextPath+'/getAgentPosImportStatementListWithPaging.jhtml?agentNo='+agentNo;
    document.write("<form action=./license/searchEngine method=post name=form1 style='display:none' accept-charset=\"UTF-8\">");
    document.write("<input type=hidden name=rights value='"+postData[0]+"'/>");
    document.write("<input type=hidden name=obligations value='"+postData[1]+"'/>");
    document.write("<input type=hidden name=prohibition value='"+postData[2]+"'/>");
    document.write("</form>");
    document.form1.submit();
}*/

function show_rights(){
	nowwhere = "#rights";
	$("#click_next").attr("disabled",false);
	$("#click_previous").attr("disabled","disabled");
	document.getElementById("rights").style.display="block";
	document.getElementById("obligations").style.display="none";
	document.getElementById("prohibition").style.display="none";
	addwhere = "#add_rights";	
}

function show_obligations(){
	nowwhere = "#obligations";
	$("#click_next").attr("disabled",false);
	$("#click_previous").attr("disabled",false);
	document.getElementById("rights").style.display="none";
	document.getElementById("obligations").style.display="block";
	document.getElementById("prohibition").style.display="none";
	addwhere = "#add_obligations";	
}

function show_prohibition(){
	nowwhere = "#prohibition";
	$("#click_next").attr("disabled","disabled");
	$("#click_previous").attr("disabled",false);
	document.getElementById("rights").style.display="none";
	document.getElementById("obligations").style.display="none";
	document.getElementById("prohibition").style.display="block";
	addwhere = "#add_prohibition";	
}
