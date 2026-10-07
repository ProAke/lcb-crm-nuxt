<script setup lang="ts">
definePageMeta({ layout: 'blank' })

const loading = ref(false)
const username = ref('')
const password = ref('')
const showPassword = ref(false)
const error = ref('')

async function handleLogin() {
  if (!username.value || !password.value) return
  loading.value = true
  error.value = ''

  // Simulate login - replace with actual API call
  await new Promise(resolve => setTimeout(resolve, 1000))

  // Demo credentials: admin / admin123
  if (username.value === 'admin' && password.value === 'admin123') {
    // In real app: navigate to dashboard
    window.location.href = '/'
  } else {
    error.value = 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'
  }
  loading.value = false
}
</script>

<template>
  <div class="login-page">
    <header class="login-topbar">
      <NuxtLink to="/" class="login-logo">
        <img src="/static/logo.png" alt="Laem Chabang Inter Autotire" class="login-logo-img" />
        <span class="login-brand-text">
          <strong>Laem Chabang Inter Autotire</strong>
          <small>แหลมฉบังอินเตอร์ออโต้ไทร์</small>
        </span>
      </NuxtLink>
      <div class="login-top-right">
        <span class="secure-mark">
          <AppIcon name="shield" :size="13" /> ระบบปลอดภัย
        </span>
      </div>
    </header>

    <main class="login-main">
      <div class="login-card">
        <div class="login-backdrop">
          <span class="backdrop-ring ring-a" />
          <span class="backdrop-ring ring-b" />
          <span class="backdrop-ring ring-c" />
          <span class="backdrop-glint" />
        </div>

        <div class="login-content">
          <div class="login-header">
            <div class="login-avatar">
              <AppIcon name="user" :size="28" />
            </div>
            <div class="login-intro">
              <span class="login-kicker">COCKPIT CRM</span>
              <h1>เข้าสู่ระบบ</h1>
              <p>ระบบจัดการลูกค้าและการบริการ<br />แหลมฉบัง อินเตอร์ ออโต้ ไทร์</p>
            </div>
          </div>

          <div v-if="error" class="login-error">
            <AppIcon name="alertCircle" :size="14" />
            <span>{{ error }}</span>
          </div>

          <form class="login-form" @submit.prevent="handleLogin">
            <div class="login-field">
              <label>ชื่อผู้ใช้ / อีเมล <b>*</b></label>
              <div class="input-wrapper">
                <AppIcon name="user" :size="16" class="input-icon" />
                <input
                  v-model="username"
                  type="text"
                  placeholder="กรอกชื่อผู้ใช้หรืออีเมล"
                  required
                  autocomplete="username"
                  :disabled="loading"
                />
              </div>
            </div>

            <div class="login-field">
              <label>
                รหัสผ่าน <b>*</b>
                <span class="field-hint">
                  <a href="#forgot" @click.prevent>ลืมรหัสผ่าน?</a>
                </span>
              </label>
              <div class="input-wrapper">
                <AppIcon name="lock" :size="16" class="input-icon" />
                <input
                  :type="showPassword ? 'text' : 'password'"
                  v-model="password"
                  placeholder="กรอกรหัสผ่าน"
                  required
                  autocomplete="current-password"
                  :disabled="loading"
                />
                <button
                  type="button"
                  class="toggle-password"
                  @click="showPassword = !showPassword"
                  :aria-label="showPassword ? 'ซ่อนรหัสผ่าน' : 'แสดงรหัสผ่าน'"
                  :disabled="loading"
                >
                  <AppIcon :name="showPassword ? 'eyeOff' : 'eye'" :size="16" />
                </button>
              </div>
            </div>

            <div class="login-options">
              <label class="remember-row">
                <input type="checkbox" />
                <span>จดจำฉัน</span>
              </label>
            </div>

            <button class="login-submit" type="submit" :disabled="loading">
              <span v-if="loading">
                <AppIcon name="loader" :size="16" class="spin" />
                กำลังเข้าสู่ระบบ...
              </span>
              <span v-else>เข้าสู่ระบบ <AppIcon name="arrowRight" :size="15" /></span>
            </button>

            <div class="demo-credentials">
              <p class="demo-label">Demo Credentials:</p>
              <div class="cred-row">
                <kbd>admin</kbd>
                <span>/</span>
                <kbd>admin123</kbd>
              </div>
            </div>

            <p class="prototype-disclaimer">
              <AppIcon name="shield" :size="12" />
              หน้านี้เป็นต้นแบบทดสอบ · ไม่ได้เชื่อมต่อฐานข้อมูลจริง
            </p>
          </form>

          <div class="login-footer">
            <span class="footer-speedline">〰</span>
            <strong>COCKPIT</strong>
            <small>LAEM CHABANG INTER AUTO TIRE</small>
          </div>
        </div>
      </div>

      <p class="login-page-foot">
        © 2026 Laem Chabang Inter Autotire · CRM Prototype
      </p>
    </main>
  </div>
