# Firebase Integration Guide

This guide explains how to connect Firebase to your Flutter Movie App for authentication.

## ✅ What's Already Done

- ✅ Firebase Auth DataSource created
- ✅ Firebase Login Repository implemented
- ✅ Firebase initialization service
- ✅ Main.dart updated with Firebase init
- ✅ google-services.json added to Android

## 📋 Step 1: Get Firebase Configuration Files

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing
3. Enable Authentication (Email/Password)
4. Download configuration files:

### Android Setup

- Download `google-services.json` from Firebase Console
- Place in: `android/app/google-services.json` ✅ (Already added)

### iOS Setup

- Download `GoogleService-Info.plist` from Firebase Console
- Place in: `ios/Runner/GoogleService-Info.plist`
- Add to Xcode: Right-click Runner → Add Files

## 🔧 Step 2: Update Firebase Options

Update the file: `lib/firebase_options.dart`

```dart
static const android = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',           // From google-services.json
  appId: 'YOUR_APP_ID',               // From google-services.json
  messagingSenderId: 'YOUR_SENDER_ID', // From google-services.json
  projectId: 'YOUR_PROJECT_ID',      // From google-services.json
);
```

Find these values in your `google-services.json`:

- `apiKey` → Look for "current_key"
- `appId` → Look for "mobilesdk_app_id"
- `messagingSenderId` → "sender_id"
- `projectId` → "project_id"

## 📦 Step 3: Required Dependencies

Already added:

```yaml
firebase_core: ^2.0.0
firebase_auth: ^4.0.0
dartz: ^0.10.1
```

## 🚀 Step 4: How to Use Firebase Login

### In your Login Page:

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie/features/login/data/datasources/remote_data_source.dart';

// Initialize
final firebaseDataSource = FirebaseRemoteDataSource();

// Login
final result = await firebaseDataSource.login(email, password);

// Register
final result = await firebaseDataSource.register(email, username, password);

// Logout
await firebaseDataSource.logout();

// Get current user
final user = await firebaseDataSource.getCurrentUser();
```

### With BLoC:

```dart
final loginUseCase = LoginUseCase(
  LoginRepositoryImpl(FirebaseRemoteDataSource())
);

final loginBloc = LoginBloc(loginUseCase);
```

## 🔐 Firebase Console Setup

1. **Enable Email/Password Authentication**
   - Firebase Console → Authentication → Sign-in method
   - Enable Email/Password

2. **Create Test Users** (Optional)
   - Firebase Console → Authentication → Users
   - Add test users

3. **Security Rules** (For Firestore if using it)
   - Rules → Set appropriate access rules

## ✨ Features Included

✅ Email/Password Login
✅ User Registration
✅ Logout
✅ Automatic Error Handling
✅ Input Validation
✅ Firebase Error Messages
✅ Token Management

## 🐛 Common Errors & Solutions

| Error                         | Solution                                      |
| ----------------------------- | --------------------------------------------- |
| `FirebaseApp not initialized` | Call `FirebaseService.initialize()` in main() |
| `user-not-found`              | Email doesn't exist in Firebase               |
| `wrong-password`              | Incorrect password                            |
| `email-already-in-use`        | Email already registered                      |
| `weak-password`               | Password less than 6 characters               |

## 📝 File Structure

```
lib/
├── main.dart                          # Firebase initialization
├── firebase_options.dart              # Configuration (UPDATE THIS)
├── services/
│   └── firebase_service.dart         # Firebase init service
└── features/login/
    ├── data/
    │   ├── datasources/
    │   │   └── remote_data_source.dart   # Firebase Auth
    │   ├── models/
    │   │   └── user_model.dart
    │   └── repositories/
    │       └── login_repository_impl.dart
    ├── domain/
    │   ├── entities/user.dart
    │   ├── repositories/login_repository.dart
    │   └── usecases/
    │       ├── login_usecase.dart
    │       ├── register_usecase.dart
    │       └── logout_usecase.dart
    └── presentation/
        └── pages/
            └── login_page.dart
```

## 🔄 Next Steps

1. Update `firebase_options.dart` with your config
2. Test login/register functionality
3. Add error handling UI to login_page.dart
4. Implement user session persistence
5. Add password reset functionality

## 📚 Useful Resources

- [Firebase Flutter Documentation](https://firebase.flutter.dev/)
- [Firebase Authentication Docs](https://firebase.google.com/docs/auth)
- [Flutter Firebase Setup](https://firebase.flutter.dev/docs/overview)

---

**Questions?** Check Firebase console or Flutter Firebase docs.
