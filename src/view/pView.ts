import { Request, Response } from 'express'
import bcrypt from 'bcryptjs'
import { connect } from '../database/connection'
import {RowDataPacket} from 'mysql2'

export default class ProductsView {

  index = (_: Request, res: Response): void => {
    res.render('home')
  }

  login = (_: Request, res: Response): void => {
    res.render('login/login')
  }

  register = (_: Request, res: Response): void => {
    res.render('login/register')
  }

submitUser = async (req: Request, res: Response): Promise<void> => {
    const { fullname, email, passwd } = req.body
    const salt = bcrypt.genSaltSync(10)
    const hash = bcrypt.hashSync(passwd, salt)
    const newUser = {
        fullname,
        email,
        password: hash
    }
    const connection = await connect()
    try {
        const [rows] = await connection.query<RowDataPacket[]>('SELECT * FROM users WHERE email = ?', [email])
        if (rows.length !== 0) {
            console.log(rows)
            console.log('Email already exists')
            res.redirect('/login')
        } else {
            await connection.query('INSERT INTO users SET ?', [newUser])
            console.log('User registered')
            res.redirect('/login')
        }
    } catch (err) {
        console.log(err)
    }}

    authUser = async (req: Request, res: Response): Promise<void> => {
        const { email, passwd } = req.body
        const connection = await connect()
        try {
            const [rows] = await connection.query<RowDataPacket[]>('SELECT * FROM users WHERE email = ?', [email])
            console.log(rows)
            if (rows.length !== 0) {
                console.log(rows)
                console.log('1')
                for (const row of rows) {
                    if (typeof row.password !== "undefined") {
                        console.log('2')
                        const validPasswd = await bcrypt.compare(passwd, row.password)
                        if (validPasswd) {
                            console.log('3')
                            console.log(row.email)
                            req.session.user = row.u_id
                            console.log(req.session.user)
                            res.redirect('/session/session-home')
                            return
                        }
                    }
                }
                console.log('4')
                res.redirect('/login')}
                } catch (err) {
            console.log(err)
        }
    }

    sessionUser = async (req: Request, res: Response): Promise<void> => {
        if (!req.session.user) {
            res.redirect('/login');
        } else {
            const connection = await connect()
            try {
            const user = req.session.user
        
            // Consulta para obtener datos relacionados al usuario
            const [friendData] = await connection.query<RowDataPacket[]>('SELECT * FROM friends WHERE f_user_1 = ? OR f_user_2 = ?', [user, user]);
            const [friendRequestData] = await connection.query<RowDataPacket[]>('SELECT * FROM friend_request WHERE f_sender = ? OR f_receiver = ?', [user, user]);
            const [postData] = await connection.query<RowDataPacket[]>('SELECT * FROM posts WHERE author = ?', [user]);

            console.log(friendData);
            console.log(friendRequestData);
            console.log(postData);
        
            res.render('session/session-home', {
                user,
                friends: friendData,
                friendRequests: friendRequestData,
                posts: postData,
            });
            } catch (err) {
            console.error(err);
            res.redirect('/login');
            }
        }
    }

    sessionLogout = async (req: Request, res: Response): Promise<void> => {
        req.session.destroy((err) => {
            if(err) {
                console.log(err);
            } else {
                res.redirect('/login');
            }
        });
    }
}