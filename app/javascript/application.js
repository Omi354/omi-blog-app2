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
})