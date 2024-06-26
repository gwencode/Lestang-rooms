// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ChatroomController from "./chatroom_controller"
application.register("chatroom", ChatroomController)

import EditReviewController from "./edit_review_controller"
application.register("edit-review", EditReviewController)

import FlatpickrAdminController from "./flatpickr_admin_controller"
application.register("flatpickr-admin", FlatpickrAdminController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import GuestsController from "./guests_controller"
application.register("guests", GuestsController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ImageGalleryController from "./image_gallery_controller"
application.register("image-gallery", ImageGalleryController)

// Captcha V2 replacing captcha V3
import LoadRecaptchaV2 from "./load_recaptcha_v2_controller"
application.register("load-recaptcha-v2", LoadRecaptchaV2)

import MapController from "./map_controller"
application.register("map", MapController)

import UpButtonController from "./up_button_controller"
application.register("up-button", UpButtonController)
