function caculateHeight(){
    var i=0;
    $(".table").find(".category_side").each(function(){
        $(".table").find(".empty_side").eq(i).height($(this).height());
        i++;
    });
}

$(document).on("page:change",function(){
    caculateHeight();
});

$(document).on("page:change", function(){
    $(".next").on("click",function(e){
        $(this).parent().hide().next().next().show();
        e.preventDefault();
    });
    $(".previous").on("click",function(e){
        $(this).parent().hide().prev().prev().show();
        e.preventDefault();
    });
});




