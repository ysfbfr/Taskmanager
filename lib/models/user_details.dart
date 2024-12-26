import 'package:firebase_auth/firebase_auth.dart';

class UserDetails {
  final String uid;
  final String email;
  final String displayName;

  UserDetails(
      {required this.uid, required this.email, required this.displayName});

  // Factory method to parse from Firebase user data
  factory UserDetails.fromFirebaseUser(User user) {
    return UserDetails(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'No Name',
    );
  }
}
