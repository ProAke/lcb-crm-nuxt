<script setup lang="ts">
const { notify } = useAppToast()
const range = ref('30 วัน')

const stats = [
  { label: 'สมาชิกทั้งหมด', value: '5,248', change: '+12.8%', note: 'เทียบกับเดือนก่อน', icon: 'users', tone: '' },
  { label: 'จองคิวเดือนนี้', value: '186', change: '+8.5%', note: 'เทียบกับเดือนก่อน', icon: 'calendar', tone: 'blue' },
  { label: 'โปรโมชั่นที่ใช้งาน', value: '04', change: 'กำลังรัน', note: 'จากทั้งหมด 12 แคมเปญ', icon: 'tag', tone: 'amber' },
  { label: 'ผู้ติดตาม LINE', value: '3,892', change: '+6.2%', note: 'เทียบกับเดือนก่อน', icon: 'message', tone: 'green' }
]
const bookings = [
  { initials: '01', name: 'ลูกค้าตัวอย่าง 01', vehicle: 'Toyota Yaris · กท •• 7421', service: 'เปลี่ยนยาง', time: '09:30', status: 'ยืนยันแล้ว', badge: 'badge-green' },
  { initials: '02', name: 'ลูกค้าตัวอย่าง 02', vehicle: 'Honda Civic · ชบ •• 5190', service: 'ตั้งศูนย์ล้อ', time: '10:45', status: 'รอยืนยัน', badge: 'badge-amber' },
  { initials: '03', name: 'ลูกค้าตัวอย่าง 03', vehicle: 'Isuzu D-Max · กท •• 8842', service: 'เช็กระยะ', time: '13:00', status: 'ยืนยันแล้ว', badge: 'badge-green' },
  { initials: '04', name: 'ลูกค้าตัวอย่าง 04', vehicle: 'Mazda 2 · ชบ •• 0237', service: 'เปลี่ยนน้ำมันเครื่อง', time: '14:30', status: 'รอยืนยัน', badge: 'badge-amber' }
]
const actions = [
  { icon: 'calendar', title: 'สร้างรายการจองคิว', subtitle: 'นัดหมายบริการให้ลูกค้า', to: '/bookings' },
  { icon: 'tag', title: 'สร้างโปรโมชั่นใหม่', subtitle: 'เพิ่มแคมเปญและข้อเสนอ', to: '/promotions' },
  { icon: 'layout', title: 'แก้ไข LINE Rich Menu', subtitle: 'จัดการเมนูและลิงก์', to: '/line/rich-menu' },
  { icon: 'send', title: 'เขียนข้อความ Broadcast', subtitle: 'เตรียมข้อความสำหรับ LINE', to: '/line/messages' }
]
</script>

