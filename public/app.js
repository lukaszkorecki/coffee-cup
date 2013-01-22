var getCoffees = function(cb) { $.get("/coffees", cb); };

var getUsers = function(cb) { $.get( "/team",cb); };

// duplication, but who cares?
var renderCoffees = function(element, coffees) {
  var el = $(element);
  $(coffees).each(function(index, item) {
    console.log(item);
    el.append("<div class='coffee-cell' style='background-color: "+item.color+"';><a href='#' data-coffee='"+item.name+"'>"+item.name+"</a></div>");
  });
};


var renderUsers = function(element, users) {
  var el = $(element);
  $(users).each(function(index, item) {
    console.log(item);
    el.append("<div class='user-cell' ><a href='#' data-user='"+item.name+"'>"+item.name+"</a></div>");
  });
};

$(document).ready(function() {
  console.log('ready');
  getCoffees(function(data) { renderCoffees('#coffeeList', data);
  });
  getUsers(function(data) { renderUsers('#userList', data); } );
});
