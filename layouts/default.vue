<script setup lang="ts">
import { computed, ref } from 'vue'

const route = useRoute()
const mobileOpen = ref(false)
const { toast } = useAppToast()
const titles: Record<string, string> = {
  '/': 'ภาพรวม',
  '/members': 'สมาชิกและลูกค้า',
  '/bookings': 'จองคิวบริการ',
  '/products': 'สินค้าและบริการ',
  '/promotions': 'โปรโมชั่น',
  '/line/rich-menu': 'LINE Rich Menu',
  '/line/messages': 'LINE Broadcast',
  '/settings': 'ตั้งค่าระบบ',
  '/setup': 'ข้อมูลตั้งต้น',
  '/register': 'แบบฟอร์มสมัครสมาชิก'
}
const pageTitle = computed(() => titles[route.path] || 'Laem Chabang CRM')
</script>

<template>
  <div class="app-shell">
    <AppSidebar :open="mobileOpen" @close="mobileOpen = false" @navigate="mobileOpen = false" />
    <div v-if="mobileOpen" class="mobile-scrim" @click="mobileOpen = false" />
    <div class="app-main">
      <AppTopbar :title="pageTitle" @toggle-menu="mobileOpen = !mobileOpen" />
      <main class="main-content">
        <slot />
      </main>
      <footer class="app-footer">
        <span>© 2026 Laem Chabang Inter Auto Tire</span>
        <span class="footer-separator">•</span>
        <span>CRM 2026–2027 <span class="prototype-label">Prototype</span></span>
      </footer>
    </div>
    <Transition name="toast">
      <div v-if="toast" class="toast-message"><span class="toast-check"><AppIcon name="check" :size="15" /></span>{{ toast }}</div>
    </Transition>
  </div>
</template>
