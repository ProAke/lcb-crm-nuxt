<script setup lang="ts">
defineProps<{ title: string }>()
const emit = defineEmits<{ toggleMenu: [] }>()
const search = ref('')
</script>

<template>
  <header class="topbar">
    <div class="topbar-left">
      <button class="mobile-menu-button" aria-label="เปิดเมนู" @click="emit('toggleMenu')"><AppIcon name="menu" /></button>
      <div class="topbar-breadcrumb"><span>CRM</span><AppIcon name="chevronRight" :size="14" /><strong>{{ title }}</strong></div>
    </div>
    <div class="topbar-actions">
      <label class="global-search"><AppIcon name="search" :size="17" /><input v-model="search" type="search" placeholder="ค้นหาสมาชิก, คิว, โปรโมชั่น..." aria-label="ค้นหา" /><kbd>⌘ K</kbd></label>
      <div class="topbar-date"><span class="date-dot" />อังคาร 6 ต.ค. 2569</div>
      <button class="icon-button notification-button" aria-label="การแจ้งเตือน"><AppIcon name="bell" :size="19" /><i /></button>
      <div class="topbar-avatar">AD</div>
    </div>
  </header>
</template>
