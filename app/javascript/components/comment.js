import $ from "modules/jquery"

export const showCommentForm = () => {
  $('.js-comment-form-toggle').on('click', () => {
    $('.js-comment-form-toggle').addClass('hidden')
    $('.comment-form').removeClass('hidden')
  })
}

export const appendComment = (comment) => {
  $('.comments_container').append(
    `<dev class=""article_comment><p>${comment.content}</p></div>`
  )
}
