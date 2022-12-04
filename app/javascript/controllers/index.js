// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import BootstrapController from "./bootstrap_controller"
application.register("bootstrap", BootstrapController)

import Chart from 'stimulus-chartjs'
application.register('chart', Chart)

import CovidController from "./covid_controller"
application.register("covid", CovidController)

import ContentBlockController from "./content/block_controller"
application.register("content-block", ContentBlockController)

import ContentJsonController from "./content/json_controller"
application.register("content-json", ContentJsonController)


import DonationOtherAmountController from "./donation_other_amount_controller"
application.register("donation-other-amount", DonationOtherAmountController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SelectFilterController from "./select_filter_controller"
application.register("select-filter", SelectFilterController)

import Store__ManagerController from "./store/manager_controller"
application.register("store--manager", Store__ManagerController)

import TextareaAutogrow from 'stimulus-textarea-autogrow'
application.register('textarea-autogrow', TextareaAutogrow)

import UploadsController from "./uploads_controller"
application.register("uploads", UploadsController)
