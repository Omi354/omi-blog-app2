import jQuery from "jquery"
window.$ = jQuery

export const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $(`.heart-active`).removeClass(`hidden`)
  } else {
    $(`.heart-inactive`).removeClass(`hidden`)
  }
}

export const displayHeartActive = () => {
  $(`.heart-active`).removeClass(`hidden`)
  $(`.heart-inactive`).addClass(`hidden`)
}

export const displayHeartInactive = () => {
  $(`.heart-active`).addClass(`hidden`)
  $(`.heart-inactive`).removeClass(`hidden`)
}