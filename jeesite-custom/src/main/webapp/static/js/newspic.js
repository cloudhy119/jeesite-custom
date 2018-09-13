jQuery.fn.extend({
        picture:function(t){
          return this.each(function(){
            var id="#"+$(this).attr("id");
            var n = -1, i_count,interval="<ul class='banner_ul'>";
            i_count=$(id+"_list a").length;
            for(var i=0;i<i_count;i++){
                interval+="<li>"+(i+1)+"</li>";
            }
            $(id+"_info").after(interval+"<\/ul>");
            $(id+" li").click(function(e) {
                e.stopPropagation();
                n=$(this).index();
                $(id+"_info").html($(id+"_list a").eq(n).find("img").attr('alt'));
                $(id+"_list a").filter(":visible").fadeOut(500).parent().children().eq(n).fadeIn(1000);
                $(this).addClass("banner_on");
                $(this).siblings().removeAttr("class");
            });
            interval = setInterval(showAuto, t);
            $(this).hover(function(){clearInterval(interval)}, function(){interval = setInterval(showAuto, t)});
            function showAuto(){
                n = n >=(i_count-1) ? 0 : ++n;
                $(id+" li").eq(n).click();
            }
            showAuto();
          })
        }
    });
    $(document).ready(function(){
        $("#ban1,#ban2,#ban3,#ban4").picture(5000);
        //还可继续加
    });