# Becoming Her — Phase 1 Prototype

## Goal
Build a premium, private, mobile-first digital journal that preserves the cover’s editorial identity and uses the manuscript verbatim for all spiritual content.

## Experience
- Public home page and QR-friendly `/start` entry.
- Calm four-step onboarding with manuscript-led purpose, journal ownership details, and account creation.
- Email/password and Google sign-in, plus secure sign-out and password recovery.
- Private dashboard with continue-reading, persistent progress, eight-part journey navigation, journal history, completed chapters, saved reflections, and account settings.
- Parts and chapter navigation preserving the exact Part I–VIII structure and chapter numbering.
- One complete interactive chapter: Chapter 1, “Before There Was ‘Him,’ There Was God,” using the manuscript’s exact Scripture, context, story, teaching, application, prayer, three reflection questions, and truth to carry.
- Large reflection fields with continuous saving, visible save status, refresh-safe persistence, and chapter completion.
- Thumb-friendly mobile navigation, optimized and checked at 360px, 390px, and 430px.

## Visual direction
- Warm ivory surfaces, dusty rose and muted mauve accents, charcoal text, delicate botanical linework, fine dividers, and restrained shadows.
- High-contrast editorial serif headings with a readable complementary body face.
- Generous whitespace and reading rhythm inspired by the uploaded cover; no generic dashboard styling, excessive cards, gradients, or animation.

## Private data and architecture
- Enable Lovable Cloud authentication and database storage.
- Store private profiles, optional prayer/intention, responses, progress, and entitlements by authenticated user.
- Enforce ownership in database access rules so each user can only access her own profile, writing, and progress.
- Model journeys, parts, chapters, content blocks, and reflection questions so future journeys and a future private content manager can be added without rebuilding the foundation.
- Seed only the Becoming Her structure required for Phase 1 and the complete Chapter 1 content; do not implement the remaining chapter manuscripts yet.

## Verification
- Test sign-up, login, sign-out, private route protection, autosave after refresh, completion persistence, and continue-reading.
- Confirm another account cannot read or change a user’s reflections.
- Review the public, onboarding, dashboard, journey, and chapter screens at all three requested mobile widths.
- Confirm each public page has unique sharing and search metadata and private pages are not indexable.

## Not included in Phase 1
- Full content for Chapters 2–54, payments, campaign analytics, support payments, or an admin interface.
