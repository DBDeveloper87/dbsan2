// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import LocalTime from 'local-time'
LocalTime.start();

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
//import Prism from 'prismjs';
