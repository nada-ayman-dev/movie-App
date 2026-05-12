// Firebase Cloud Function to send password reset code via email
// Deploy this function to Firebase Cloud Functions

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

// Initialize Firebase Admin SDK
admin.initializeApp();

// Configure your email service
// Option 1: Using Gmail (requires App Password)
// const transporter = nodemailer.createTransport({
//   service: 'gmail',
//   auth: {
//     user: 'your-email@gmail.com',
//     pass: 'your-app-password' // Use App Password, not regular password
//   }
// });

// Option 2: Using SendGrid (recommended)
const transporter = nodemailer.createTransport({
  host: 'smtp.sendgrid.net',
  port: 587,
  auth: {
    user: 'apikey',
    pass: process.env.SENDGRID_API_KEY // Set this in Firebase Cloud Functions environment variables
  }
});

// Cloud Function to send password reset email
exports.sendPasswordResetEmail = functions.https.onCall(async (data, context) => {
  const { email, code } = data;

  // Validate input
  if (!email || !code) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Email and code are required'
    );
  }

  try {
    // Email options
    const mailOptions = {
      from: 'noreply@movieapp.com', // Change this to your email
      to: email,
      subject: 'Password Reset Code - Movie App',
      html: `
        <!DOCTYPE html>
        <html>
          <head>
            <style>
              body { font-family: Arial, sans-serif; background-color: #f5f5f5; }
              .container { max-width: 600px; margin: 0 auto; background-color: white; padding: 20px; border-radius: 8px; }
              .header { text-align: center; color: #f6bd00; margin-bottom: 20px; }
              .code-box { 
                background-color: #1a1a1a; 
                color: #f6bd00; 
                padding: 20px; 
                text-align: center; 
                border-radius: 8px;
                border: 2px solid #f6bd00;
                margin: 20px 0;
              }
              .code-text { font-size: 32px; font-weight: bold; letter-spacing: 4px; }
              .message { color: #333; line-height: 1.6; }
              .footer { text-align: center; color: #999; font-size: 12px; margin-top: 20px; }
            </style>
          </head>
          <body>
            <div class="container">
              <div class="header">
                <h1>Password Reset Code</h1>
              </div>
              <div class="message">
                <p>Hello,</p>
                <p>We received a request to reset your password. Use the 6-digit code below to reset your password:</p>
              </div>
              <div class="code-box">
                <div class="code-text">${code}</div>
              </div>
              <div class="message">
                <p><strong>Important:</strong> This code will expire in 10 minutes.</p>
                <p>If you didn't request a password reset, please ignore this email.</p>
              </div>
              <div class="footer">
                <p>&copy; 2026 Movie App. All rights reserved.</p>
              </div>
            </div>
          </body>
        </html>
      `
    };

    // Send email
    await transporter.sendMail(mailOptions);

    // Log success
    console.log(`Password reset email sent to ${email}`);

    return {
      success: true,
      message: 'Email sent successfully'
    };
  } catch (error) {
    console.error('Error sending email:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to send email: ' + error.message
    );
  }
});
