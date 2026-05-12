# Google Sign-In Setup Guide

## Overview

Google Sign-In has been fully integrated into your Flutter app. This guide walks you through the final configuration steps needed to make it work.

## What's Been Done ✅

- ✅ Added `google_sign_in: ^6.1.5` package
- ✅ Implemented `signInWithGoogle()` method in data layer
- ✅ Updated repository, use case, and UI with Google login
- ✅ Connected Google button to sign-in flow
- ✅ Auto-creates user profile on first Google sign-in
- ✅ Shows loading spinner while signing in

## Required Setup Steps

### Step 1: Configure Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project (Movie)
3. Navigate to **Authentication** → **Sign-in method**
4. Enable **Google** sign-in provider
5. Click on Google and select your Support Email
6. Click **Save**

### Step 2: Get Google Web Client ID

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Select your project
3. Navigate to **APIs & Services** → **Credentials**
4. Look for **OAuth 2.0 Client IDs**
5. Click the **Web client** credential
6. Copy the **Client ID** (you'll need this for Android/iOS)

### Step 3: Android Configuration

#### 3a. Get SHA-1 Debug Certificate

In your project directory, run:

**Windows:**

```bash
cd android
.\gradlew signingReport
```

**Mac/Linux:**

```bash
cd android
./gradlew signingReport
```

Look for: `SHA1: XX:XX:XX:...` (copy the full SHA-1)

#### 3b. Add SHA-1 to Firebase

1. In Firebase Console → **Project Settings** (gear icon)
2. Go to **Your apps** section
3. Find your Android app
4. Click **Add fingerprint**
5. Paste the SHA-1 and click **Save**

#### 3c. Verify google-services.json

Make sure `android/app/google-services.json` exists with proper configuration.

### Step 4: iOS Configuration

#### 4a. Configure Info.plist

Edit `ios/Runner/Info.plist` and add:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.googleusercontent.apps.YOUR-GOOGLE-CLIENT-ID</string>
    </array>
  </dict>
</array>
```

Replace `YOUR-GOOGLE-CLIENT-ID` with your actual Client ID from Google Cloud Console.

#### 4b. Update CocoaPods

```bash
cd ios
pod install --repo-update
cd ..
```

### Step 5: Web Configuration (Optional)

If deploying to web, add in `web/index.html` in the `<head>` section:

```html
<script src="https://accounts.google.com/gsi/client" async defer></script>
```

## Testing Google Sign-In

1. Run your app on Android or iOS:

   ```bash
   flutter run
   ```

2. On the login page, click **"Login With Google"**

3. Select a Google account

4. Should redirect to Home page

5. Check Firebase Console → **Authentication** → **Users** to see the new user

## Troubleshooting

### Error: "Google Sign-In Error: PlatformException"

- Verify SHA-1 certificate was added to Firebase
- Check `google-services.json` is in `android/app/`
- Ensure Google sign-in is enabled in Firebase Console

### Error: "Sign-In cancelled"

- User clicked "Cancel" on Google sign-in dialog
- This is normal behavior, app handles it gracefully

### Error: "Client ID not found"

- Ensure proper URL scheme in Info.plist (iOS)
- Verify Client ID format in Info.plist

### User Logs in but No Profile Data

- Check Firestore security rules allow writes
- Verify Firestore has `users` collection (auto-created on first write)

## How Google Sign-In Works in Your App

```
User clicks "Login With Google"
        ↓
Google OAuth dialog appears
        ↓
User selects/signs in with Google account
        ↓
Firebase validates Google token
        ↓
Check if user exists in Firestore
        ↓
If NEW user → Create profile with Google data:
  - Email from Google
  - Display name from Google
  - Profile picture URL
        ↓
Login successful → Redirect to Home
```

## Features

✅ Works on Android, iOS, and Web  
✅ Auto-creates user profile  
✅ Uses Google profile picture as avatar  
✅ Seamless integration with email/password login  
✅ Shows loading spinner during sign-in  
✅ Error messages if sign-in fails

## User Data Saved to Firestore

When user signs in with Google:

```json
{
  "id": "firebase_uid",
  "email": "user@gmail.com",
  "name": "User Display Name",
  "phone": "",
  "avatarIndex": 0,
  "imageUrl": "https://google-profile-picture-url",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

## Next Steps (Optional)

- Add "Sign in with Apple" (iOS)
- Add "Sign in with Facebook"
- Custom error handling UI
- Remember me functionality

## Support

If you encounter issues:

1. Check [Google Sign-In Documentation](https://pub.dev/packages/google_sign_in)
2. Review [Firebase Authentication Docs](https://firebase.google.com/docs/auth)
3. Check Android/iOS native logs: `flutter logs`

---

**Current Status:** Ready for testing after Firebase console configuration (Step 1) and Android/iOS setup (Steps 3-4).
