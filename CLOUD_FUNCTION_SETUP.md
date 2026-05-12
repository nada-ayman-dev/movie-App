# Firebase Cloud Function Setup - Send Password Reset Emails

## Overview

This guide helps you set up a Firebase Cloud Function to send 6-digit password reset codes via email.

## Step 1: Install Firebase CLI (if not already installed)

```bash
npm install -g firebase-tools
```

## Step 2: Initialize Firebase Functions in your project

Navigate to your project directory and initialize Functions:

```bash
firebase init functions
```

Choose:

- Select your Firebase project
- Choose JavaScript (or TypeScript)
- Install dependencies: Yes

## Step 3: Set Up Email Service

### Option A: Using SendGrid (Recommended)

1. Go to [SendGrid](https://sendgrid.com) and create a free account
2. Get your API key from SendGrid dashboard
3. Set the environment variable in Firebase:

```bash
firebase functions:config:set sendgrid.api_key="your-sendgrid-api-key"
```

4. Update the Cloud Function to use the environment variable:

```javascript
const nodemailer = require("nodemailer");
const transporter = nodemailer.createTransport({
  host: "smtp.sendgrid.net",
  port: 587,
  auth: {
    user: "apikey",
    pass: functions.config().sendgrid.api_key,
  },
});
```

### Option B: Using Gmail

1. Enable 2-Step Verification on your Gmail account
2. Create an [App Password](https://myaccount.google.com/apppasswords)
3. Set the environment variable:

```bash
firebase functions:config:set gmail.email="your-email@gmail.com"
firebase functions:config:set gmail.password="your-app-password"
```

## Step 4: Install Dependencies

Edit `functions/package.json` and add:

```json
{
  "dependencies": {
    "firebase-functions": "^4.4.1",
    "firebase-admin": "^12.0.0",
    "nodemailer": "^6.9.7"
  }
}
```

Then run:

```bash
cd functions
npm install
```

## Step 5: Update Cloud Function

Replace the content of `functions/index.js` with the provided `sendPasswordResetEmail.js` code.

Make sure to update the `from` email address in the mailOptions.

## Step 6: Deploy the Function

```bash
firebase deploy --only functions
```

This will deploy the `sendPasswordResetEmail` Cloud Function.

## Step 7: Test the Function

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Navigate to Cloud Functions
3. Click on `sendPasswordResetEmail`
4. Go to the "Testing" tab
5. Add test data:

```json
{
  "email": "test@example.com",
  "code": "123456"
}
```

6. Click "Run"

## Step 8: Enable in Firebase Console

1. Go to Firebase Console
2. Cloud Functions → sendPasswordResetEmail
3. Make sure it's enabled

## Firestore Security Rules Update

Update your Firestore rules to allow this function to work:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own user document
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }

    // Allow authenticated users to read/write password reset codes for their email
    match /password_reset_codes/{email} {
      allow write: if request.auth != null;
      allow read: if request.auth != null && request.auth.token.email == email;
    }
  }
}
```

## Troubleshooting

### "Email sent successfully" but no email received

- Check spam/junk folder
- Verify the email address is correct
- Check SendGrid/Gmail dashboard for bounce messages

### "Function failed to deploy"

- Ensure all dependencies are installed: `npm install`
- Check for syntax errors in JavaScript
- Verify Firebase project is selected: `firebase use --add`

### "Permission denied" error

- Update Firestore security rules (see above)
- Ensure user is authenticated before calling function

## Environment Variables

If using secrets, use [Firebase Secrets Manager](https://cloud.google.com/secret-manager/docs/managing-secrets):

```bash
gcloud secrets create sendgrid-api-key --replication-policy="automatic" --data-file=- <<< "your-api-key"

firebase functions:secrets:create SENDGRID_API_KEY
```

Then access in function:

```javascript
const SENDGRID_API_KEY = process.env.SENDGRID_API_KEY;
```

## Testing from Flutter

The Flutter code will automatically call this function when the user clicks "Verify Email":

1. User enters email → clicks "Verify Email"
2. Flutter generates 6-digit code
3. Code is saved to Firestore
4. Cloud Function is called automatically
5. Email is sent to user's inbox
6. 6-digit code displays in dialog (for debugging)

## Next Steps

After email is successfully sent:

1. Create a "Verify Code" screen where user enters the 6-digit code
2. Validate the code against Firestore `password_reset_codes` collection
3. Create a "Reset Password" screen to set new password
4. Mark the code as used (set `used: true` in Firestore)
