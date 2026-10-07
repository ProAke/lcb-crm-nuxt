# Laem Chabang CRM 2026–2027 — prototype

A Nuxt 3 clickable prototype for the Laem Chabang Inter Auto Tire CRM, using a Cockpit-inspired red / charcoal / white design system.

## Run locally

```bash
npm install
npm run dev
```

The demo uses sample data held in page state. It does **not** connect to MySQL or send/publish anything to LINE yet. The LINE integration screen is intentionally a setup placeholder: keep channel secrets in server-side environment variables only, never in browser code or a public form.

## Prototype pages

- Dashboard overview
- Members / customers
- Service bookings
- Products and services
- Promotions
- LINE Rich Menu manager and visual preview
- LINE Broadcast composer
- Member registration form (`/register`)
- System / LINE connection settings

## Next implementation phase

1. Confirm business rules, staff roles, and required booking / member fields.
2. Create the MySQL schema and Nuxt server API with authentication, role-based access, audit logs, and validation.
3. Add secure LINE Messaging API server routes, rich-menu image upload and publish/unpublish lifecycle, and webhook verification.
4. Replace the demo records with database-backed CRUD, then test with a LINE test channel before production.

The attached screenshots were used as workflow/design references. Existing customer records were not copied into this prototype.
