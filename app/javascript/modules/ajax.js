import jQuery from "jquery"
import 'axios'
import { handleHeartDisplay, displayHeartActive, displayHeartInactive } from "components/like"

const csrfToken = document.getElementsByName('csrf-token')[0].content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
window.$ = jQuery

export const fetchHeartStatus = (articleId) => {
  axios.get(`/articles/${articleId}/like`)
    .then(response => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })
    .catch(error => {
      console.error('Error:', error)
    })
}

export const submitLike = (articleId) => {
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
}

export const removeLike = (articleId) => {
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
}
