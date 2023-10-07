import { Controller } from "@hotwired/stimulus"
import {enter, leave} from "el-transition";

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = ["notification"]
  connect() {
    enter(this.notificationTarget);
    setInterval(() => {
        this.hide();
    } , 3000);
  }

  hide() {
    Promise.all([
        leave(this.notificationTarget)
    ]).then(() => {
      this.notificationTarget.classList.add("hidden");
    })
  }


}
