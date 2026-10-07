// Test database connection endpoint
// GET /api/db/test

import { testConnection, query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    const connected = await testConnection()
    
    if (!connected) {
      return {
        success: false,
        message: 'Database connection failed',
        timestamp: new Date().toISOString()
      }
    }

    // Test query - get admin users count
    const adminCount = await query('SELECT COUNT(*) as count FROM `tb_admin_user`')
    const promotionCount = await query('SELECT COUNT(*) as count FROM `tb_promotion`')
    const memberCount = await query('SELECT COUNT(*) as count FROM `tb_member`')
    const productCount = await query('SELECT COUNT(*) as count FROM `tb_products`')

    return {
      success: true,
      message: 'Database connected successfully',
      database: 'pacific_lcbweb',
      host: '203.146.252.149',
      tables: {
        admin_users: adminCount[0]?.count || 0,
        promotions: promotionCount[0]?.count || 0,
        members: memberCount[0]?.count || 0,
        products: productCount[0]?.count || 0,
      },
      timestamp: new Date().toISOString()
    }
  } catch (error: any) {
    return {
      success: false,
      message: error.message,
      timestamp: new Date().toISOString()
    }
  }
})