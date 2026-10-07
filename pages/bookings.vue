<script setup lang="ts">
const { notify } = useAppToast()
const selectedDay = ref('6 ต.ค.')
const activeFilter = ref('ทั้งหมด')
const showCreate = ref(false)
const query = ref('')
const bookName = ref('')
const bookService = ref('เปลี่ยนยาง')
const bookTime = ref('15:30')
const days = [
  { day: 'จ.', date: '5 ต.ค.', count: 8 }, { day: 'อ.', date: '6 ต.ค.', count: 12 }, { day: 'พ.', date: '7 ต.ค.', count: 7 }, { day: 'พฤ.', date: '8 ต.ค.', count: 10 }, { day: 'ศ.', date: '9 ต.ค.', count: 6 }, { day: 'ส.', date: '10 ต.ค.', count: 14 }, { day: 'อา.', date: '11 ต.ค.', count: 3 }
]
const bookings = ref([
  { id: 'BK-6932', name: 'ลูกค้าตัวอย่าง 01', vehicle: 'Toyota Yaris · กท •• 7421', service: 'เปลี่ยนยาง', time: '09:30', staff: 'ช่างทีม A', status: 'ยืนยันแล้ว' },
  { id: 'BK-6933', name: 'ลูกค้าตัวอย่าง 02', vehicle: 'Honda Civic · ชบ •• 5190', service: 'ตั้งศูนย์ล้อ', time: '10:45', staff: 'ช่างทีม B', status: 'รอยืนยัน' },
  { id: 'BK-6934', name: 'ลูกค้าตัวอย่าง 03', vehicle: 'Isuzu D-Max · กท •• 8842', service: 'เช็กระยะ', time: '13:00', staff: 'ช่างทีม A', status: 'กำลังให้บริการ' },
  { id: 'BK-6935', name: 'ลูกค้าตัวอย่าง 04', vehicle: 'Mazda 2 · ชบ •• 0237', service: 'เปลี่ยนน้ำมันเครื่อง', time: '14:30', staff: 'ช่างทีม C', status: 'ยืนยันแล้ว' },
  { id: 'BK-6936', name: 'ลูกค้าตัวอย่าง 05', vehicle: 'Toyota Fortuner · ชบ •• 1678', service: 'ตรวจเช็กช่วงล่าง', time: '16:00', staff: 'ช่างทีม B', status: 'รอยืนยัน' }
])
const visibleBookings = computed(() => bookings.value.filter(b => {
  const q = query.value.toLowerCase()
  return (!q || `${b.id} ${b.name} ${b.vehicle} ${b.service}`.toLowerCase().includes(q)) && (activeFilter.value === 'ทั้งหมด' || b.status === activeFilter.value)
}))
function addBooking() {
  if (!bookName.value.trim()) return notify('กรุณาระบุชื่อลูกค้า')
  bookings.value.push({ id: `BK-${6937 + bookings.value.length}`, name: bookName.value, vehicle: 'ยังไม่ระบุ', service: bookService.value, time: bookTime.value, staff: 'รอมอบหมาย', status: 'รอยืนยัน' })
  showCreate.value = false; notify('เพิ่มคิวตัวอย่างแล้ว')
  bookName.value = ''
}
function setStatus(booking: any) {
  booking.status = booking.status === 'รอยืนยัน' ? 'ยืนยันแล้ว' : booking.status === 'ยืนยันแล้ว' ? 'กำลังให้บริการ' : 'เสร็จสิ้น'
  notify(`เปลี่ยนสถานะ ${booking.id} เป็น ${booking.status}`)
}
</script>