</template>

<style scoped>
.login-page {
  min-height: 100vh;
  background: #f3f4f6;
  font-family: Inter, "Noto Sans Thai", "Leelawadee UI", Tahoma, Arial, sans-serif;
}

.login-topbar {
  height: 64px;
  background: #fff;
  border-bottom: 1px solid #eceef0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 max(24px, calc((100vw - 1200px) / 2));
}

.login-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
  color: inherit;
}

.login-logo-img {
  height: 44px;
  width: auto;
  object-fit: contain;
}

.login-brand-text {
  display: flex;
  flex-direction: column;
  line-height: 1.1;
}

.login-brand-text strong {
  font-size: 16px;
  font-weight: 800;
  letter-spacing: -0.5px;
  color: #191a1c;
}

.login-brand-text small {
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.8px;
  color: #9aa0a8;
  margin-top: 2px;
}

.login-top-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

.secure-mark {
  font-size: 11px;
  color: #737982;
  display: flex;
  align-items: center;
  gap: 5px;
}

.secure-mark svg {
  color: #15966d;
}

.login-main {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px 20px 48px;
}

.login-card {
  position: relative;
  width: min(100%, 440px);
  min-height: 580px;
  border-radius: 20px;
  overflow: hidden;
  background: #0c0d0f;
  box-shadow: 0 20px 60px rgba(22, 26, 30, 0.18);
  color: #fff;
}

