<script setup lang="ts">
definePageMeta({ layout: 'blank' })
const accepted = ref(false)
const submitted = ref(false)
const name = ref('')
const surname = ref('')
const phone = ref('')
const email = ref('')
const gender = ref('')
const day = ref('')
const month = ref('')
const year = ref('')
const months = ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม']
const days = Array.from({ length: 31 }, (_, i) => i + 1)
const years = Array.from({ length: 70 }, (_, i) => 2569 - i)
function submitRegistration() {
  if (!phone.value || !name.value || !surname.value || !day.value || !month.value || !year.value || !gender.value || !accepted.value) return
  submitted.value = true
}
</script>

<template>
  <div class="registration-page">
    <header class="register-topbar"><NuxtLink to="/" class="register-logo"><span class="register-brand-emblem">C</span><span><strong>COCKPIT</strong><small>LAEM CHABANG</small></span></NuxtLink><div class="register-top-right"><span class="secure-mark"><AppIcon name="shield" :size="13" /> ปลอดภัย</span><NuxtLink to="/" class="back-admin"><AppIcon name="arrowRight" :size="13" /> กลับหน้า CRM</NuxtLink></div></header>
    <main class="register-main">
      <div class="registration-card">
        <div class="tire-backdrop"><span class="tire-ring ring-a"/><span class="tire-ring ring-b"/><span class="tire-ring ring-c"/><span class="tire-glint"/></div>
        <div class="register-content">
          <div v-if="submitted" class="success-state"><span class="success-check"><AppIcon name="check" :size="30" /></span><h1>ลงทะเบียนเรียบร้อย</h1><p>ขอบคุณที่สมัครสมาชิก Cockpit<br />ต้นแบบนี้ไม่ได้ส่งหรือบันทึกข้อมูลเข้าสู่ระบบจริง</p><NuxtLink class="register-submit" to="/">กลับหน้าหลัก CRM</NuxtLink></div>
          <template v-else>
            <div class="profile-icon"><svg viewBox="0 0 64 64" aria-hidden="true"><circle cx="32" cy="32" r="31" fill="white"/><circle cx="32" cy="23" r="11" fill="#aeb2b7"/><path d="M12 55c2-12 9-18 20-18s18 6 20 18" fill="#aeb2b7"/><path d="M20 51c3-5 7-7 12-7s9 2 12 7" fill="#858a90"/></svg></div>
            <div class="register-intro"><span class="register-kicker">COCKPIT · LAEM CHABANG</span><h1>สมัครสมาชิก</h1><p>กรุณากรอกข้อมูลจริง<br />เพื่อรับสิทธิพิเศษและคะแนนสะสม</p></div>
            <form class="register-form" @submit.prevent="submitRegistration">
              <div class="register-field"><label>หมายเลขโทรศัพท์ <b>*</b></label><input v-model="phone" type="tel" inputmode="tel" placeholder="เช่น 08X-XXX-XXXX" required /></div>
              <div class="register-field"><label>อีเมล</label><input v-model="email" type="email" placeholder="อีเมล (ไม่บังคับ)" /></div>
              <div class="register-row">
                <div class="register-field"><label>ชื่อ <b>*</b></label><input v-model="name" placeholder="ชื่อ" required /></div>
                <div class="register-field"><label>นามสกุล <b>*</b></label><input v-model="surname" placeholder="นามสกุล" required /></div>
              </div>
              <div class="register-field"><label>วันเกิด (วัน/เดือน/ปี) <b>*</b></label><div class="birth-row"><select v-model="day" required><option value="" disabled>วันที่</option><option v-for="d in days" :key="d" :value="String(d)">{{ d }}</option></select><select v-model="month" required><option value="" disabled>เดือน</option><option v-for="(m,i) in months" :key="m" :value="String(i+1)">{{ m }}</option></select><select v-model="year" required><option value="" disabled>ปี</option><option v-for="y in years" :key="y" :value="String(y)">{{ y }}</option></select></div></div>
              <fieldset class="gender-field"><legend>เพศ <b>*</b></legend><label><input v-model="gender" type="radio" name="gender" value="ชาย" required /><span>ชาย</span></label><label><input v-model="gender" type="radio" name="gender" value="หญิง" /><span>หญิง</span></label><label><input v-model="gender" type="radio" name="gender" value="อื่น ๆ" /><span>อื่น ๆ</span></label></fieldset>
              <label class="terms-row"><input v-model="accepted" type="checkbox" required /><span>ยอมรับ <a href="#terms" @click.prevent>เงื่อนไขและข้อตกลง</a> และ <a href="#privacy" @click.prevent>นโยบายความเป็นส่วนตัว</a></span></label>
              <button class="register-submit" type="submit">ยืนยันการสมัคร <AppIcon name="arrowRight" :size="15" /></button>
              <p class="prototype-disclaimer"><AppIcon name="shield" :size="12" />แบบฟอร์มนี้เป็นต้นแบบ ข้อมูลจะไม่ถูกจัดเก็บหรือส่งออก</p>
            </form>
            <div class="register-footer-logo"><span class="footer-speedline">〰</span><strong>COCKPIT</strong><small>LAEM CHABANG INTER AUTO TIRE</small></div>
          </template>
        </div>
      </div>
      <p class="register-page-foot">© 2026 Cockpit Laem Chabang · แบบฟอร์มตัวอย่างสำหรับสมาชิก</p>
    </main>
  </div>
