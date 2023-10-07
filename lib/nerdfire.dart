import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class NerdFire {
  static final NerdFire _instance = NerdFire._internal();
  factory NerdFire() {
    return _instance;
  }
  NerdFire._internal() {}
  void addBookData(String bookname, String number) {
    // Get a reference to the Firebase Realtime Database
    final databaseRef = FirebaseDatabase.instance.ref();

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw "User not logged in!";
    }
    // Push the data to the database
    databaseRef
        .child('${user!.uid}/$bookname')
        .set({"bookname": bookname, "number_pages": number});
  }

  Future<void> register(
      {required String username,
      required String email,
      required String password}) async {
    // Check if the username is already taken
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCredential.user?.updateDisplayName(username);
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> read_data(
      String username, String book_name) async {
    print("${username}/$book_name");
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('${username}/$book_name');
    DatabaseEvent event = await ref.once();
    final uswe = event.snapshot.value as Map<dynamic, dynamic>;
//final cover_url=book_cover_url(uswe['bookname'].toString());
    print("${uswe['number_pages']} ${uswe['bookname']}");
    return {"number_pages": uswe['number_pages'], "bookname": uswe['bookname']};
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
    } catch (e) {
      rethrow;
    }
  }
}
