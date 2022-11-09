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

    goalNameM.textContent = `${ goalName }`
    goalDescriptionM.textContent = `${ goalDescription }`
    goalCategoryM.textContent = `${ goalCategory }`
    goalDateM.textContent = `${ goalDate }`
    tasksNotstartedM.textContent = `${ tasksNotstarted }`
    tasksInprogressM.textContent = `${ tasksInprogress }`
    tasksDoneM.textContent = `${ tasksDone }`
    goalLink.href = goalUrl
  })
  }
}
