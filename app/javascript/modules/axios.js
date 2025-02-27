import 'axios'
const csrfToken = document.getElementsByName('csrf-token')[0].content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

export default axios