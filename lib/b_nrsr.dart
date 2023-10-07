import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> book_cover_url(String name) async {
  final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$name');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final book = data['items'][0]['volumeInfo'];
    final cover = book['imageLinks'] != null ? book['imageLinks']['thumbnail'] : null;

    return  cover;
  } else {
    throw Exception('Failed to load book info');
  } 
}
void sendDataToFirebase_(String username,String bookname,String number ) {
  // Get a reference to the Firebase Realtime Database
  final databaseRef = FirebaseDatabase.instance.reference();

  // Push the data to the database
  databaseRef.child('${username}/$bookname').set({
    "bookname": bookname,
    "number_pages": number
  });
}
Future<Map<String, dynamic>> read_data(String username, String book_name) async {
  print("${username}/$book_name");
  DatabaseReference ref = FirebaseDatabase.instance.ref('${username}/$book_name');
DatabaseEvent event = await ref.once();
final uswe=event.snapshot.value as Map<dynamic, dynamic>;
//final cover_url=book_cover_url(uswe['bookname'].toString());
print("${uswe['number_pages']} ${uswe['bookname']}") ;
return {"number_pages":uswe['number_pages'],"bookname":uswe['bookname']};
}

