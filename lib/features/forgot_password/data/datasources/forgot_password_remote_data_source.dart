import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:math';

abstract class ForgotPasswordRemoteDataSource {
  Future<String> sendPasswordResetEmail(String email);
}

class FirebaseForgotPasswordRemoteDataSource
    implements ForgotPasswordRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirebaseForgotPasswordRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      // Step 1: Verify email exists in Firestore users collection
      final userDoc = await _firestore.collection('users').doc(email).get();
      if (!userDoc.exists) {
        throw Exception('No user found with this email');
      }

      // Step 2: Generate random 6-digit code
      final random = Random();
      final code = (100000 + random.nextInt(900000)).toString();

      // Step 3: Save code to Firestore with expiration (10 minutes)
      await _firestore.collection('password_reset_codes').doc(email).set({
        'email': email,
        'code': code,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': DateTime.now().add(const Duration(minutes: 10)),
        'used': false,
      });

      // Step 4: Call Cloud Function to send email
      try {
        final callable = FirebaseFunctions.instance.httpsCallable(
          'sendPasswordResetEmail',
        );
        await callable.call({'email': email, 'code': code});
      } catch (e) {
        // If Cloud Function fails, still return code for testing
        print('Error calling Cloud Function: ${e.toString()}');
        print('Password reset code (for testing): $code');
      }

      return code;
    } catch (e) {
      throw Exception('Failed to send reset email: ${e.toString()}');
    }
  }
}
