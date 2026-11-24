# HOLOGRAM

**Your World. Your Identity. Your Connection.**

A social platform for sharing photos, videos, short-form reels, stories, messaging, and creator communities.

## Planned platforms
- Android
- iOS

## Planned app stack
- Flutter
- Firebase (authentication, database, storage, notifications)

## Project status
Planning and UI foundation. Authentication, media uploads, messaging, moderation, and production services will be added in later milestones.

## Getting started
Install Flutter SDK, then run:

```bash
flutter pub get
flutter run
```


## Firebase Authentication setup

Firebase credentials are intentionally not committed to this public repository.

1. Create a Firebase project at https://console.firebase.google.com/.
2. Add an Android app and an iOS app using the application IDs from your Flutter project.
3. In Firebase Authentication -> Sign-in method, enable **Email/Password** and **Phone**.
4. Register your Android SHA-1 and SHA-256 fingerprints in Firebase for phone authentication.
5. Add the Android `google-services.json` file to `android/app/` and configure the Google Services Gradle plugin as described in the official FlutterFire setup guide.
6. Add the iOS `GoogleService-Info.plist` file to the Runner target in Xcode.
7. Run `flutter pub get`, then `flutter run`.

Phone OTP uses Firebase Phone Authentication. For development, configure Firebase test phone numbers to avoid sending real SMS repeatedly. Real phone verification can incur SMS charges and is subject to Firebase quotas and regional restrictions.

The repository currently contains the Dart app source and dependency manifest. Generate the native platform folders with `flutter create .` from the project root if they are not present, then complete the Android/iOS Firebase setup above.

## Authentication code

- Email/password sign-up with email verification message
- Email/password login
- Password reset email
- Mobile number OTP sign-in
- Authentication state routing and sign out

Official setup guide: https://firebase.google.com/docs/flutter/setup
