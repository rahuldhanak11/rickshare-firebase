import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  }

   Future<void> createUserwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
  }
}
