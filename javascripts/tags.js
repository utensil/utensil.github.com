function cal_tagcloud_width(e,t){return Math.min(60*e,Math.min(400,.8*t))}function cal_tagcloud_height(e,t){return Math.min(30*e,Math.min(250,.8*t))}var resizeTimeout={},resizeContext={};$(function(){$.getJSON("tags.json",function(e,t){$(window).resize(function(){clearTimeout(resizeTimeout),resizeTimeout=setTimeout(function(){var t=cal_tagcloud_width(e.length,resizeContext.w),n=cal_tagcloud_height(e.length,resizeContext.h),r=cal_tagcloud_width(e.length,$(window).width()),i=cal_tagcloud_height(e.length,$(window).height());if($("#tag_cloud").hasClass("inited")&&t==r&&n==i)return;$("#tag_cloud").empty().jQCloud(e,{width:r,height:i,afterCloudRender:function(){$("a",this).click(function(){var e=$(this).attr("href").toString().substring(1);return $("[id^=tag-]").each(function(t,n){encodeURI($(n).attr("id").toString())!=e?$(n).hide():$(n).show()}),!1})}}).addClass("inited")},500),resizeContext.w=$(window).width(),resizeContext.h=$(window).height()}),$(window).resize()})});