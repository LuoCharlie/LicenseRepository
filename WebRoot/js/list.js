var uploadList = [];

$(function(){
    var PutDown = function(el,tag){
        this.el = el || {};
        this.tag = tag || false;
        var link = this.el.find('.link');
        $(document).on('click', '.link',{el: this.el, tag: this.tag},this.dropDown);
      //  link.on('click', {el: this.el, tag: t{el: this.el, tag: this.tag},his.tag}, this.dropDown)
        //console.log(link);
    }
    PutDown.prototype = {
        dropDown:function(e){
        var $el = e.data.el,
        $tag = e.data.tag,
        $this = $(this),
        $next = $this.next();
        //console.log($next);
        $next.slideToggle();
        $this.parent().toggleClass('open');
            //if(!$tag){
            //$el.find('.desc').not($next).slideUp().parent().removeClass('open');
       // }
        }
    }
    var putdown = new PutDown($('.total-list'),true);
})

$(document).ready(function(){

	$(document).on('click', '.link', function() {
		$(this).children("span").toggleClass('glyphicon-chevron-up');
		$(this).parent().children("ul").removeClass("hidden");
		$(this).children("span").toggleClass('glyphicon-chevron-down'); 
	});
	
	show_interpretation();
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
