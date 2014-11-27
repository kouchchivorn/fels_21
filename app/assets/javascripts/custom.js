$(function(){
    empty_side = $(".table").find(".empty_side");
    var i=0;
    var category_side = $(".table").find(".category_side").each(function(){
        empty_side.eq(i).height($(this).height());
        i++;
    });
});

