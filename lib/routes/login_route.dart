import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nerdspace/b_nrsr.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';
var  username = "";
Future<bool> loginToFirebase(String username, String password) async {
  // Get a reference to the Firebase Realtime Database
   // Get a reference to the Firebase Realtime Database
  final databaseRef = FirebaseDatabase.instance.reference();

  // Check if the user exists in the database
  final snapshot = await databaseRef.child(username).once();
  final a=snapshot;
  print(a);
  final user = snapshot as Map<dynamic, dynamic>;
  print(user['password']);
  if (user != null && user['password'] == password) {
    return true; // Login successful
  } else {
    return false; // Login failed
  }
}
class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  late FocusNode userFocus, passwordFocus, enterFocus;
  @override
  void initState() {
    super.initState();
    userFocus = FocusNode();
    passwordFocus = FocusNode();
    enterFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
     final usernameController = TextEditingController();
    final pass = TextEditingController();
    ThemeData theme = Theme.of(context);
    return ImageBgScaffold(
      image: Image.asset('assets/fireplace-bg2k.jpg'),
      scaffold: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "Login",
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: usernameController,

                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                width: 5.0, color: theme.colorScheme.primary),
                          ),
                        ),
                        focusNode: userFocus,
                      ),
                      TextField(
                        controller: pass,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  width: 5.0,
                                  color: theme.colorScheme.primary)),
                        ),
                        focusNode: passwordFocus,
                      ),
                      ElevatedButton(
                        onPressed: () async {
var username = usernameController.text;
final password = pass.text;
DatabaseReference ref = FirebaseDatabase.instance.ref("${username}");
DatabaseEvent event = await ref.once();
final uswe=event.snapshot.value as Map<dynamic, dynamic>;
 // print(uswe['pass']+ " pass: ${password} user:${username} + ${uswe['user']}");
 /*
 if(uswe!=null){
  if(uswe['password']==password && uswe['username']==username){
print("login successful");
}
else{
  print(uswe['password']+ " ");
  print(pass);
  username=uswe['username'];
}
 }
 else{
   print("ref is null");
 }*/
 read_data(username, password);


                        },
                        child: Text("Login"),
                        focusNode: enterFocus,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text("Register instead?")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
