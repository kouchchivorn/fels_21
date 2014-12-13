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

$(document).on("page:change", function(){
    $(".word_answer_item").on("click",function(){
        $this=$(this);
        $(".word_answer_item").each(function(){
            $(this).prop("checked", false);
        })
        $this.prop("checked",true);
    });
});

