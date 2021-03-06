express = require('express')
path = require('path')
cors = require('cors')

favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
routes = require('./routes/index')
config = require('./config/configuration')

app = express()

# view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')

# uncomment after placing your favicon in /public
#app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')))
app.use(logger('dev'))
app.use(cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(require('stylus').middleware(path.join(__dirname, 'public')))
app.use(express.static(path.join(__dirname, 'public')))

app.use('/', routes)
config = require('./config/configuration')

mongoose = require('mongoose')
mongoose.Promise = require('bluebird')
mongoose.connect(config.db) # connect to our database
Placeable= require('./models/placeable')
Placeables = require('./controllers/placeables')(app, Placeable.model)
Room= require('./models/room')
Rooms = require('./controllers/rooms')(app, Room.model)
Layout= require('./models/layout')
Layouts = require('./controllers/layouts')(app, Layout.model)
Project= require('./models/project')
Projects = require('./controllers/projects')(app, Project.model)

ProjectsRooms = require('./controllers/projects_rooms')(app, Room.model, Placeable, Layout)
RoomsLayouts = require('./controllers/rooms_layouts')(app, Layout.model)
RoomsPlaceables = require('./controllers/rooms_placeables')(app, Placeable.model)
#ProjectsRoomsLayouts = require('./controllers/projects_rooms_layouts')(app, Placeable.model, Layout)

Resources = {
  Projects: Projects
  Rooms: Rooms
  Layouts: Layouts
  Placeables: Placeables
  ProjectsRooms: ProjectsRooms
  RoomsLayouts: RoomsLayouts
  RoomsPlaceables: RoomsPlaceables
#  ProjectsRoomsLayouts: ProjectsRoomsLayouts
}

swagger = require('./controllers/swagger')(app, Resources, '/api', config)

timeout = require('connect-timeout')

app.use(timeout(config.timeout))
haltOnTimedout = (req, res, next) ->
  if (!req.timedout)
    next()
app.use(haltOnTimedout)

# catch 404 and forward to error handler
#app.use((req, res, next) ->
#  err = new Error('Not Found')
#  err.status = 404
#  next(err)
#)
# error handlers
# development error handler
# will print stacktrace
if (app.get('env') == 'development' or app.get('env') == 'local')
# development error handleripho
# will print stacktrace
  app.use((err, req, res, next) ->
    if (err?)
      res.status(err.status || 500)
      res.render('error', {
        message: err.message,
        error: err
      })

  )
else
# production error handler
# no stacktraces leaked to user
  app.use((err, req, res, next) ->
    if (err?)
      res.status(err.status || 500)
      res.render('error', {
        message: err.message,
        error: {}
      })
  )

# production error handler
# no stacktraces leaked to user
#app.use((err, req, res, next) ->
#  res.status(err.status || 500)
#  res.render('error', {
#    message: err.message,
#    error: {}
#  })
#)

module.exports = app