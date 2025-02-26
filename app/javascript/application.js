// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import jQuery from "jquery"
import 'axios'
import { fetchHeartStatus, submitLike, removeLike } from "modules/ajax"

const csrfToken = document.getElementsByName('csrf-token')[0].content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
window.$ = jQuery

document.addEventListener('turbo:load', () => {
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId

    fetchHeartStatus(articleId)
    submitLike(articleId)
    removeLike(articleId)

    axios.get(`/articles/${articleId}/comments`)
    .then(response => {
        const comments = response.data
        comments.forEach(comment => {
            $('.comments_container').append(
                `<dev class=""article_comment><p>${comment.content}</p></div>`
            )
        });
    })
    .catch(error => {
      console.error('Error:', error)
    })


})