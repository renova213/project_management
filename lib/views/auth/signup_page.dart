// ignore_for_file: prefer_const_constructors

import 'package:final_project/models/auth/register_model.dart';
import 'package:final_project/succes_register.dart';
import 'package:final_project/view_models/auth_view_model.dart';
import 'package:final_project/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "Register",
                style: GoogleFonts.urbanist(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(4),
              child: Text(
                "Please Fill the Form",
                style: GoogleFonts.urbanist(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'First Name',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Last Name',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Username',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Email',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Phone Number',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Password',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: _confirmpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Confirm Password',
                  labelStyle: GoogleFonts.urbanist(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Consumer<AuthViewModel>(
                builder: (context, auth, _) => ElevatedButton(
                  onPressed: () async {
                    try {
                      await auth
                          .registerRequest(
                            RegisterModel(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                username: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneNumberController.text,
                                password: _passwordController.text,
                                passwordConfirmation:
                                    _confirmpasswordController.text),
                          )
                          .then(
                            (_) => Fluttertoast.showToast(
                                msg: "Berhasil Register"),
                          )
                          .then(
                            (_) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccesRegister(),
                              ),
                            ),
                          );
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  child: Text(
                    'REGISTER',
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.urbanist(),
                ),
                TextButton(
                  onPressed: () {
                    // LogIn Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
