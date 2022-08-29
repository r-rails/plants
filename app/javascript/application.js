// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";

let tabs = document.querySelectorAll(".house-plant-tabs");

tabs.forEach((tab) => {
  tab.addEventListener("click", () => {
    tabs.forEach((sibling) => {
      sibling.classList.remove("bg-blue-700");
      sibling.classList.add("bg-emerald-300");
    });
    tab.classList.remove("bg-emerald-300");
    tab.classList.add("bg-blue-700");
  });
});
