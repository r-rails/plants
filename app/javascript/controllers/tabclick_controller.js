import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  swapclass(event) {
    var tabs = [...document.querySelectorAll(".house-plant-tabs")];

    tabs.forEach((tab) => {
      tab.classList.remove("bg-emerald-400");
      tab.classList.add("bg-emerald-200");
    });
    event.target.classList.remove("bg-emerald-200");
    event.target.classList.add("bg-emerald-400");
  }
}
