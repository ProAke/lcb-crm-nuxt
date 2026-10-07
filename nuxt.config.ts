export default defineNuxtConfig({
  compatibilityDate: '2026-10-06',
  devtools: { enabled: false },
  experimental: { appManifest: false },
  css: ['~/assets/css/main.css'],
  app: {
    head: {
      title: 'Laem Chabang CRM | Cockpit',
      meta: [
        { name: 'theme-color', content: '#e30613' },
        { name: 'description', content: 'Laem Chabang Inter Auto Tire CRM prototype' }
      ]
    }
  },
  runtimeConfig: {
    databaseUrl: '',
    lineChannelAccessToken: '',
    lineChannelSecret: ''
  },
  devServer: {
    host: '0.0.0.0',
    port: 3000
  }
})
