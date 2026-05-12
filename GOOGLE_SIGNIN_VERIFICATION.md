# Google Sign-In Verification Checklist

## ✅ What Happens When User Signs In With Google

### Step-by-Step Flow:

1. **User Clicks "Login With Google"** ✅
   - `_handleGoogleLogin()` is called
   - Loading spinner appears

2. **Google OAuth Dialog** ✅
   - User selects Google account
   - User allows permissions

3. **Authentication** ✅
   - `GoogleSignIn.signIn()` triggers
   - Google provides credentials
   - Firebase validates token

4. **Firestore Profile Created** ✅
   - System checks if user exists in Firestore
   - If NEW user → Creates profile with:
     ```json
     {
       "id": "firebase_uid",
       "email": "user@gmail.com",
       "name": "User Display Name",
       "phone": "",
       "avatarIndex": 0,
       "imageUrl": "https://google-profile-picture-url",
       "createdAt": "server_timestamp",
       "updatedAt": "server_timestamp"
     }
     ```
   - If RETURNING user → Profile unchanged (already exists)

5. **Navigation to Home** ✅
   - Success: `Navigator.pushReplacementNamed('/home')`
   - Displays welcome message on Home page

6. **Error Handling** ✅
   - If cancelled: Shows "Google sign-in cancelled"
   - If failed: Shows error message
   - User can retry

---

## 🔍 Verification Steps

### Test Locally (Before Firebase Setup):

```dart
// Log to verify flow
print('1. Google sign-in started');
print('2. Google credentials received');
print('3. Firestore profile created/checked');
print('4. Navigation to home triggered');
```

### Check Firestore After Sign-In:

1. Open [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Go to **Firestore Database**
4. Open **users** collection
5. Should see a new document with structure above

### Files Involved:

- **Data Layer**: `lib/features/login/data/datasources/remote_data_source.dart`
  - Method: `signInWithGoogle()`
  - Saves to Firestore `users/{uid}`

- **Repository**: `lib/features/login/data/repositories/login_repository_impl.dart`
  - Passes data through architecture

- **Use Case**: `lib/features/login/domain/usecases/login_usecase.dart`
  - `signInWithGoogle()` method

- **UI**: `lib/features/login/presentation/pages/login_page.dart`
  - Button connected to `_handleGoogleLogin()`
  - Navigation to `/home` on success

---

## 🔐 Required Firestore Security Rules

Update your Firestore rules to allow Google sign-in:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own user document
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }

    // Allow any authenticated user to write password reset codes
    match /password_reset_codes/{email} {
      allow write: if request.auth != null;
      allow read: if request.auth != null && request.auth.token.email == email;
    }
  }
}
```

**Where to Update:**

1. Firebase Console → Firestore Database
2. Click "Rules" tab
3. Paste the rules above
4. Click "Publish"

---

## ✅ Verification Checklist

Before testing, verify:

- [ ] Google Sign-In enabled in Firebase Console
- [ ] SHA-1 certificate added to Firebase (Android)
- [ ] Info.plist updated with Client ID (iOS)
- [ ] Firestore security rules updated (above)
- [ ] `google-services.json` exists in `android/app/`
- [ ] `Pod install` completed (iOS)
- [ ] `flutter pub get` completed

## 🧪 Testing Steps

1. **Run the app:**

   ```bash
   flutter run
   ```

2. **Click "Login With Google"**

3. **Select a Google account**

4. **Expected Result:**
   - ✅ Loading spinner shows
   - ✅ OAuth dialog appears
   - ✅ User selects account
   - ✅ Redirects to Home page
   - ✅ Welcome message displays

5. **Verify Firestore:**
   - Go to Firestore Database
   - Open `users` collection
   - New document created with user data

---

## 🐛 If It's Not Working

### Error: "Permission Denied"

- **Cause**: Firestore security rules not updated
- **Fix**: Update rules above and publish

### Error: "Google Sign-In Error"

- **Cause**: Firebase not configured for Google
- **Fix**: Enable Google in Firebase Console

### Error: "Sign-in cancelled"

- **Cause**: User clicked Cancel
- **Fix**: Normal behavior, try again

### Navigates to Home but No Data in Firestore

- **Cause**: Firestore rules might be blocking write
- **Fix**: Check security rules are published

### Data saved but profile picture not showing

- **Cause**: `photoURL` from Google is empty
- **Fix**: User needs to set photo on Google account

---

## 📊 What Gets Saved to Firestore

| Field       | Source                 | Example          |
| ----------- | ---------------------- | ---------------- |
| id          | Firebase UID           | `abc123xyz789`   |
| email       | Google account         | `user@gmail.com` |
| name        | Google display name    | `John Doe`       |
| phone       | Empty (can update)     | ``               |
| avatarIndex | Default                | `0`              |
| imageUrl    | Google profile picture | `https://...`    |
| createdAt   | Firestore timestamp    | Auto             |
| updatedAt   | Firestore timestamp    | Auto             |

---

## 📝 Code Flow Summary

```
User clicks "Login With Google"
    ↓
_handleGoogleLogin() → setState(isLoading=true)
    ↓
loginUseCase.signInWithGoogle()
    ↓
LoginRepositoryImpl.signInWithGoogle()
    ↓
FirebaseRemoteDataSource.signInWithGoogle()
    ├─ await _googleSignIn.signIn() → OAuth dialog
    ├─ await _firebaseAuth.signInWithCredential() → Firebase auth
    ├─ Check if user exists in Firestore
    ├─ If new: Save profile to users/{uid}
    └─ Return UserModel with token
    ↓
result.fold(failure → show error, success → navigate)
    ↓
Navigator.pushReplacementNamed('/home')
    ↓
Home page displays welcome message
```

---

## 🎯 Current Status

✅ **Code Implementation**: Complete  
✅ **Navigation**: Connected  
✅ **Firestore Save**: Implemented  
✅ **Loading State**: Working  
✅ **Error Handling**: Complete

⏳ **Pending**: Firebase Console & Platform Setup (follow GOOGLE_SIGNIN_SETUP.md)

---

## Next Steps

1. **Update Firestore security rules** (above)
2. **Test Google sign-in** locally
3. **Verify data in Firestore** after sign-in
4. **Check profile picture** displays on home page

If you see data in Firestore but photo doesn't show, that's because the home page needs to be updated to display the profile picture!

Would you like me to:

- [ ] Add profile picture display on home page?
- [ ] Add profile picture display on profile page?
- [ ] Update Firestore rules for you?
- [ ] Create a test account guide?
