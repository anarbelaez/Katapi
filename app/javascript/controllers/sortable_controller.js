import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  connect() {
    let todoTask = this.element.querySelector("#col-todo")
    let doingTask = this.element.querySelector("#col-doing")
    let doneTask = this.element.querySelector("#col-done")
    // Sortable.create(this.element, {
    //   ghostClass: "ghost",
    //   animation: 150,
    //   onEnd: (event) => {
    //     alert(`${event.oldIndex} moved to ${event.newIndex}`)
    //   }
    // })
    new Sortable(todoTask, {
      group: 'shared', // set both lists to same group
      animation: 150,
      onMove: function (evt, originalEvent) {
console.log("moving")
      }
      });

    new Sortable(doingTask, {
        group: 'shared',
        animation: 150
        });

    new Sortable(doneTask, {
      group: 'shared',
      animation: 150
      });

  }
}
