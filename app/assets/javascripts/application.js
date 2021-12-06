// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs 
//= require popper
//= require bootstrap

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
    x.innerHTML = "Latitude: " + position.coords.latitude +
        "<br>Longitude: " + position.coords.longitude;
}

$(document).on('ready', function(event) {
    getLocation();

    const center = { lat: 50.064192, lng: -130.605469 };
// Create a bounding box with sides ~10km away from the center point
    const defaultBounds = {
        north: center.lat + 0.1,
        south: center.lat - 0.1,
        east: center.lng + 0.1,
        west: center.lng - 0.1,
    };
    const input = document.getElementById('gmaps_input_address');

    const searchBox = new google.maps.places.SearchBox(input, {
        bounds: defaultBounds
    });

    const input2 = document.getElementById('gmaps_input_address1');

    const searchBox2 = new google.maps.places.SearchBox(input2, {
        bounds: defaultBounds
    });

    const input3 = document.getElementById('gmaps_input_address2');

    const searchBox3 = new google.maps.places.SearchBox(input3, {
        bounds: defaultBounds
    });
});