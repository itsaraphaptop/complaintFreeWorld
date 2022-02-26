import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ComplaintNewFirebaseUser {
  ComplaintNewFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ComplaintNewFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ComplaintNewFirebaseUser> complaintNewFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ComplaintNewFirebaseUser>(
            (user) => currentUser = ComplaintNewFirebaseUser(user));
