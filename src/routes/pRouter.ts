import { Router } from 'express'
import pView from '../view/pView'

export default class ProductsRouter {
  router: Router

  constructor (private readonly pView: pView) {
    this.router = Router()
    this.routes()
  }

  routes = (): void => {
    this.router.get('/session/session-home', this.pView.sessionUser)
    this.router.get('/logout', this.pView.sessionLogout)
    this.router.post('/login', this.pView.authUser)
    this.router.post('/register', this.pView.submitUser)
    this.router.get('/register', this.pView.register)
    this.router.get('/login', this.pView.login)
    this.router.get('/', this.pView.index)
  }
}