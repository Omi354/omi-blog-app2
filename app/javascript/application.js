// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import { fetchHeartStatus, submitLike, removeLike, fetchComments, submitComment } from "modules/ajax"
import { showCommentForm } from "components/comment"
import $ from "modules/jquery"


document.addEventListener('turbo:load', () => {
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId
    showCommentForm()

    fetchHeartStatus(articleId)
    fetchComments(articleId)

    submitLike(articleId)
    removeLike(articleId)

    submitComment(articleId)
})