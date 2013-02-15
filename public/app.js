// bust mobile safari's cache
$.ajaxSetup({
  cache: false,
  headers: {
    'Cache-Control': 'no-cache'
  }
});
var getCoffees = function(cb) { $.get("/coffees", cb); };

var getUsers = function(cb) { $.get( "/team",cb); };

var updateStats = function(state, cb) {
  var coffee = encodeURIComponent(state.selected_coffee),
      user = encodeURIComponent(state.selected_user);
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
    // jesus, this sucks but I don't want to pull in a templating lib
    var buff = "";
        buff += "<div class='cell user-cell' ><a href='#' data-user='";
        buff += item.name;
        buff += "'>";
        buff += "<img src='";
        buff += item.face_url;
        buff += "' />";
        buff += "</a></div>";

    el.append(buff);
  });
};

// woooo global state!
var _state = {
  selected_user : false,
  selected_coffee : false
};

var resetState = function() {
  _state.selected_coffee = false;
  _state.selected_user = false;
  $('#coffeeList').hide();
  $('#userList').show();
  $('#header .back').hide();
};

var showCoffeePane = function() {
  $('#coffeeList').show();
  $('#header .back').show();
  $('#userList').hide();
};

var userSelected = function() {
  console.log(this);
  _state.selected_user = $(this).data('user');
  $('#coffeeList h1 span').html(_state.selected_user);
  showCoffeePane();
  return false;
};
var coffeeSelected = function() {
  console.log(this);
  _state.selected_coffee = $(this).data('coffee');

  console.dir(_state);
  if(_state.selected_user && _state.selected_coffee) {
    updateStats(_state, function() {
      console.log("OK!");
      _state.selected_coffee = false;
      _state.selected_user = false;
      resetState();
    });
  }
  return false;
};

$(document).ready(function() {
  getCoffees(function(data) { renderCoffees('#coffeeList div', data);
  });
  getUsers(function(data) { renderUsers('#userList div', data); } );


  $('#header .back a').click(resetState);
  $("#coffeeList").delegate(".coffee-cell a, .coffee-cell", 'click', coffeeSelected);
  $("#userList").delegate(".user-cell a, .coffee-cell", 'click', userSelected);
  resetState();
});
