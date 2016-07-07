express = require('express')
router = express.Router()

# GET home page.
router.get('/', (req, res, next) ->
  res.render('index', { title: 'Build Direct Project Service' })
)

module.exports = router
