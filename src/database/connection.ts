import {createPool} from 'mysql2/promise'

export async function connect() {
    const connection = await createPool({
        host: 'localhost',
        user: 'root',
        password: 'Zot10175',
        database: 'p_login'
    })
    return connection
}