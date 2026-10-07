<script setup lang="ts">
withDefaults(defineProps<{ open?: boolean }>(), { open: false })
const emit = defineEmits<{ close: []; navigate: [] }>()

const groups = [
  {
    label: 'WORKSPACE',
    links: [
      { to: '/', label: 'ภาพรวม', icon: 'grid', exact: true },
      { to: '/members', label: 'สมาชิก / ลูกค้า', icon: 'users', badge: '5.2k' },
      { to: '/bookings', label: 'จองคิวบริการ', icon: 'calendar' }
    ]
  },
  {
    label: 'จัดการธุรกิจ',
    links: [
      { to: '/products', label: 'สินค้าและบริการ', icon: 'box' },
      { to: '/promotions', label: 'โปรโมชั่น', icon: 'tag' }
    ]
  },
  {
    label: 'LINE OFFICIAL ACCOUNT',
    links: [
      { to: '/line/rich-menu', label: 'Rich Menu', icon: 'layout', badge: '3' },
      { to: '/line/messages', label: 'Broadcast', icon: 'send' },
      { to: '/register', label: 'แบบฟอร์มสมาชิก', icon: 'document' }
    ]
  },
  {
    label: 'ข้อมูลตั้งต้น',
    links: [
      { to: '/setup', label: 'แบรนด์ / หมวดหมู่ / คู่มือ', icon: 'sliders' }
    ]
  }
]
</script>

<template>
  <aside class="sidebar" :class="{ 'sidebar-open': open }">
    <div class="sidebar-brand">
      <div class="brand-emblem"><span class="brand-swoosh" /><span class="brand-dot" /></div>
      <div class="brand-copy">
        <strong>COCKPIT</strong>
        <small>LAEM CHABANG CRM</small>
      </div>
      <button class="sidebar-close" aria-label="ปิดเมนู" @click="emit('close')"><AppIcon name="close" /></button>
    </div>

    <div class="branch-switcher">
      <div class="branch-avatar">LC</div>
      <div class="branch-copy"><strong>แหลมฉบัง อินเตอร์ฯ</strong><small>สาขาหลัก · ชลบุรี</small></div>
      <AppIcon name="chevronDown" :size="15" />
    </div>

    <nav class="sidebar-nav">
      <section v-for="group in groups" :key="group.label" class="nav-group">
        <p class="nav-group-label">{{ group.label }}</p>
        <NuxtLink
          v-for="link in group.links"
          :key="link.to"
          :to="link.to"
          class="nav-link"
          :exact-active-class="link.exact ? 'nav-link-active' : ''"
          active-class="nav-link-active"
          @click="emit('navigate')"
        >
          <AppIcon :name="link.icon" :size="18" />
          <span>{{ link.label }}</span>
          <span v-if="link.badge" class="nav-badge">{{ link.badge }}</span>
        </NuxtLink>
      </section>
    </nav>

    <div class="sidebar-bottom">
      <NuxtLink to="/settings" class="nav-link settings-link" active-class="nav-link-active" @click="emit('navigate')">
        <AppIcon name="settings" :size="18" /><span>ตั้งค่าระบบ</span>
      </NuxtLink>
      <div class="line-status-card">
        <div class="line-status-top"><span class="status-dot status-dot-warn" /> LINE OA <span class="status-not-connected">ยังไม่เชื่อม</span></div>
        <p>ตั้งค่า LINE API เพื่อเผยแพร่ Rich Menu และส่งข้อความ</p>
        <NuxtLink to="/settings" @click="emit('navigate')">ตั้งค่าการเชื่อมต่อ <AppIcon name="arrowRight" :size="13" /></NuxtLink>
      </div>
      <div class="sidebar-user">
        <div class="user-avatar">AD</div>
        <div class="user-info"><strong>ผู้ดูแลระบบ</strong><small>Administrator</small></div>
        <button class="user-more" aria-label="เพิ่มเติม"><AppIcon name="more" :size="18" /></button>
      </div>
    </div>
  </aside>
</template>
