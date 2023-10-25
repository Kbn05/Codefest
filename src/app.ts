import express, {Application} from 'express'
import {engine} from 'express-handlebars'
import sessionP from 'express-session'
import bodyParser from 'body-parser'
import morgan from 'morgan'
import pRouter from './routes/pRouter'
import pView from './view/pView'

interface User {
    email: string
}
declare module "express-session" {
    interface SessionData {
        user: User
    }
}

class Server {
    app: Application;

    constructor (private readonly router: pRouter) {
        this.app = express()
        this.sec()
        this.config()
        this.route()
    }
  
    config = (): void => {
        this.app.set('view engine', 'hbs')
        this.app.set('views', __dirname + '/templates')
        this.app.engine('hbs', engine({ extname: 'hbs', defaultLayout: 'main.hbs' }));
        this.app.use(express.static(__dirname + '/public'))
        this.app.use(bodyParser.urlencoded({ extended: true }))
        this.app.use(bodyParser.json())
        this.app.use(morgan('tiny'))
    }
  
    route = (): void => {
        this.app.use('/', this.router.router)
    }

    sec = (): void => {
        this.app.use(sessionP({
            secret: 'secretkeyxddd',
            resave: false,
            saveUninitialized: false
    }))}  
  
    start = (): void => {
        this.app.set('port', 3000);
        this.app.listen(this.app.get('port'), () => {
            console.log('Server on port', this.app.get('port'));
        }); 
  }
}
  
  const server = new Server(new pRouter(new pView()))
  server.start()
