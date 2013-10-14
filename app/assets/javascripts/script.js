function onPage(page){
  return $("body").hasClass(page);
}
function loadingIcon(target){                         //loadingIcon(".loading");
  var loaderSymbols = ['0', '1', '2', '3', '4', '5', '6', '7']; 
	var loaderIndex = 0;
	loadAction = setInterval(function(){
		loaderIndex = loaderIndex  < loaderSymbols.length - 1 ? loaderIndex + 1 : 0;
		$(target).addClass("symbols").html(loaderSymbols[loaderIndex]);
	}, 100);
}

$(function(){
//show/hide flash messages
	if($('.msg').html() != ""){
		$('.messages').show(0);
	}
	setTimeout(function(){
		$('.messages').fadeOut(200);
	}, 2500);
	
//insert attachment
  $(document).on("click", ".fileAttachment", function(e){
  	e.preventDefault();
  	var ed = $("textarea").data("wysihtml5").editor;
  	var path = $(this).attr("href");
  	var label = $(this).data("label");
  	var ext = path.split(".").pop().replace(/\d/g, "").replace(/\?/, "");
  	var img = (ext == "jpg" || ext == "png" || ext == "gif" || ext == "jpeg" || ext == "png");
  	var host = window.location.hostname;
  	var url = "http://"+host+path;
  	ed.focus();
  	if(img){
  		ed.composer.commands.exec("insertImage", url)
  	} else {
  		ed.composer.commands.exec("insertHTML", "<a href='"+url+"'>"+label+"</a>")
  	}
  	$('#attachments').modal('hide');
  });
//about tabs
  $(".pages-about a.col-select-tab").click(function(e){
  	e.preventDefault();
  	var column = $(this).data("col");
  	var open = $(".display-column.open");
  	var selector = $(this).closest(".select-column");
  	var openSelector = $(open).data("select");
  	$(selector).hide();
  	$("."+openSelector).show();
  	if(column == "pb-display-col"){
  		$(".ins-col").addClass("onRight");
  	} else {
  		$(".ins-col").removeClass("onRight");
  	}
    $(open).animate({width: "0"}, 0, function(){$(open).hide().css({"padding":"0px"})});
  	$(open).removeClass("open");
		$("."+column).addClass("open");
  	$("."+column).css({"display":"block", "padding-left":"15px", "padding-right":"15px"});
  	$("."+column).animate({width: "66.66666666666666%"}, 0, function(){
  		$("."+column).mCustomScrollbar("update");
  		if($(".faq-col").is(":visible")){
    		$(".faq-col").addClass("active");
    	} else {
    		$(".faq-col").removeClass("active");
    	}
  	});
  });
//contact tabs
  $(".pages-contact a.col-select-tab").click(function(e){
  	e.preventDefault();
  	var column = $(this).data("col");
  	var open = $(".display-column.open");
  	var selector = $(this).closest(".select-column");
  	var openSelector = $(open).data("select");
  	$(selector).hide();
  	$("."+openSelector).show();
  	if(column == "pb-display-col"){
  		$(".ins-col").addClass("onRight");
  	} else {
  		$(".ins-col").removeClass("onRight");
  	}
    $(open).animate({width: "0"}, 0, function(){$(open).hide().css({"padding":"0px"})});
  	$(open).removeClass("open");
		$("."+column).addClass("open");
  	$("."+column).css({"display":"block", "padding-left":"15px", "padding-right":"15px"});
  	$("."+column).animate({width: "83.33333333333334%"}, 0, function(){
  		$("."+column).mCustomScrollbar("update");
  		if($(".faq-col").is(":visible")){
    		$(".faq-col").addClass("active");
    	} else {
    		$(".faq-col").removeClass("active");
    	}
  	});
  });

//news images
  $("#news section img").each(function(idx, el){
  	$(el).parent().css({"float":"left","margin-bottom":"0","margin-right":"20px"});
  });
//editor mode switch
  $(".toHTML").click(function(e){
  	e.preventDefault();
  	var ed = $("textarea").data("wysihtml5").editor;
  	if (ed.currentView === ed.textarea) {
      ed.fire("change_view", "composer");
      $(".toHTML").html("HTML Mode");
      $(".wysihtml5-toolbar").show();
    } else {
      ed.fire("change_view", "textarea");
      $(".toHTML").html("Graphical Mode");
      $(".wysihtml5-toolbar").hide();
    }
  });
//event popup
  $(".day_event_container > a").click(function(e){
  	var event_id = $(this).data("event_id");
  	var top_offset = $(this).offset().top;
  	var scroll_offset = $("#wrapper").scrollTop();
  	var left_offset= $(this).offset().left;
  	var width = $(this).width();
  	$(".day_event_details").hide();
  	$("#event_info_"+event_id).css({top: (top_offset-10+scroll_offset), left: (left_offset+width+10), zIndex: "9"}).show();
  	return false;
  });
  $(".day_event_details").click(function(e){
  	e.stopPropagation();
  });
  $("#wrapper").click(function(e){
  	$(".day_event_details").hide();
  });
//event more link
  if(onPage("pages-calendar")){
    $(".events > div > div").each(function(){
      var events_height = $(this)[0].scrollHeight;
      if(events_height > 140){
        var events_count = (events_height-140)/30;
        $(this).parent().append("<a href='#' class='more more_events' data-event_count='"+events_count+"'>"+events_count+" more &raquo;</a>");
      }
    });
    $(document).on("click", ".more_events", function(){
      var events_count = $(this).data("event_count");
      $(this).prev("div").css({height: "+="+(events_count*30)+"px", zIndex: "9"});
      $(this).css({bottom: "-="+(events_count*30)+"px", zIndex: "9"}).html("less &raquo").addClass("less_events").removeClass("more_events");
      $(this).closest("td").css("border-bottom", "0");
      return false;
    });
    $(document).on("click", ".less_events", function(){
      var events_count = $(this).data("event_count");
      $(this).prev("div").css({height: "-="+(events_count*30)+"px", zIndex: "auto"});
      $(this).css({bottom: "+="+(events_count*30)+"px", zIndex: "auto"}).html(events_count+" more &raquo").addClass("more_events").removeClass("less_events");
      $(this).closest("td").css("border-bottom", "1px solid #ddd");
      return false;
    });
  }

});

