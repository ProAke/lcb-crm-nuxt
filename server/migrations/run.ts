// Migration runner utility
// Usage: npx tsx server/migrations/run.ts

import { getDatabasePool } from '../utils/database'
import * as fs from 'fs'
import * as path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const MIGRATIONS_DIR = __dirname

interface Migration {
  filename: string
  sql: string
}

async function getMigrations(): Promise<Migration[]> {
  const files = fs.readdirSync(MIGRATIONS_DIR)
    .filter(f => f.endsWith('.sql'))
    .sort()
  
  return files.map(filename => ({
    filename,
    sql: fs.readFileSync(path.join(MIGRATIONS_DIR, filename), 'utf-8')
  }))
}

async function runMigrations(): Promise<void> {
  console.log('🔄 Starting database migrations...')
  
  const migrations = await getMigrations()
  console.log(`📁 Found ${migrations.length} migration file(s)`)
  
  const pool = getDatabasePool()
  
  // Create migrations tracking table
  await pool.execute(`
    CREATE TABLE IF NOT EXISTS \`migrations\` (
      \`id\` INT AUTO_INCREMENT PRIMARY KEY,
      \`filename\` VARCHAR(255) NOT NULL UNIQUE,
      \`executed_at\` DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  `)
  
  // Get already executed migrations
  const [executed] = await pool.execute('SELECT \`filename\` FROM \`migrations\`')
  const executedSet = new Set((executed as any[]).map(r => r.filename))
  
  let successCount = 0
  
  for (const migration of migrations) {
    if (executedSet.has(migration.filename)) {
      console.log(`⏭️  Skipping ${migration.filename} (already executed)`)
      continue
    }
    
    console.log(`▶️  Running ${migration.filename}...`)
    
    try {
      // Split SQL by semicolon and execute each statement
      const statements = migration.sql
        .split(';')
        .map(s => s.trim())
        .filter(s => s.length > 0 && !s.startsWith('--'))
      
      for (const stmt of statements) {
        if (stmt.trim()) {
          await pool.execute(stmt)
        }
      }
      
      // Record migration as executed
      await pool.execute('INSERT INTO \`migrations\` (\`filename\`) VALUES (?)', [migration.filename])
      
      console.log(`✅ ${migration.filename} completed`)
      successCount++
    } catch (error: any) {
      console.error(`❌ ${migration.filename} failed:`, error.message)
      throw error
    }
  }
  
  console.log(`\n🎉 Migrations complete! ${successCount} new migration(s) applied.`)
  
  await pool.end()
  process.exit(0)
}

runMigrations().catch(err => {
  console.error('Migration failed:', err)
  process.exit(1)
})