.login-backdrop {
  position: absolute;
  inset: 0;
  overflow: hidden;
  background:
    radial-gradient(ellipse at 15% 70%, #4b4c4a 0%, #252729 18%, #101113 39%, transparent 57%),
    radial-gradient(ellipse at 85% 40%, #333638 0%, #121416 42%, transparent 65%),
    linear-gradient(138deg, #17191b 0%, #08090a 50%, #1b1d20 100%);
}

.backdrop-ring {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba(255, 255, 255, 0.08);
  transform: rotate(-18deg);
  background: repeating-conic-gradient(
    rgba(255, 255, 255, 0.06) 0 2deg,
    transparent 2deg 5deg
  );
}

.ring-a {
  width: 320px;
  height: 680px;
  left: -2%;
  top: 8%;
  box-shadow: inset 0 0 0 12px rgba(0, 0, 0, 0.15);
}

.ring-b {
  width: 260px;
  height: 520px;
  left: 8%;
  bottom: -8%;
  box-shadow: inset 0 0 0 8px rgba(227, 6, 19, 0.08);
  border-color: rgba(227, 6, 19, 0.15);
}

.ring-c {
  width: 420px;
  height: 380px;
  right: -15%;
  top: -5%;
  opacity: 0.6;
}

.backdrop-glint {
  position: absolute;
  width: 180px;
  height: 180px;
  right: 2%;
  top: 12%;
  border-radius: 50%;
  background: radial-gradient(circle at 30% 30%, rgba(227, 6, 19, 0.12), transparent 70%);
  pointer-events: none;
}

.login-content {
  position: relative;
  z-index: 2;
  padding: 36px 32px 40px;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.login-header {
  text-align: center;
  margin-bottom: 28px;
}

.login-avatar {
  width: 72px;
  height: 72px;
  margin: 0 auto 16px;
  border-radius: 50%;
  background: linear-gradient(135deg, #e30613 0%, #bf0010 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 8px 24px rgba(227, 6, 19, 0.35);
}

.login-avatar svg {
  color: #fff;
}

.login-intro {
  margin-top: 4px;
}

.login-kicker {
  display: inline-block;
  font-size: 10px;
  font-weight: 800;
  letter-spacing: 1.2px;
  text-transform: uppercase;
  color: #e30613;
  background: rgba(227, 6, 19, 0.12);
  padding: 4px 10px;
  border-radius: 20px;
  margin-bottom: 10px;
}

.login-intro h1 {
  font-size: 26px;
  font-weight: 900;
  letter-spacing: -0.6px;
  margin: 0 0 8px;
  color: #fff;
}

.login-intro p {
  font-size: 13px;
  line-height: 1.6;
  color: #a8abb1;
  margin: 0;
}

.login-error {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 14px;
  background: rgba(227, 6, 19, 0.15);
  border: 1px solid rgba(227, 6, 19, 0.3);
  border-radius: 10px;
  color: #ff6b72;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 20px;
  animation: shakeIn 0.3s ease;
}

@keyframes shakeIn {
  0% { transform: translateX(-8px); opacity: 0; }
  20% { transform: translateX(4px); }
  40% { transform: translateX(-2px); }
  60% { transform: translateX(1px); }
  100% { transform: translateX(0); opacity: 1; }
}

.login-error svg {
  flex-shrink: 0;
  color: #e30613;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 18px;
  flex: 1;
}

.login-field label {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 12px;
  font-weight: 700;
  color: #e8eaed;
  margin-bottom: 8px;
}

.login-field b {
  color: #fff;
}

.field-hint a {
  font-size: 11px;
  font-weight: 600;
  color: #e30613;
  text-decoration: none;
}

.field-hint a:hover {
  text-decoration: underline;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  transition: all 0.18s;
}

.input-wrapper:focus-within {
  border-color: #e30613;
  box-shadow: 0 0 0 3px rgba(227, 6, 19, 0.15);
  background: rgba(255, 255, 255, 0.06);
}

.input-icon {
  position: absolute;
  left: 14px;
  color: #7a8089;
  pointer-events: none;
  transition: color 0.18s;
}

.input-wrapper:focus-within .input-icon {
  color: #e30613;
}

.input-wrapper input {
  flex: 1;
  height: 52px;
  padding: 0 16px 0 46px;
  background: transparent;
  border: none;
  color: #fff;
  font-size: 15px;
  font-family: inherit;
  outline: none;
}

.input-wrapper input::placeholder {
  color: #6a7078;
}

.input-wrapper input:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.toggle-password {
  position: absolute;
  right: 10px;
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  color: #7a8078;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.15s;
}

.toggle-password:hover:not(:disabled) {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
}

.toggle-password:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.login-options {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: -4px;
}

.remember-row {
  display: flex;
  align-items: center;
  gap: 7px;
  cursor: pointer;
}

.remember-row input {
  width: 17px;
  height: 17px;
  accent-color: #e30613;
}

.remember-row span {
  font-size: 12px;
  color: #c5cad1;
  font-weight: 500;
}

.login-submit {
  margin-top: 6px;
  height: 50px;
  border-radius: 12px;
  background: linear-gradient(135deg, #e30613 0%, #bf0010 100%);
  border: none;
  color: #fff;
  font-size: 14px;
  font-weight: 800;
  letter-spacing: 0.2px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  cursor: pointer;
  transition: all 0.18s;
  box-shadow: 0 6px 20px rgba(227, 6, 19, 0.35);
}

.login-submit:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 28px rgba(227, 6, 19, 0.45);
}

.login-submit:active:not(:disabled) {
  transform: translateY(0);
}

.login-submit:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.login-submit .spin {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.demo-credentials {
  margin-top: 16px;
  padding: 14px 16px;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 10px;
  text-align: center;
}

.demo-label {
  font-size: 11px;
  font-weight: 700;
  color: #8a8f96;
  text-transform: uppercase;
  letter-spacing: 0.8px;
  margin: 0 0 8px;
}

.cred-row {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  flex-wrap: wrap;
}

.cred-row kbd {
  background: rgba(227, 6, 19, 0.2);
  border: 1px solid rgba(227, 6, 19, 0.3);
  color: #ff858b;
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 700;
  font-family: inherit;
}

.cred-row span {
  color: #6a7078;
  font-size: 12px;
}

.prototype-disclaimer {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  margin-top: 18px;
  font-size: 11px;
  color: #7a8089;
  text-align: center;
}

.prototype-disclaimer svg {
  color: #15966d;
  flex-shrink: 0;
}

.login-footer {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.footer-speedline {
  color: #e30613;
  font-size: 18px;
  letter-spacing: 2px;
  opacity: 0.7;
}

.login-footer strong {
  font-size: 16px;
  font-weight: 900;
  font-style: italic;
  letter-spacing: -0.5px;
  color: #fff;
}

.login-footer small {
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 1.2px;
  color: #8a8f96;
  text-transform: uppercase;
}

.login-page-foot {
  margin-top: 28px;
  font-size: 12px;
  color: #9aa0a8;
  text-align: center;
}

@media (max-width: 480px) {
  .login-topbar {
    height: 56px;
    padding: 0 16px;
  }

  .login-logo-img {
    height: 36px;
  }

  .login-brand-text strong {
    font-size: 14px;
  }

  .login-brand-text small {
    font-size: 9px;
  }

  .secure-mark {
    display: none;
  }

  .login-main {
    padding: 16px 12px 24px;
  }

  .login-card {
    width: 100%;
    min-height: calc(100vh - 72px);
    border-radius: 0;
    box-shadow: none;
  }

  .login-content {
    padding: 28px 20px 32px;
  }

  .login-avatar {
    width: 64px;
    height: 64px;
  }

  .login-intro h1 {
    font-size: 22px;
  }

  .input-wrapper input {
    height: 48px;
    font-size: 16px; /* Prevents zoom on iOS */
  }

  .login-submit {
    height: 48px;
  }
}
</style>