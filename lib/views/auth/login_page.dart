import 'package:final_project/models/auth/login_model.dart';
import 'package:final_project/utils/navigator_helper.dart';
import 'package:final_project/view_models/auth_view_model.dart';
import 'package:final_project/views/auth/signup_page.dart';
import 'package:final_project/views/widgets/botnavbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              "Login",
              style: GoogleFonts.urbanist(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              "Login to your account",
              style: GoogleFonts.urbanist(
                color: Colors.black45,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Your Email',
                labelStyle: GoogleFonts.urbanist(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Your Password',
                labelStyle: GoogleFonts.urbanist(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Consumer<AuthViewModel>(
              builder: (context, auth, _) => ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Form tidak boleh kosong");
                  } else {
                    try {
                      await auth
                          .loginRequest(
                            LoginModel(
                                email: _emailController.text,
                                password: _passwordController.text),
                          )
                          .then(
                            (_) =>
                                Fluttertoast.showToast(msg: "Login Berhasil"),
                          )
                          .then(
                            (_) => Navigator.of(context).pushAndRemoveUntil(
                                NavigatorHelper(child: const BotNavBar()),
                                (route) => false),
                          );
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            "assets/images/logo.png",
            width: 200,
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Doesn't have an account?",
                style: GoogleFonts.urbanist(
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Sign Up Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPage(),
                    ),
                  );
                },
                child: Text(
                  'Register Now',
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Row(
            // ignore: sort_child_properties_last
            children: <Widget>[
              Text(
                "Forgot Password?",
                style: GoogleFonts.urbanist(
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Sign Up Page
                },
                child: Text(
                  'Sent Now',
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
