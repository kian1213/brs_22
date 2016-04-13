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

function remove_fields(link) {
  $(link).parent().children('.removable')[0].value = 1;
  $(link).parent().parent().hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(".added-field").append(content.replace(regexp, new_id));
}
