<script setup lang="ts">
const { notify } = useAppToast()
const search = ref('')
const stateFilter = ref('ทั้งหมด')
const showCreate = ref(false)
const showDetail = ref(false)
const selected = ref<any>(null)
const memberName = ref('')
const memberPhone = ref('')
const members = ref([
  { id: 'LC-26941', name: 'สมาชิกตัวอย่าง 01', phone: '08x-xxx-0142', vehicle: 'Toyota Yaris', points: '1,250', joined: '06 ต.ค. 2569', state: 'ใช้งาน' },
  { id: 'LC-26940', name: 'สมาชิกตัวอย่าง 02', phone: '09x-xxx-2087', vehicle: 'Honda Civic', points: '860', joined: '05 ต.ค. 2569', state: 'ใช้งาน' },
  { id: 'LC-26939', name: 'สมาชิกตัวอย่าง 03', phone: '06x-xxx-6721', vehicle: 'Isuzu D-Max', points: '2,100', joined: '04 ต.ค. 2569', state: 'ใช้งาน' },
  { id: 'LC-26938', name: 'สมาชิกตัวอย่าง 04', phone: '08x-xxx-5194', vehicle: 'Mazda 2', points: '420', joined: '03 ต.ค. 2569', state: 'รอยืนยัน' },
  { id: 'LC-26937', name: 'สมาชิกตัวอย่าง 05', phone: '09x-xxx-5830', vehicle: 'Toyota Fortuner', points: '1,760', joined: '02 ต.ค. 2569', state: 'ใช้งาน' },
  { id: 'LC-26936', name: 'สมาชิกตัวอย่าง 06', phone: '06x-xxx-9032', vehicle: 'Nissan Almera', points: '0', joined: '01 ต.ค. 2569', state: 'พักใช้งาน' }
])
const filteredMembers = computed(() => members.value.filter(m => {
  const matchesSearch = `${m.name} ${m.id} ${m.phone} ${m.vehicle}`.toLowerCase().includes(search.value.toLowerCase())
  const matchesState = stateFilter.value === 'ทั้งหมด' || m.state === stateFilter.value
  return matchesSearch && matchesState
}))
function openDetail(member: any) { selected.value = member; showDetail.value = true }
function addMember() {
  if (!memberName.value.trim() || !memberPhone.value.trim()) return notify('กรุณากรอกชื่อและเบอร์โทรศัพท์')
  members.value.unshift({ id: `LC-26${String(members.value.length + 942).padStart(3, '0')}`, name: memberName.value, phone: memberPhone.value, vehicle: 'ยังไม่ระบุ', points: '0', joined: 'วันนี้', state: 'รอยืนยัน' })
  memberName.value = ''; memberPhone.value = ''; showCreate.value = false
  notify('เพิ่มสมาชิกตัวอย่างแล้ว')
}
</script>

