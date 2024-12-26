import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/models/user_details.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user
  Future<User?> registerUser(String email, String password) async {
    try {
      // Attempt to create a new user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Return the user details if registration is successful
      return userCredential.user;
    } catch (e) {
      // Handle errors during registration
      print('Error registering user: $e');
      return null;
    }
  }

  // Log in an existing user
  Future<User?> loginUser(String email, String password) async {
    try {
      // Attempt to sign in the user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Return the user details if login is successful
      return userCredential.user;
    } catch (e) {
      // Handle errors during login
      print('Error logging in user: $e');
      return null;
    }
  }

  // Fetch user details from Firebase
  Future<UserDetails?> fetchUserDetails() async {
    // Get the currently logged-in user
    User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      // If a user is logged in, return their details using a custom UserDetails model
      return UserDetails.fromFirebaseUser(firebaseUser);
    } else {
      // If no user is logged in, print a message and return null
      print('No user is logged in');
      return null;
    }
  }

  // Log out the current user
  Future<void> logout() async {
    try {
      // Sign out the current user
      await _auth.signOut();
      print('User logged out');
    } catch (e) {
      // Handle errors during logout
      print('Error logging out user: $e');
    }
  }
}