<template>
  <div class="page-heading">
    <div>
      <div class="eyebrow">TUESDAY · 6 OCTOBER 2026</div>
      <h1>สวัสดี, ผู้ดูแลระบบ <span class="wave">👋</span></h1>
      <p>สรุปภาพรวมการดำเนินงานของสาขาแหลมฉบังวันนี้</p>
    </div>
    <div class="heading-actions">
      <button class="btn btn-light" @click="notify('เตรียมดาวน์โหลดรายงานในระบบจริง')"><AppIcon name="download" :size="15" />ดาวน์โหลดรายงาน</button>
      <NuxtLink class="btn btn-primary" to="/line/messages"><AppIcon name="send" :size="15" />ส่งข้อความ LINE</NuxtLink>
    </div>
  </div>

  <section class="stats-grid">
    <article v-for="stat in stats" :key="stat.label" class="stat-card">
      <div class="stat-top"><span class="stat-label">{{ stat.label }}</span><span class="stat-icon" :class="stat.tone"><AppIcon :name="stat.icon" :size="17" /></span></div>
      <div class="stat-value">{{ stat.value }}</div>
      <div class="stat-foot"><span class="stat-change"><AppIcon name="arrowUp" :size="12" />{{ stat.change }}</span><span>{{ stat.note }}</span></div>
    </article>
  </section>

  <section class="dashboard-grid">
    <article class="panel chart-panel">
      <div class="panel-head">
        <div><h2 class="panel-title">ภาพรวมสมาชิกใหม่</h2><p class="panel-subtitle">จำนวนสมาชิกที่ลงทะเบียนในช่วงเวลาที่เลือก</p></div>
        <div class="chart-legend"><span class="legend-item"><i class="legend-dot" />ปี 2569</span><span class="legend-item"><i class="legend-dot muted" />ปี 2568</span></div>
        <select v-model="range" class="select-field" aria-label="ช่วงเวลา"><option>30 วัน</option><option>90 วัน</option><option>12 เดือน</option></select>
      </div>
      <div class="panel-body chart-body">
        <svg class="trend-chart" viewBox="0 0 720 230" preserveAspectRatio="none" role="img" aria-label="กราฟสมาชิกใหม่ตัวอย่าง">
          <defs><linearGradient id="chart-fill" x1="0" x2="0" y1="0" y2="1"><stop offset="0%" stop-color="#e30613" stop-opacity=".16"/><stop offset="100%" stop-color="#e30613" stop-opacity="0"/></linearGradient></defs>
          <line class="chart-grid" x1="42" y1="25" x2="710" y2="25"/><line class="chart-grid" x1="42" y1="70" x2="710" y2="70"/><line class="chart-grid" x1="42" y1="115" x2="710" y2="115"/><line class="chart-grid" x1="42" y1="160" x2="710" y2="160"/><line class="chart-grid" x1="42" y1="205" x2="710" y2="205"/>
          <text class="chart-axis" x="4" y="28">240</text><text class="chart-axis" x="4" y="73">180</text><text class="chart-axis" x="4" y="118">120</text><text class="chart-axis" x="11" y="163">60</text><text class="chart-axis" x="17" y="208">0</text>
          <path class="chart-area" d="M42 169 C74 164 75 140 112 148 S159 138 179 127 S221 143 246 115 S292 128 316 100 S355 106 382 88 S423 105 449 75 S490 81 517 66 S557 89 583 53 S630 70 652 42 S690 50 710 29 L710 205 L42 205Z"/>
          <path class="chart-line" d="M42 169 C74 164 75 140 112 148 S159 138 179 127 S221 143 246 115 S292 128 316 100 S355 106 382 88 S423 105 449 75 S490 81 517 66 S557 89 583 53 S630 70 652 42 S690 50 710 29"/>
          <circle class="chart-point" cx="112" cy="148" r="4"/><circle class="chart-point" cx="246" cy="115" r="4"/><circle class="chart-point" cx="382" cy="88" r="4"/><circle class="chart-point" cx="517" cy="66" r="4"/><circle class="chart-point" cx="652" cy="42" r="4"/>
          <text class="chart-axis" x="42" y="225">ก.ย. 1</text><text class="chart-axis" x="174" y="225">ก.ย. 8</text><text class="chart-axis" x="306" y="225">ก.ย. 15</text><text class="chart-axis" x="438" y="225">ก.ย. 22</text><text class="chart-axis" x="570" y="225">ก.ย. 29</text><text class="chart-axis" x="675" y="225">ต.ค. 6</text>
        </svg>
      </div>
    </article>

    <article class="panel quick-panel">
      <div class="panel-head"><div><h2 class="panel-title">ทางลัด</h2><p class="panel-subtitle">เริ่มงานที่ใช้บ่อยได้ทันที</p></div><span class="quick-spark"><AppIcon name="spark" :size="16" /></span></div>
      <div class="quick-action-list">
        <NuxtLink v-for="action in actions" :key="action.title" :to="action.to" class="quick-action">
          <span class="quick-action-icon"><AppIcon :name="action.icon" :size="16" /></span>
          <span class="quick-action-text"><strong>{{ action.title }}</strong><small>{{ action.subtitle }}</small></span>
          <AppIcon name="chevronRight" :size="15" />
        </NuxtLink>
      </div>
    </article>
  </section>

  <section class="bottom-grid">
    <article class="panel booking-panel">
      <div class="panel-head"><div><h2 class="panel-title">คิวบริการวันนี้</h2><p class="panel-subtitle">รายการนัดหมายล่าสุด · 6 ตุลาคม 2569</p></div><NuxtLink to="/bookings" class="panel-action">ดูคิวทั้งหมด <AppIcon name="arrowRight" :size="13" /></NuxtLink></div>
      <div class="table-wrap">
        <table class="data-table">
          <thead><tr><th>ลูกค้า / รถ</th><th>บริการ</th><th>เวลา</th><th>สถานะ</th></tr></thead>
          <tbody>
            <tr v-for="row in bookings" :key="row.initials">
              <td><div class="person-cell"><span class="person-avatar" :class="{ red: row.initials === '01' }">{{ row.initials }}</span><div><div class="table-primary">{{ row.name }}</div><div class="table-secondary">{{ row.vehicle }}</div></div></div></td>
              <td>{{ row.service }}</td><td>{{ row.time }}</td><td><span class="badge" :class="row.badge">{{ row.status }}</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </article>

    <article class="panel activity-panel">
      <div class="panel-head"><div><h2 class="panel-title">กิจกรรมล่าสุด</h2><p class="panel-subtitle">ความเคลื่อนไหวในระบบ</p></div><button class="tiny-action" aria-label="เพิ่มเติม"><AppIcon name="more" /></button></div>
      <div class="activity-list">
        <div class="activity-item"><span class="activity-icon activity-red"><AppIcon name="users" :size="14" /></span><div class="activity-copy"><strong>มีสมาชิกใหม่ลงทะเบียน</strong><span>แบบฟอร์ม LINE · สมาชิกตัวอย่าง</span></div><time>10 นาที</time></div>
        <div class="activity-item"><span class="activity-icon activity-green"><AppIcon name="calendar" :size="14" /></span><div class="activity-copy"><strong>ยืนยันการจองคิวแล้ว</strong><span>เปลี่ยนยาง · คิว 09:30 น.</span></div><time>32 นาที</time></div>
        <div class="activity-item"><span class="activity-icon activity-amber"><AppIcon name="tag" :size="14" /></span><div class="activity-copy"><strong>โปรโมชั่นใกล้หมดอายุ</strong><span>แคมเปญตัวอย่าง · อีก 3 วัน</span></div><time>1 ชม.</time></div>
        <div class="activity-item"><span class="activity-icon activity-blue"><AppIcon name="message" :size="14" /></span><div class="activity-copy"><strong>มีผู้ติดตาม LINE เพิ่ม</strong><span>สมาชิกใหม่ 12 ราย</span></div><time>2 ชม.</time></div>
      </div>
      <div class="activity-footer"><NuxtLink to="/line/messages">ไปที่ LINE Broadcast <AppIcon name="arrowRight" :size="13" /></NuxtLink></div>
    </article>
  </section>

  <div class="demo-banner"><AppIcon name="shield" :size="15" /><span>ข้อมูลบนหน้าจอนี้เป็นข้อมูลตัวอย่างสำหรับต้นแบบ ยังไม่ได้เชื่อมต่อฐานข้อมูลจริง</span><button @click="notify('ระบบจริงจะเชื่อมข้อมูลจาก MySQL ในขั้นตอนถัดไป')">ดูรายละเอียด</button></div>
