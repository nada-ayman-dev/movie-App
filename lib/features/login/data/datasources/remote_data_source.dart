import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String username, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class FirebaseRemoteDataSource implements RemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseRemoteDataSource({firebase_auth.FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

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
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String username,
    String password,
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
