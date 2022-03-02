import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ComplaintFirebaseUser {
  ComplaintFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ComplaintFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ComplaintFirebaseUser> complaintFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ComplaintFirebaseUser>(
        (user) => currentUser = ComplaintFirebaseUser(user));