</template>

<style scoped>
.wave{font-size:19px}.chart-panel{min-width:0}.chart-body{padding-top:4px}.quick-spark{width:29px;height:29px;border-radius:8px;display:grid;place-items:center;background:#fff0f1;color:var(--red)}.activity-list{padding:2px 17px 4px}.activity-item{display:flex;align-items:center;gap:9px;padding:10px 0;border-bottom:1px solid #f0f1f2}.activity-item:last-child{border-bottom:0}.activity-icon{width:28px;height:28px;border-radius:9px;display:grid;place-items:center;flex:none}.activity-red{background:#fff0f1;color:#df1a25}.activity-green{background:#e9f7f1;color:#13966b}.activity-amber{background:#fff6e3;color:#bd7915}.activity-blue{background:#eef4ff;color:#4b7fcc}.activity-copy{flex:1;min-width:0;display:flex;flex-direction:column;gap:3px}.activity-copy strong{font-size:9px;color:#44494f}.activity-copy span{font-size:8px;color:#9a9fa6;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.activity-item time{font-size:8px;color:#a5a9af;white-space:nowrap}.activity-footer{padding:9px 18px 14px;border-top:1px solid #f0f1f2}.activity-footer a{display:inline-flex;align-items:center;gap:6px;color:var(--red);font-size:9px;font-weight:700}.demo-banner{margin-top:15px;padding:10px 13px;border:1px solid #f0e4c9;background:#fffaf0;border-radius:9px;color:#98702a;display:flex;align-items:center;gap:8px;font-size:9px}.demo-banner span{flex:1}.demo-banner button{border:0;background:none;color:#986921;text-decoration:underline;font-weight:700;font-size:9px}
@media(max-width:650px){.demo-banner{align-items:flex-start;line-height:1.5}.demo-banner button{white-space:nowrap}.trend-chart{height:185px}.chart-panel .panel-head{flex-wrap:wrap}.chart-panel .panel-head>div:first-child{flex:1}.chart-panel .select-field{margin-left:auto}}
</style>