<template>
  <div class="page-heading">
    <div><div class="eyebrow">SERVICE SCHEDULING</div><h1>จองคิวบริการ</h1><p>ดูตารางนัดหมายและติดตามสถานะงานบริการของสาขา</p></div>
    <div class="heading-actions"><button class="btn btn-light" @click="notify('ดาวน์โหลดรายงานคิวในระบบจริง')"><AppIcon name="download" :size="15" />รายงานคิว</button><button class="btn btn-primary" @click="showCreate = true"><AppIcon name="plus" :size="16" />สร้างการจอง</button></div>
  </div>

  <div class="booking-summary">
    <div class="booking-summary-main"><span class="summary-icon"><AppIcon name="calendar" :size="20" /></span><div><small>วันนี้ · วันอังคารที่ 6 ตุลาคม 2569</small><strong>12 <span>คิวทั้งหมด</span></strong></div></div>
    <div class="summary-breakdown"><span><i class="dot dot-green" />ยืนยันแล้ว <b>7</b></span><span><i class="dot dot-amber" />รอยืนยัน <b>3</b></span><span><i class="dot dot-blue" />กำลังบริการ <b>2</b></span></div>
    <button class="btn btn-light btn-sm" @click="notify('ปฏิทินจะแสดงข้อมูลจากระบบจริง')"><AppIcon name="calendar" :size="14" />ปฏิทินเต็ม</button>
  </div>

  <section class="panel week-panel">
    <div class="week-header"><div><h2 class="panel-title">ตารางคิวประจำสัปดาห์</h2><p class="panel-subtitle">5 – 11 ตุลาคม 2569</p></div><div class="week-arrows"><button @click="notify('เปลี่ยนสัปดาห์ในระบบจริง')">‹</button><button @click="notify('เปลี่ยนสัปดาห์ในระบบจริง')">›</button></div></div>
    <div class="week-strip"><button v-for="d in days" :key="d.date" class="day-card" :class="{ selected: selectedDay === d.date }" @click="selectedDay = d.date"><span>{{ d.day }}</span><strong>{{ d.date.split(' ')[0] }}</strong><small>{{ d.date.split(' ')[1] }}</small><i>{{ d.count }} คิว</i></button></div>
  </section>

  <section class="panel queue-panel">
    <div class="panel-head"><div><h2 class="panel-title">รายการจอง · {{ selectedDay }} 2569</h2><p class="panel-subtitle">คิวบริการตัวอย่างของสาขา</p></div><button class="panel-action" @click="notify('ตัวกรองเพิ่มเติมในระบบจริง')"><AppIcon name="filter" :size="14" />ตัวกรอง</button></div>
    <div class="queue-toolbar"><label class="search-field"><AppIcon name="search" :size="16" /><input v-model="query" placeholder="ค้นหาคิว, ลูกค้า, ทะเบียนรถ..." /></label><div class="filter-tabs"><button v-for="f in ['ทั้งหมด','รอยืนยัน','ยืนยันแล้ว','กำลังให้บริการ']" :key="f" :class="{ active: activeFilter === f }" @click="activeFilter = f">{{ f }}</button></div></div>
    <div class="table-wrap"><table class="data-table"><thead><tr><th>เวลา</th><th>ลูกค้า / รถ</th><th>บริการ</th><th>ช่างผู้ดูแล</th><th>สถานะ</th><th></th></tr></thead>
      <tbody><tr v-for="b in visibleBookings" :key="b.id"><td><div class="time-cell"><strong>{{ b.time }}</strong><small>{{ b.id }}</small></div></td><td><div class="person-cell"><span class="person-avatar">{{ b.id.slice(-2) }}</span><div><div class="table-primary">{{ b.name }}</div><div class="table-secondary">{{ b.vehicle }}</div></div></div></td><td>{{ b.service }}</td><td>{{ b.staff }}</td><td><span class="badge" :class="b.status === 'ยืนยันแล้ว' ? 'badge-green' : b.status === 'รอยืนยัน' ? 'badge-amber' : b.status === 'เสร็จสิ้น' ? 'badge-gray' : 'badge-blue'">{{ b.status }}</span></td><td><button class="btn btn-light btn-sm" @click="setStatus(b)">{{ b.status === 'รอยืนยัน' ? 'ยืนยันคิว' : 'อัปเดต' }}</button></td></tr>
      <tr v-if="!visibleBookings.length"><td colspan="6"><div class="empty-state"><AppIcon name="calendar" :size="23"/><strong>ไม่มีคิวในตัวกรองนี้</strong><p>ลองเลือกสถานะอื่น</p></div></td></tr></tbody>
    </table></div>
  </section>

  <div v-if="showCreate" class="modal-backdrop" @click.self="showCreate = false"><div class="modal-card"><div class="modal-head"><div><h3>สร้างการจอง</h3><p>บันทึกนัดหมายบริการในระบบตัวอย่าง</p></div><button class="modal-close" @click="showCreate = false"><AppIcon name="close" :size="16" /></button></div>
    <div class="modal-content"><div class="field"><label class="form-label">ชื่อลูกค้า <span class="required">*</span></label><input v-model="bookName" class="form-control" placeholder="ชื่อลูกค้า" /></div><div class="field"><label class="form-label">บริการ</label><select v-model="bookService" class="form-control"><option>เปลี่ยนยาง</option><option>ตั้งศูนย์ล้อ</option><option>เปลี่ยนน้ำมันเครื่อง</option><option>ตรวจเช็กช่วงล่าง</option></select></div><div class="field"><label class="form-label">เวลานัด</label><input v-model="bookTime" class="form-control" type="time" /></div></div>
    <div class="modal-footer"><button class="btn btn-light" @click="showCreate = false">ยกเลิก</button><button class="btn btn-primary" @click="addBooking">บันทึกการจอง</button></div></div></div>
