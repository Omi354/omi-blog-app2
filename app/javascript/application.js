// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import jQuery from "jquery"
import 'axios'
import { fetchHeartStatus, submitLike, removeLike, fetchComments } from "modules/ajax"
import { showCommentForm } from "components/comment"

const csrfToken = document.getElementsByName('csrf-token')[0].content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
window.$ = jQuery

document.addEventListener('turbo:load', () => {
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId
    showCommentForm()

    fetchHeartStatus(articleId)
    fetchComments(articleId)

    submitLike(articleId)
    removeLike(articleId)

    $('#comment-submit-btn').on('click', () => {
        const content = $('#comment').val()
        if (content == '') {
            window.alert('コメントを入力してください')
            return;
        }

        axios.post(`/articles/${articleId}/comments`,
            { comment: { content: content } }
        )
          .then(response => {
            $('.comments_container').append(
                `<dev class=""article_comment><p>${response.data.content}</p></div>`
            )
            $('#comment').val('')
        })
          .catch(error => {
            console.log(error)
          })
      })
})