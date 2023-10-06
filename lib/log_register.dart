import 'package:firebase_auth/firebase_auth.dart';

Future<void> register(String username, String password) async {
  try {
    // Check if the username is already taken
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: '$username@myapp.com',
      password: password,
    );
    // User registration successful
    print('User registered successfully: ${userCredential.user!.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      // Username is already taken
      print('Username is already taken');
    } else {
      // Other registration errors
      print('Error registering user: $e');
    }
  } catch (e) {
    // Other errors
    print('Error registering user: $e');
  }
}

Future<void> login(String username, String password) async {
  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: '$username@myapp.com',
      password: password,
    );
    // User login successful
    print('User logged in successfully: ${userCredential.user!.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      // Invalid username or password
      print('Invalid username or password');
    } else {
      // Other login errors
      print('Error logging in user: $e');
    }
  } catch (e) {
    // Other errors
    print('Error logging in user: $e');
  }
}
