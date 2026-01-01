import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// AuthService
/// Central place for handling authentication logic
/// - Email/Password handled directly in UI screens
/// - Google Sign-In handled here (Web + Mobile)
class AuthService {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google Sign-In instance (used for mobile only)
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign in with Google (Web + Mobile support)
  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // 🌐 WEB: Use Firebase popup authentication
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        UserCredential userCredential = await _auth.signInWithPopup(
          authProvider,
        );

        return userCredential.user;
      } else {
        // 📱 MOBILE: Use GoogleSignIn package
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        // User canceled Google sign-in
        if (googleUser == null) return null;

        // Get authentication tokens
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create Firebase credential from Google tokens
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with Google credential
        UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        return userCredential.user;
      }
    } catch (e) {
      // Catch and log any Google sign-in errors
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  /// Sign out from Firebase and Google
  Future<void> signOut() async {
    await _auth.signOut();

    // Sign out from Google only on mobile
    if (!kIsWeb) {
      await _googleSignIn.signOut();
    }
  }

  /// Get currently authenticated user (null if logged out)
  User? get currentUser => _auth.currentUser;
}