<template>
  <div class="page-heading">
    <div><div class="eyebrow">CUSTOMER RELATIONSHIP</div><h1>สมาชิกและลูกค้า</h1><p>จัดการสมาชิก คะแนนสะสม และข้อมูลติดต่อของลูกค้า</p></div>
    <div class="heading-actions"><button class="btn btn-light" @click="notify('ส่งออกรายชื่อในระบบจริงได้หลังเชื่อม MySQL')"><AppIcon name="download" :size="15" />ส่งออกรายชื่อ</button><button class="btn btn-primary" @click="showCreate = true"><AppIcon name="plus" :size="16" />เพิ่มสมาชิก</button></div>
  </div>

  <section class="member-kpis">
    <article class="mini-stat"><span class="mini-stat-icon"><AppIcon name="users" :size="17" /></span><div><small>สมาชิกทั้งหมด</small><strong>5,248</strong><em>+12.8% เดือนนี้</em></div></article>
    <article class="mini-stat"><span class="mini-stat-icon green"><AppIcon name="spark" :size="17" /></span><div><small>สมัครใหม่เดือนนี้</small><strong>286</strong><em>จาก LINE 78%</em></div></article>
    <article class="mini-stat"><span class="mini-stat-icon amber"><AppIcon name="gift" :size="17" /></span><div><small>คะแนนสะสมรวม</small><strong>1.42M</strong><em>รอแลกรางวัล 132 รายการ</em></div></article>
    <article class="mini-stat"><span class="mini-stat-icon blue"><AppIcon name="shield" :size="17" /></span><div><small>รอยืนยันข้อมูล</small><strong>18</strong><em>ต้องตรวจสอบ</em></div></article>
  </section>

  <section class="panel member-panel">
    <div class="panel-head"><div><h2 class="panel-title">รายชื่อสมาชิก</h2><p class="panel-subtitle">ข้อมูลตัวอย่างเพื่อแสดงรูปแบบการจัดการสมาชิก</p></div><button class="panel-action" @click="notify('แสดงตัวกรองเพิ่มเติมในระบบจริง')"><AppIcon name="filter" :size="14" />ตัวกรอง</button></div>
    <div class="member-toolbar">
      <label class="search-field"><AppIcon name="search" :size="16" /><input v-model="search" type="search" placeholder="ค้นหาชื่อ, รหัสสมาชิก, เบอร์โทร..." /></label>
      <div class="filter-tabs"><button v-for="s in ['ทั้งหมด','ใช้งาน','รอยืนยัน','พักใช้งาน']" :key="s" :class="{ active: stateFilter === s }" @click="stateFilter = s">{{ s }}</button></div>
    </div>
    <div class="table-wrap">
      <table class="data-table members-table">
        <thead><tr><th>สมาชิก</th><th>รถที่ใช้บริการ</th><th>คะแนน</th><th>สมัครเมื่อ</th><th>สถานะ</th><th></th></tr></thead>
        <tbody>
          <tr v-for="m in filteredMembers" :key="m.id">
            <td><div class="person-cell"><span class="person-avatar red">{{ m.name.slice(-2) }}</span><div><div class="table-primary">{{ m.name }}</div><div class="table-secondary">{{ m.id }} · {{ m.phone }}</div></div></div></td>
            <td>{{ m.vehicle }}</td><td><strong class="points">{{ m.points }}</strong> <span class="muted">pts</span></td><td>{{ m.joined }}</td>
            <td><span class="badge" :class="m.state === 'ใช้งาน' ? 'badge-green' : m.state === 'รอยืนยัน' ? 'badge-amber' : 'badge-gray'">{{ m.state }}</span></td>
            <td><button class="tiny-action" :aria-label="`ดู ${m.name}`" @click="openDetail(m)"><AppIcon name="more" /></button></td>
          </tr>
          <tr v-if="!filteredMembers.length"><td colspan="6"><div class="empty-state"><AppIcon name="search" :size="23"/><strong>ไม่พบสมาชิก</strong><p>ลองเปลี่ยนคำค้นหาหรือตัวกรอง</p></div></td></tr>
        </tbody>
      </table>
    </div>
    <div class="table-foot"><span>แสดง {{ filteredMembers.length }} จาก 5,248 รายการตัวอย่าง</span><div><button disabled>‹</button><button class="current-page">1</button><button @click="notify('หน้าถัดไปจะแสดงเมื่อเชื่อมฐานข้อมูล')">2</button><button @click="notify('หน้าถัดไปจะแสดงเมื่อเชื่อมฐานข้อมูล')">3</button><button @click="notify('หน้าถัดไปจะแสดงเมื่อเชื่อมฐานข้อมูล')">›</button></div></div>
  </section>

  <div v-if="showCreate" class="modal-backdrop" @click.self="showCreate = false">
    <div class="modal-card">
      <div class="modal-head"><div><h3>เพิ่มสมาชิก</h3><p>กรอกข้อมูลเพื่อสร้างสมาชิกในระบบตัวอย่าง</p></div><button class="modal-close" @click="showCreate = false"><AppIcon name="close" :size="16" /></button></div>
      <div class="modal-content"><div class="field"><label class="form-label">ชื่อที่แสดง <span class="required">*</span></label><input v-model="memberName" class="form-control" placeholder="เช่น สมาชิกใหม่" /></div><div class="field"><label class="form-label">เบอร์โทรศัพท์ <span class="required">*</span></label><input v-model="memberPhone" class="form-control" placeholder="08X-XXX-XXXX" /></div><div class="field"><label class="form-label">ทะเบียนรถ (ไม่บังคับ)</label><input class="form-control" placeholder="เช่น กท •• 1234" /></div></div>
      <div class="modal-footer"><button class="btn btn-light" @click="showCreate = false">ยกเลิก</button><button class="btn btn-primary" @click="addMember">บันทึกสมาชิก</button></div>
    </div>
  </div>
  <div v-if="showDetail && selected" class="modal-backdrop" @click.self="showDetail = false">
    <div class="modal-card">
      <div class="modal-head"><div><h3>ข้อมูลสมาชิก</h3><p>{{ selected.id }}</p></div><button class="modal-close" @click="showDetail = false"><AppIcon name="close" :size="16" /></button></div>
      <div class="modal-content"><div class="detail-person"><span class="detail-avatar">{{ selected.name.slice(-2) }}</span><div><strong>{{ selected.name }}</strong><small>สมาชิกตั้งแต่ {{ selected.joined }}</small></div></div><div class="detail-grid"><div><small>เบอร์โทรศัพท์</small><strong>{{ selected.phone }}</strong></div><div><small>คะแนนสะสม</small><strong>{{ selected.points }} คะแนน</strong></div><div><small>รถที่ใช้บริการ</small><strong>{{ selected.vehicle }}</strong></div><div><small>สถานะ</small><strong>{{ selected.state }}</strong></div></div><div class="info-note"><AppIcon name="shield" :size="15" />ข้อมูลนี้เป็นข้อมูลตัวอย่าง ไม่ใช่ข้อมูลจากระบบเดิม</div></div>
      <div class="modal-footer"><button class="btn btn-light" @click="showDetail = false">ปิด</button><button class="btn btn-primary" @click="notify('การแก้ไขสมาชิกจะเชื่อม API ในขั้นตอนถัดไป')">แก้ไขข้อมูล</button></div>
    </div>
  </div>