</template>

<style scoped>
.booking-summary{padding:15px 17px;border:1px solid #eee0e1;background:linear-gradient(115deg,#fff 0%,#fff8f8 100%);border-radius:14px;display:flex;align-items:center;gap:20px;margin-bottom:14px}.booking-summary-main{display:flex;align-items:center;gap:11px;flex:1}.summary-icon{width:39px;height:39px;border-radius:11px;display:grid;place-items:center;background:#fff0f1;color:var(--red)}.booking-summary-main small,.booking-summary-main strong{display:block}.booking-summary-main small{font-size:9px;color:#959aa1;margin-bottom:4px}.booking-summary-main strong{font-size:21px}.booking-summary-main strong span{font-size:10px;color:#737981;font-weight:600}.summary-breakdown{display:flex;gap:16px}.summary-breakdown span{font-size:9px;color:#7b8087;display:flex;align-items:center;gap:5px}.summary-breakdown b{color:#41464c}.dot{width:6px;height:6px;border-radius:50%}.dot-green{background:#1aa476}.dot-amber{background:#e4a33b}.dot-blue{background:#4e89da}.week-panel{margin-bottom:14px}.week-header{display:flex;justify-content:space-between;align-items:center;padding:16px 18px 12px}.week-arrows{display:flex;gap:5px}.week-arrows button{height:27px;width:28px;border:1px solid #e8eaed;background:white;border-radius:7px;color:#777;font-size:17px}.week-strip{display:grid;grid-template-columns:repeat(7,1fr);gap:7px;padding:0 17px 15px}.day-card{min-height:82px;border:1px solid #edf0f2;border-radius:10px;background:#fff;display:flex;flex-direction:column;align-items:center;justify-content:center;position:relative;color:#626870;gap:1px}.day-card span{font-size:8px;color:#9ca1a8}.day-card strong{font-size:17px;color:#373b40}.day-card small{font-size:8px;color:#9ca1a8}.day-card i{font-style:normal;font-size:8px;color:#9b9fa5;margin-top:4px}.day-card.selected{border-color:#ee6d75;background:#fff6f6;box-shadow:0 0 0 2px rgba(227,6,19,.06)}.day-card.selected strong{color:var(--red)}.day-card.selected i{color:var(--red);font-weight:800}.queue-panel{overflow:hidden}.queue-toolbar{padding:0 18px 13px;display:flex;justify-content:space-between;align-items:center;gap:10px}.queue-toolbar .search-field{width:260px}.time-cell strong,.time-cell small{display:block}.time-cell strong{font-size:11px;color:#34383d}.time-cell small{font-size:8px;color:#a0a5ab;margin-top:3px}.required{color:var(--red)}
@media(max-width:760px){.booking-summary{flex-wrap:wrap;gap:10px}.booking-summary-main{min-width:100%}.summary-breakdown{flex:1;justify-content:space-between}.week-strip{grid-template-columns:repeat(7,minmax(42px,1fr));overflow-x:auto}.day-card{min-width:48px}.queue-toolbar{align-items:flex-start;flex-direction:column}.queue-toolbar .search-field{width:100%}.filter-tabs{max-width:100%;overflow:auto}}
</style>
