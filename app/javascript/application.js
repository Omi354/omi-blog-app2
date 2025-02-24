// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import jquery from "jquery"
window.$ = jquery

$(function(){
  alert("jQuery 動いた！")
})