// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import LocalTime from 'local-time'
LocalTime.start();

//import Quill from 'quill';
//var quill = new Quill('.quill-editor', {})


//let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
//let tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
//  return new bootstrap.Tooltip(tooltipTriggerEl)
//})
