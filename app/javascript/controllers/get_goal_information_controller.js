import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-goal-information"
export default class extends Controller {
  static targets = ["goalId"]

  connect() {
  }

  ask() {
    let id = this.goalIdTarget.value
    return fetch(`http://localhost:3000/get_json?goal_id=${id}`)
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })
  }
}
