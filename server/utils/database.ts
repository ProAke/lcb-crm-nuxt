// Database connection utility for Nuxt 3 server routes
// Uses mysql2 with remote database (same as PHPWeb)

import mysql from 'mysql2/promise'

let pool: mysql.Pool | null = null

export function getDatabasePool(): mysql.Pool {
  if (!pool) {
    const config = {
      host: process.env.NUXT_DATABASE_HOST || '203.146.252.149',
      port: parseInt(process.env.NUXT_DATABASE_PORT || '3306'),
      user: process.env.NUXT_DATABASE_USER || 'pacific_lcbweb',
      password: process.env.NUXT_DATABASE_PASSWORD || 'N!1D!tqS29qysppg',
      database: process.env.NUXT_DATABASE_NAME || 'pacific_lcbweb',
      charset: 'utf8mb4',
      timezone: '+07:00',
      ssl: process.env.NUXT_DATABASE_SSL === 'disabled' ? {} : undefined,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      enableKeepAlive: true,
      keepAliveInitialDelay: 0,
    }

    pool = mysql.createPool(config)
  }
  return pool
}

export async function query<T = any>(sql: string, params: any[] = []): Promise<T[]> {
  const pool = getDatabasePool()
  const [rows] = await pool.execute(sql, params)
  return rows as T[]
}

export async function queryOne<T = any>(sql: string, params: any[] = []): Promise<T | null> {
  const rows = await query<T>(sql, params)
  return rows[0] || null
}

export async function execute(sql: string, params: any[] = []): Promise<mysql.ResultSetHeader> {
  const pool = getDatabasePool()
  const [result] = await pool.execute(sql, params)
  return result as mysql.ResultSetHeader
}

export async function transaction<T>(callback: (conn: mysql.PoolConnection) => Promise<T>): Promise<T> {
  const pool = getDatabasePool()
  const conn = await pool.getConnection()
  try {
    await conn.beginTransaction()
    const result = await callback(conn)
    await conn.commit()
    return result
  } catch (error) {
    await conn.rollback()
    throw error
  } finally {
    conn.release()
  }
}

// Test connection
export async function testConnection(): Promise<boolean> {
  try {
    const pool = getDatabasePool()
    const conn = await pool.getConnection()
    await conn.ping()
    conn.release()
    return true
  } catch (error) {
    console.error('Database connection failed:', error)
    return false
  }
}

// Close pool (for graceful shutdown)
export async function closePool(): Promise<void> {
  if (pool) {
    await pool.end()
    pool = null
  }
}

// Table name helpers (matching PHPWeb)
export const TABLES = {
  admin: 'tb_admin_user',
  adminMenu: 'tb_admin_menu',
  member: 'tb_member',
  memberLogin: 'tb_members_login',
  memberAddress: 'tb_member_address',
  promotion: 'tb_promotion',
  product: 'tb_products',
  category: 'tb_category',
  brand: 'tb_brand',
  booking: 'tb_booking',
  bookingLog: 'tb_booking_log',
  manual: 'tb_manual',
  richmenu: 'tb_richmenu',
  richmessage: 'tb_richmessage',
  lineLog: 'tb_linelog',
  orders: 'tb_orders',
  task: 'tb_task',
  social: 'tb_social',
  hotlink: 'tb_hotlink',
  dailyExpress: 'tb_DailyExpress',
  trackLog: 'tb_track_log',
  contents: 'tb_contents_detail',
  customers: 'tb_customers',
  agents: 'tb_agents',
  province: 'tb_province',
  amphur: 'tb_amphur',
  district: 'tb_district',
  page: 'tb_page',
  pageDetail: 'tb_page_detail',
  setting: 'tb_setting',
  botAction: 'tb_bot_action',
  qt: 'tb_QT',
  helpSupport: 'tp_help_support',
} as const