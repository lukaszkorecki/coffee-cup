var getCoffees = function(cb) { $.get("/coffees", cb); };

var getUsers = function(cb) { $.get( "/team",cb); };

var updateStats = function(state, cb) {
  var coffee = state.selected_coffee,
      user = state.selected_user;
  $.post("/update/"+coffee+"/"+user,  cb);
};

// duplication, but who cares?
var renderCoffees = function(element, coffees) {
  var el = $(element);
  $(coffees).each(function(index, item) {
    el.append("<div class='cell coffee-cell' style='background-color: "+item.color+"';><a href='#' data-coffee='"+item.name+"'>"+item.name+"</a></div>");
  });
};


var renderUsers = function(element, users) {
  var el = $(element);
  $(users).each(function(index, item) {
    el.append("<div class='cell user-cell' ><a href='#' data-user='"+item.name+"'>"+item.name+"</a></div>");
  });
};

// woooo global state!
var _state = {
  selected_user : false,
  selected_coffee : false
};

var userSelected = function() {
  console.log(this);
  _state.selected_user = $(this).data('user');
  $(this).parent().addClass("selected");
  $('#coffeeList h1 span').html(_state.selected_user);
  console.dir(_state);
  return false;
};
var coffeeSelected = function() {
  console.log(this);
  _state.selected_coffee = $(this).data('coffee');
  $(this).parent().addClass("selected");

  console.dir(_state);
  if(_state.selected_user && _state.selected_coffee) {
    updateStats(_state, function() {
      console.log("OK!");
      _state.selected_coffee = false;
      _state.selected_user = false;
      $(".selected").each(function() { $(this).removeClass("selected"); });
    });
  }
  return false;
};

$(document).ready(function() {
  getCoffees(function(data) { renderCoffees('#coffeeList div', data);
  });
  getUsers(function(data) { renderUsers('#userList div', data); } );

  $("#coffeeList").delegate(".coffee-cell a, .coffee-cell", 'click', coffeeSelected);
  $("#userList").delegate(".user-cell a, .coffee-cell", 'click', userSelected);
});
