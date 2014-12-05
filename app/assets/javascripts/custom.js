function caculateHeight(){
    var i=0;
    $(".table").find(".category_side").each(function(){
        $(".table").find(".empty_side").eq(i).height($(this).height());
        i++;
    });
}

$(document).on("page:change",function(){
    $("#Category").on("click", function(){
    });
    $("#Category").trigger("click");
    caculateHeight();
});

$(document).on("page:change", function(){
    $(".word_answer").on("click",function(e){
        $this = $(this);
        $this.parent().hide().next().next().show();
        $this.css("background-color", "red");
        e.preventDefault();
    });
    $(".next").on("click",function(e){
        $(this).parent().hide().next().next().show();
        e.preventDefault();
    });
    $(".previous").on("click",function(e){
        $(this).parent().hide().prev().prev().show();
        e.preventDefault();
    });
});




