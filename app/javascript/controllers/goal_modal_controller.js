import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="goal-modal"
export default class extends Controller {
  static values = { information: Array }

  connect() {
    this.showModal();
  }

  showModal(){
    const modalGoal = document.getElementById('modalGoal')
    modalGoal.addEventListener('show.bs.modal', event => {
    const goal = event.relatedTarget
    const goalName = goal.getAttribute('data-bs-goal-name')
    const goalDescription = goal.getAttribute('data-bs-goal-description')
    const goalCategory = goal.getAttribute('data-bs-goal-category')
    const goalMaturity = goal.getAttribute('data-bs-goal-maturity')
    const goalDate = goal.getAttribute('data-bs-goal-date')
    const goalUrl = goal.getAttribute('data-bs-goal-url')
    const tasksNotstarted = goal.getAttribute('data-bs-goal-tasks-nostarted')
    const tasksInprogress = goal.getAttribute('data-bs-goal-tasks-inprogress')
    const tasksDone = goal.getAttribute('data-bs-goal-tasks-done')
    console.log(tasksDone, tasksInprogress)
    const goalNameM = modalGoal.querySelector('#goalName')
    const goalDescriptionM = modalGoal.querySelector('#goalDescription')
    const goalCategoryM = modalGoal.querySelector('#goalCategory')
    const goalDateM = modalGoal.querySelector('#goalDate')
    const goalLink = modalGoal.querySelector('#goalLink')
    const tasksNotstartedM = modalGoal.querySelector('#taskCountNotStarted')
    const tasksInprogressM = modalGoal.querySelector('#taskCountInProgress')
    const tasksDoneM = modalGoal.querySelector('#taskCountDone')
    const goalImage = modalGoal.querySelector('#goalImage')

    goalNameM.textContent = `${ goalName }`
    goalDescriptionM.textContent = `${ goalDescription }`
    goalCategoryM.textContent = `${ goalCategory }`
    goalDateM.textContent = `${ goalDate }`
    tasksNotstartedM.textContent = `${ tasksNotstarted }`
    tasksInprogressM.textContent = `${ tasksInprogress }`
    tasksDoneM.textContent = `${ tasksDone }`
    goalLink.href = goalUrl

    let link = ""
    if (goalMaturity === "baby") {
      goalImage.src = "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668017718/arbol_bebe_uab5p1.png"
    } else if (goalMaturity === "young") {
      goalImage.src = "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668017718/arbol_young_bybm1s.png"
    } else {
      goalImage.src = "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668017721/arbol_adulto_grrhmj.png"
    }

  })
  }
}
