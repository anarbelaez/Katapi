// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./bootstrap_js/modal_for_goal"
import "bootstrap"
import "trix"
import "@rails/actiontext"
import "./plugins/trix-editor-overrides"

import { initSweetalert } from './plugins/init_sweetalert';

document.addEventListener('DOMContentLoaded', function () {
  let table = new DataTable('#example');
});

initSweetalert('#sweet-alert-demo', {
  title: "A nice alert",
  text: "This is a great alert, isn't it?",
  icon: "success"
}, (value) => {
  console.log(value);
});

import "chartkick/chart.js"
import "chartkick"
