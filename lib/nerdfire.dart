import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';

class NerdFire {
  static final NerdFire _instance = NerdFire._internal();
  factory NerdFire() {
    return _instance;
  }
  NerdFire._internal() {}
  Future<void> addBookData(
      {required int numberofPages,
      required BookData bookData,
      required String status}) async {
    // Get a reference to the Firebase Realtime Database
    final databaseRef = FirebaseDatabase.instance.ref();

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw "User not logged in!";
    }
    // Push the data to the database
    await databaseRef
        .child('${user!.uid}/${bookData.title}')
        .set({"book_data": bookData.toJson(), "number_pages": numberofPages});
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

  Future<List<BookData>> getUserBookData() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) throw ("User not logged in!");
    return FirebaseDatabase.instance.ref('${user.uid}').get().then((snapshot) {
      print(snapshot.value);
      return (snapshot.value as Map<Object?, Object?>).values.map((e) {
        e = e as Map<Object?, Object?>;
        return BookData.fromJson(e['book_data'] as Map<Object?, Object?>);
      }).toList();
    });
  }

  Future<void> login(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User login successful
      print('User logged in successfully: ${userCredential.user!.uid}');
    } catch (e) {
      rethrow;
    }
  }
}
