// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import jQuery from "jquery"
import 'axios'

const csrfToken = document.getElementsByName('csrf-token')[0].content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
window.$ = jQuery

const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $(`.heart-active`).removeClass(`hidden`)
  } else {
    $(`.heart-inactive`).removeClass(`hidden`)
  }
}

const displayHeartActive = () => {
  $(`.heart-active`).removeClass(`hidden`)
  $(`.heart-inactive`).addClass(`hidden`)
}

const displayHeartInactive = () => {
  $(`.heart-active`).addClass(`hidden`)
  $(`.heart-inactive`).removeClass(`hidden`)
}

document.addEventListener('turbo:load', () => {
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId

    axios.get(`/articles/${articleId}/like`)
      .then(response => {
        const hasLiked = response.data.hasLiked
        handleHeartDisplay(hasLiked)
      })
      .catch(error => {
        console.error('Error:', error)
      })

    $('.heart-inactive').on('click', () => {
      axios.post(`/articles/${articleId}/like`)
        .then(response => {
          if(response.data.status == 'ok') {
            displayHeartActive()
          }
        })
        .catch(error => {
          console.log(error)
        })
    })

    $('.heart-active').on('click', () => {
      axios.delete(`/articles/${articleId}/like`)
        .then(response => {
          if(response.data.status == 'ok') {
            displayHeartInactive()
          }
        })
        .catch(error => {
          console.error('いいね削除でエラーが発生しました:', error)
        })
    })
})