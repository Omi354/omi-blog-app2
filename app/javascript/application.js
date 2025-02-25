// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import jQuery from "jquery"
import 'axios'

window.$ = jQuery

document.addEventListener('turbo:load', () => {
  $('.article_title').on('click', () => {
    axios.get('/')
      .then(response => {
        console.log(response.data)
      })
      .catch(error => {
        console.error('Error:', error)
      })
  })
})