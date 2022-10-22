import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  connect() {
    let todoTask = this.element.querySelector("#col-todo")
    let doingTask = this.element.querySelector("#col-doing")
    let doneTask = this.element.querySelector("#col-done")

    new Sortable(todoTask, {
      group: 'shared', // set both lists to same group
      animation: 150,
      onEnd: function (evt) {
        let taskId = evt.item.dataset.taskId
        let status = evt.to.dataset.status
        const token = document.querySelector("[name='csrf-token']").content;

        console.log()
        fetch(`/tasks_update/${taskId}`,{
          method: 'PATCH',
          headers: {
            "X-CSRF-Token": token,
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: JSON.stringify({ status: status})

        })

      }});

    new Sortable(doingTask, {
      group: 'shared', // set both lists to same group
      animation: 150,
      onEnd: function (evt) {
        let taskId = evt.item.dataset.taskId
        let status = evt.to.dataset.status
        const token = document.querySelector("[name='csrf-token']").content;

        console.log()
        fetch(`/tasks_update/${taskId}`,{
          method: 'PATCH',
          headers: {
            "X-CSRF-Token": token,
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: JSON.stringify({ status: status})

        })

      }});

    new Sortable(doneTask, {
      group: 'shared', // set both lists to same group
      animation: 150,
      onEnd: function (evt) {
        let taskId = evt.item.dataset.taskId
        let status = evt.to.dataset.status
        const token = document.querySelector("[name='csrf-token']").content;

        console.log()
        fetch(`/tasks_update/${taskId}`,{
          method: 'PATCH',
          headers: {
            "X-CSRF-Token": token,
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: JSON.stringify({ status: status})

        })

      }});
  }
}
