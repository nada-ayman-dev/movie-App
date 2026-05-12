import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> register(
    String email,
    String username,
    String password,
    String phone,
    File? image,
    int avatarIndex,
  );
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class FirebaseRemoteDataSource implements RemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final GoogleSignIn _googleSignIn;

  FirebaseRemoteDataSource({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FirebaseStorage? firebaseStorage,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Login failed: User not found');
      }

      final token = await firebaseUser.getIdToken();

      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        username: firebaseUser.displayName ?? 'User',
        token: token,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      // Sign out previous Google session
      await _googleSignIn.signOut();

      // Trigger Google Sign-In
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in cancelled');
      }

      // Get Google authentication
      final googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Google sign-in failed: User not created');
      }

      // Check if user exists in Firestore, if not create profile
      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) {
        // Create new user profile
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'id': firebaseUser.uid,
          'email': firebaseUser.email ?? '',
          'name': firebaseUser.displayName ?? 'User',
          'phone': '',
          'avatarIndex': 0,
          'imageUrl': firebaseUser.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      final token = await firebaseUser.getIdToken();

      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        username: firebaseUser.displayName ?? 'User',
        token: token,
      );
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String username,
    String password,
    String phone,
    File? image,
    int avatarIndex,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Registration failed: User not created');
      }

      // Update user profile with username
      await firebaseUser.updateDisplayName(username);

      String? imageUrl;
      // Upload image to Firebase Storage if provided
      if (image != null) {
        try {
          final ref = _firebaseStorage.ref().child(
            'user_images/${firebaseUser.uid}/${DateTime.now().millisecondsSinceEpoch}',
          );
          await ref.putFile(image);
          imageUrl = await ref.getDownloadURL();
        } catch (e) {
          print('Image upload failed: $e');
          // Continue with signup even if image upload fails
        }
      }

      // Save user data to Firestore
      await _firestore.collection('users').doc(firebaseUser.uid).set({
        'id': firebaseUser.uid,
        'email': firebaseUser.email ?? email,
        'name': username,
        'phone': phone,
        'avatarIndex': avatarIndex,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      final token = await firebaseUser.getIdToken();

      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        username: username,
        token: token,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      final token = await firebaseUser.getIdToken();
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        username: firebaseUser.displayName ?? 'User',
        token: token,
      );
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with that email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'user-disabled':
        return 'User account has been disabled';
      case 'invalid-email':
        return 'Invalid email address';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
