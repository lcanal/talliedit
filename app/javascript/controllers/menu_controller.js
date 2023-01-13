import { Controller } from "@hotwired/stimulus"
import {enter, leave} from "el-transition";

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["backdrop", "backdrop2", "main", "close"]

  show(){

    enter(this.backdropTarget);
    enter(this.backdrop2Target);
    enter(this.mainTarget);
    enter(this.closeTarget);
  }

  hide() {
    Promise.all([
      leave(this.backdropTarget),
      leave(this.mainTarget),
        leave(this.closeTarget),
        leave(this.backdrop2Target)
    ]).then(() => {
      this.backdropTarget.classList.add("hidden");
      this.backdrop2Target.classList.add("hidden");
      this.mainTarget.classList.add("hidden");
      this.closeTarget.classList.add("hidden")
    });
  }
}
