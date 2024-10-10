import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  void login(String email, password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        print("account created sucessfully");
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailcontroller,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordcontroller,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                login(_emailcontroller.text, _passwordcontroller.text);
              },
              child: Container(
                height: 50,
                width: 200,
                child: Center(child: Text("Sign In")),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
