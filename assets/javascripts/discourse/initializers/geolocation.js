import { withPluginApi } from "discourse/lib/plugin-api";

function initializeGeolocation(api) {
  let latitude = "Fetching...";
  let longitude = "Fetching...";
  let userInput = ""; // Variable to store user input

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function (position) {
        latitude = position.coords.latitude;
        longitude = position.coords.longitude;

        // Update widgets when location is fetched
        updateWidgets();
      },
      function (error) {
        console.log("Error fetching location: ", error.message);
      }
    );
  } else {
    console.log("Geolocation is not supported by this browser.");
  }

  // Helper function to trigger widget updates
  function updateWidgets() {
    const banners = document.querySelectorAll(".geolocation-banner");
    const inputDisplays = document.querySelectorAll(".user-input-display");

    // Update the geolocation banner
    banners.forEach((banner) => {
      banner.innerText = `Latitude: ${latitude} | Longitude: ${longitude}`;
    });

    // Update the user input display
    inputDisplays.forEach((display) => {
      display.innerText = `You entered: ${userInput}`;
    });
  }

  // Expose the input handler globally
  window.handleUserInput = function (event) {
    userInput = event.target.value;
    updateWidgets();
  };

  // Register the widget with Discourse Plugin API
  api.decorateWidget("header:before", (helper) => {
    // Outer container
    const container = helper.h("div", { className: "geolocation-widget" }, [
      helper.h(
        "div",
        { className: "geolocation-banner" },
        `Latitude: ${latitude} | Longitude: ${longitude}`
      ),
      helper.h("input", {
        type: "text",
        placeholder: "Enter some text...",
        className: "user-input-field",
        oninput: "handleUserInput(event)", // Call the global function
      }),
      helper.h("div", {
        className: "user-input-display", // New element to display the user input
        style: "margin-top: 10px; font-size: 14px; color: #555;",
      }),
    ]);

    return container;
  });
}

export default {
  name: "geolocation",
  initialize() {
    // withPluginApi("0.8", (api) => {
    //   initializeGeolocation(api);
    // });
  },

  // initialize() {
  //   console.log("Plugin initialized successfully!");
  //
  //   withPluginApi("0.8.7", (api) => {
  //     api.decorateWidget("header:before", (helper) => {
  //       return helper.h("div.my-custom-component", [
  //         helper.h("div", { className: "my-custom-component" }),
  //         helper.attach("my-custom-component"),
  //       ]);
  //     });
  //   });
  // },
};