//vertically center content + scrolling
$(window).load(function(){
  
  if(!onPage("admin")){
  	var wHeight = $(window).height();
  	if(wHeight < 530){
  		$("header#header, .logo, .nav-item").addClass("short");
  	} else {
  		$("header#header, .logo, .nav-item").removeClass("short");
  	}
  	if(wHeight < 750){
  		$(".photo-bg.index-photo").addClass("reduce");
  	} else {
  		$(".photo-bg.index-photo").removeClass("reduce");
  	}
    var wWidth = $(window).width();
    var rHeight = ($("header#header").outerHeight() + $("footer#footer").outerHeight());
    var pHeight;
    var wHeight;
    if(onPage("pages-index")){
    	pHeight = $(".photo-bg").outerHeight();
      wHeight = wHeight - rHeight - pHeight;
      $(".text-blocks").height(wHeight-19);
    } else if(onPage("pages-about")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
      
      if(wWidth > 640){
        $(".display-column").mCustomScrollbar({
          scrollInertia:150,
          scrollButtons:{
    				enable:true
    			},
    			theme: "dark"
        });
      }
    } else if(onPage("pages-news") || onPage("pages-article")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
    	
      if(wWidth > 640){
      	$("#news").mCustomScrollbar({
          scrollInertia:150,
          scrollButtons:{
    				enable:true
    			},
    			theme: "dark"
        });
      }
    } else if(onPage("pages-calendar")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
    	
    } else if(onPage("pages-contact")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
      
      if(wWidth > 640){
        $(".display-column").mCustomScrollbar({
          scrollInertia:150,
          scrollButtons:{
    				enable:true
    			},
    			theme: "dark"
        });
      }
    }
    var uCruft = $("header#header .logo").offset().left;
    var lCruft = $("footer#footer .footer-large").offset().left;
    $(".cruft-upperleft").width(uCruft);
    $(".cruft-upperright").width(uCruft);
    $(".cruft-lowerleft").width(lCruft);
    $(".cruft-lowerright").width(lCruft);
  }

});
$(window).resize(function(){
  if(!onPage("admin")){
  	var wHeight = $(window).height();
  	if(wHeight < 530){
  		$("header#header, .logo, .nav-item").addClass("short");
  	} else {
  		$("header#header, .logo, .nav-item").removeClass("short");
  	}
  	if(wHeight < 750){
  		$(".photo-bg.index-photo").addClass("reduce");
  	} else {
  		$(".photo-bg.index-photo").removeClass("reduce");
  	}
    var wWidth = $(window).width();
    var rHeight = ($("header#header").outerHeight() + $("footer#footer").outerHeight());
    var pHeight;
    var wHeight;
    if(onPage("pages-index")){
    	pHeight = $(".photo-bg").outerHeight();
      wHeight = wHeight - rHeight - pHeight;
      $(".text-blocks").height(wHeight-19);
    } else if(onPage("pages-about")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
      
      
    } else if(onPage("pages-news") || onPage("pages-article")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
    	
    	
    } else if(onPage("pages-calendar")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
    	
    } else if(onPage("pages-contact")){
    	pHeight = wHeight - rHeight - 2;
    	$(".photo-bg").height(pHeight);
      
      
    }
    var uCruft = $("header#header .logo").offset().left;
    var lCruft = $("footer#footer .footer-large").offset().left;
    $(".cruft-upperleft").width(uCruft);
    $(".cruft-upperright").width(uCruft);
    $(".cruft-lowerleft").width(lCruft);
    $(".cruft-lowerright").width(lCruft);
  }
});