</template>

<style scoped>
.member-kpis{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:12px;margin-bottom:15px}.mini-stat{background:#fff;border:1px solid #eceef0;border-radius:13px;padding:14px;display:flex;align-items:center;gap:11px;box-shadow:var(--shadow)}.mini-stat-icon{width:36px;height:36px;border-radius:10px;background:#fff0f1;color:var(--red);display:grid;place-items:center;flex:none}.mini-stat-icon.green{color:#15966d;background:#e8f7f0}.mini-stat-icon.amber{color:#bc7810;background:#fff5df}.mini-stat-icon.blue{color:#3374c8;background:#edf4ff}.mini-stat>div{display:flex;flex-direction:column;gap:3px}.mini-stat small{font-size:9px;color:#81868d}.mini-stat strong{font-size:18px;line-height:1.15}.mini-stat em{font-style:normal;font-size:8px;color:#15a275}.member-panel{overflow:hidden}.member-toolbar{padding:0 18px 13px;display:flex;align-items:center;justify-content:space-between;gap:12px}.member-toolbar .search-field{width:280px}.filter-tabs{display:flex;align-items:center;gap:4px}.filter-tabs button{border:0;background:transparent;color:#82878e;font-size:9px;font-weight:700;padding:7px 9px;border-radius:7px}.filter-tabs button.active{background:#fff0f1;color:var(--red)}.points{color:#2d3035}.table-foot{border-top:1px solid #f0f1f3;padding:11px 17px;display:flex;align-items:center;justify-content:space-between;color:#969ba2;font-size:9px}.table-foot>div{display:flex;gap:4px}.table-foot button{width:26px;height:25px;border:1px solid #e8eaed;border-radius:6px;background:#fff;color:#777d84;font-size:10px}.table-foot button:disabled{opacity:.4}.table-foot button.current-page{background:var(--red);border-color:var(--red);color:#fff}.required{color:var(--red)}.detail-person{display:flex;align-items:center;gap:11px;margin-bottom:18px}.detail-avatar{width:48px;height:48px;border-radius:14px;background:#fff0f1;color:var(--red);display:grid;place-items:center;font-weight:850}.detail-person>div{display:flex;flex-direction:column;gap:4px}.detail-person strong{font-size:14px}.detail-person small{font-size:9px;color:#92979e}.detail-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:16px}.detail-grid>div{border:1px solid #eef0f2;border-radius:9px;padding:10px}.detail-grid small,.detail-grid strong{display:block}.detail-grid small{color:#9aa0a6;font-size:9px;margin-bottom:5px}.detail-grid strong{font-size:10px;color:#3f444a}.info-note{margin-top:8px}
@media(max-width:900px){.member-kpis{grid-template-columns:repeat(2,minmax(0,1fr))}.member-toolbar{align-items:flex-start;flex-direction:column}.member-toolbar .search-field{width:100%}.filter-tabs{max-width:100%;overflow:auto}}
</style>
