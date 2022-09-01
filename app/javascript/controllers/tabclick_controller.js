import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("connected");
  }

  swapclass(event) {
    var tabs = [...document.querySelectorAll(".house-plant-tabs")];

    tabs.forEach((tab) => {
      tab.classList.remove("bg-blue-700");
      tab.classList.add("bg-emerald-300");
    });
    event.target.classList.remove("bg-emerald-300");
    event.target.classList.add("bg-blue-700");
  }
}
