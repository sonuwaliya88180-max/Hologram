# HOLOGRAM Development Roadmap

## Product direction
HOLOGRAM is a global social platform for Android and iOS, built with Flutter and Firebase. The visual direction is premium dark: near-black surfaces with purple and neon-pink accents.

## Milestone 1 — App foundation
- Preserve existing Firebase email/password and phone OTP authentication.
- Establish the dark app theme.
- Add main navigation: Home, Reels, Explore, Activity, Profile.
- Add a first-pass feed layout with story bubbles and sample cards.
- Keep sample content local/demo-only until the backend is connected.

## Milestone 2 — Real user profiles and feed
- Configure Firebase for Android and iOS.
- Add Firestore user profiles and profile editing.
- Add media upload using Firebase Storage or an evaluated media service.
- Store posts in Firestore and display a real-time feed.
- Implement likes, comments, follows and saved posts with security rules.

## Milestone 3 — Stories and Reels
- Add image/video selection, compression, upload progress and playback.
- Add story expiry and visibility rules.
- Add vertical swipe video feed with pagination and moderation/report controls.

## Milestone 4 — Messaging and notifications
- Add one-to-one conversations and message pagination.
- Add push notifications through Firebase Cloud Messaging.
- Add block, mute and report controls before public launch.

## Milestone 5 — Global launch readiness
- Add localization, accessibility and network/error states.
- Add abuse prevention, rate limits, privacy controls and account deletion.
- Add analytics/crash reporting with privacy-conscious settings.
- Test on real Android and iOS devices; prepare store listings and release builds.

## Initial Firestore collection proposal
- users/{uid} — public profile fields and account metadata.
- posts/{postId} — author ID, caption, media references, timestamps and visibility.
- posts/{postId}/likes/{uid} — one like per user.
- posts/{postId}/comments/{commentId} — comment content and author metadata.
- users/{uid}/following/{targetUid} — follow relationships.
- stories/{storyId} — author, media reference, createdAt and expiresAt.
- conversations/{conversationId}/messages/{messageId} — participant-scoped messages.

Do not deploy permissive Firestore or Storage rules. Every write and read must be scoped to authenticated users and relevant resource permissions. Add reporting, blocking and deletion flows before opening the service to the public.

## Current milestone boundaries
The current branch contains a visual/navigation foundation only. Demo stories and feed cards are static sample UI. Likes/bookmarks are local widget state; search, comments, messaging, uploads, real profiles, and notifications are not connected to a backend yet.