</template>

<style scoped>
.registration-page{min-height:100vh;background:#f3f4f6}.register-topbar{height:57px;background:#fff;border-bottom:1px solid #eceef0;display:flex;align-items:center;justify-content:space-between;padding:0 max(22px,calc((100vw - 1160px)/2))}.register-logo{display:flex;align-items:center;gap:8px}.register-brand-emblem{width:30px;height:30px;border-radius:50%;background:var(--red);color:#fff;display:grid;place-items:center;font-weight:950;font-style:italic;font-size:18px;border:3px double #fff;outline:1px solid var(--red)}.register-logo>span:last-child{display:flex;flex-direction:column;line-height:1}.register-logo strong{font-size:15px;letter-spacing:-.6px;font-style:italic}.register-logo small{font-size:6px;letter-spacing:.8px;color:#969ba2;margin-top:3px}.register-top-right{display:flex;align-items:center;gap:18px}.secure-mark,.back-admin{font-size:9px;color:#798088;display:flex;align-items:center;gap:4px}.secure-mark svg{color:#1a9b71}.back-admin{color:var(--red);font-weight:700}.register-main{display:flex;flex-direction:column;align-items:center;padding:23px 14px 28px}.registration-card{position:relative;width:min(100%,610px);min-height:910px;border-radius:15px;overflow:hidden;background:#0c0d0f;box-shadow:0 13px 42px rgba(22,26,30,.14);color:#fff}.registration-card:before{content:"";position:absolute;inset:0;background:linear-gradient(180deg,rgba(5,6,8,.2),rgba(5,6,8,.78) 77%,#090a0b 100%);z-index:1}.tire-backdrop{position:absolute;inset:0;overflow:hidden;background:radial-gradient(ellipse at 19% 76%,#4b4c4a 0%,#252729 18%,#101113 39%,transparent 57%),radial-gradient(ellipse at 78% 44%,#333638 0%,#121416 42%,transparent 65%),linear-gradient(138deg,#17191b 0%,#08090a 50%,#1b1d20 100%)}.tire-ring{position:absolute;border-radius:50%;border:1px solid rgba(255,255,255,.1);transform:rotate(-18deg);background:repeating-conic-gradient(rgba(255,255,255,.075) 0 2deg,transparent 2deg 5deg)}.ring-a{width:390px;height:880px;left:4%;top:10%;box-shadow:inset 0 0 0 14px rgba(0,0,0,.65),inset 0 0 0 23px rgba(255,255,255,.08),0 0 0 12px rgba(0,0,0,.28)}.ring-b{width:330px;height:730px;left:11%;top:18%;border:22px solid rgba(12,13,14,.72);box-shadow:0 0 0 2px rgba(255,255,255,.08)}.ring-c{width:510px;height:940px;right:-48%;top:1%;border:40px solid rgba(0,0,0,.5)}.tire-glint{position:absolute;left:27%;top:18%;height:70%;width:2px;background:linear-gradient(transparent,rgba(255,255,255,.35),transparent);filter:blur(2px);transform:rotate(-7deg)}.register-content{position:relative;z-index:2;width:100%;padding:30px 44px 24px;display:flex;align-items:center;flex-direction:column}.profile-icon{width:78px;height:78px;border-radius:50%;background:#fff;border:4px solid rgba(255,255,255,.84);box-shadow:0 8px 25px rgba(0,0,0,.35);display:grid;place-items:center;margin-bottom:12px}.profile-icon svg{width:73px;height:73px}.register-intro{text-align:center;margin-bottom:21px}.register-kicker{font-size:8px;font-weight:900;letter-spacing:1.4px;color:#fa313b}.register-intro h1{font-size:22px;margin:4px 0 4px;font-weight:850}.register-intro p{font-size:12px;line-height:1.55;color:#f1f2f3;margin:0}.register-form{width:100%;max-width:520px}.register-field{margin-bottom:12px}.register-field label,.gender-field legend{display:block;font-size:11px;color:#fff;margin-bottom:6px;font-weight:650}.register-field label b,.gender-field b{color:#ff4650}.register-field input,.birth-row select{width:100%;height:42px;border:0;border-radius:6px;background:#fff;color:#43474d;padding:0 12px;font-size:11px;outline:0}.register-field input:focus,.birth-row select:focus{box-shadow:0 0 0 3px rgba(227,6,19,.45)}.register-field input::placeholder{color:#a6abb1}.register-row{display:grid;grid-template-columns:1fr 1fr;gap:10px}.birth-row{display:grid;grid-template-columns:1fr 1fr 1fr;gap:10px}.birth-row select{appearance:auto;color:#737981}.gender-field{border:0;padding:0;margin:15px 0 16px;display:flex;align-items:center;gap:14px}.gender-field legend{float:left;margin-right:0;margin-bottom:0}.gender-field label{display:flex;align-items:center;gap:5px;font-size:11px;color:#fff;cursor:pointer}.gender-field input{accent-color:var(--red);width:14px;height:14px}.terms-row{display:flex;align-items:flex-start;gap:9px;margin:17px 0 17px;font-size:10px;color:#fff}.terms-row input{width:15px;height:15px;margin:0;accent-color:var(--red);flex:none}.terms-row a{color:#fff;text-decoration:underline;text-underline-offset:2px}.register-submit{min-height:42px;min-width:130px;border:0;border-radius:7px;background:var(--red);color:white;font-size:12px;font-weight:800;padding:0 18px;display:flex;align-items:center;justify-content:center;gap:8px;margin:0 auto;transition:.18s}.register-submit:hover{background:#c6000f;transform:translateY(-1px)}.prototype-disclaimer{display:flex;align-items:center;justify-content:center;gap:5px;color:#b4b8bd;font-size:8px;text-align:center;margin:12px 0 15px}.register-footer-logo{margin-top:5px;display:flex;align-items:center;flex-direction:column;line-height:1}.register-footer-logo strong{font-size:17px;font-weight:950;font-style:italic;letter-spacing:-1px;color:#f8f8f8}.register-footer-logo small{font-size:6px;letter-spacing:1px;color:#a8abb0;margin-top:4px}.footer-speedline{font-size:18px;color:var(--red);line-height:.7;transform:rotate(-8deg);margin-bottom:2px}.register-page-foot{font-size:8px;color:#9ca1a7;margin:12px 0 0}.success-state{min-height:700px;display:flex;flex-direction:column;align-items:center;justify-content:center;text-align:center}.success-check{width:64px;height:64px;border-radius:50%;background:#15966d;color:#fff;display:grid;place-items:center}.success-state h1{font-size:22px;margin:18px 0 6px}.success-state p{color:#c2c5c9;line-height:1.7;font-size:11px;margin:0 0 18px}.success-state .register-submit{min-width:180px}
@media(max-width:650px){.register-topbar{height:51px;padding:0 14px}.register-top-right{gap:9px}.secure-mark{display:none}.back-admin{font-size:8px}.register-main{padding:0}.registration-card{width:100%;min-height:calc(100vh - 51px);border-radius:0;box-shadow:none}.register-content{padding:25px 18px 21px}.register-intro{margin-bottom:17px}.register-intro h1{font-size:20px}.register-field input,.birth-row select{height:43px}.register-row{gap:8px}.register-row .register-field label{font-size:10px}.gender-field{gap:10px}.gender-field label{font-size:10px}.register-page-foot{display:none}.ring-a{left:-8%;width:345px}.ring-b{left:4%;width:300px}.ring-c{right:-90%}}
</style>
