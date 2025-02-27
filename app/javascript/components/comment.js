import jQuery from "jquery"
window.$ = jQuery

export const showCommentForm = () => {
  $('.js-comment-form-toggle').on('click', () => {
    $('.js-comment-form-toggle').addClass('hidden')
    $('.comment-form').removeClass('hidden')
  })
}
