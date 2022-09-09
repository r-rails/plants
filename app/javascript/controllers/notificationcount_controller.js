import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  increasebyone() {
    var headerCounter = document.querySelector('.notification-count')
    headerCounter.innerHTML = Number(headerCounter.innerHTML) + 1
  }

  decreasebyone() {
    var headerCounter = document.querySelector('.notification-count')
    headerCounter.innerHTML = Number(headerCounter.innerHTML) - 1
  }
}
