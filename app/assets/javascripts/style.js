$(document).on("ready page:load", function(){
  $("#flash").delay(500).fadeIn("normal", function(){
    $(this).delay(2000).fadeOut();
  });

  $("#index-list th, #index-list .pagination").on("click", "a", function(){
    $.getScript(this.href);
    return false;
  });

  $("#form_search input").keyup(function(){
    $.get($("#form_search").attr("action"), $("#form_search").serialize(), null, "script");
    return false;
  });
});
