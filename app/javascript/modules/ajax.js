import $ from "modules/jquery"
import axios from "modules/axios"
import { handleHeartDisplay, displayHeartActive, displayHeartInactive } from "components/like"
import { appendComment } from "components/comment"


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

export const fetchComments = (articleId) => {
  axios.get(`/articles/${articleId}/comments`)
  .then(response => {
      const comments = response.data
      comments.forEach(comment => {
        appendComment(comment)
      })
  })
  .catch(error => {
    console.error('Error:', error)
  })
}

export const submitComment = (articleId) => {
  $('#comment-submit-btn').on('click', () => {
    const content = $('#comment').val()
    if (!content) {
        window.alert('コメントを入力してください')
        return;
    }

    axios.post(`/articles/${articleId}/comments`,
        { comment: { content: content } }
    )
      .then(response => {
        appendComment(response.data)
        $('#comment').val('')
    })
      .catch(error => {
          if (error.response && error.response.data.errors) {
          alert(error.response.data.errors.join(', '))
        } else {
          console.log(error)
        }
      })
  })
}
