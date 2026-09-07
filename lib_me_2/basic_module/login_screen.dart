import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding = 0;
    final max = 600;
    if (width > max) {
      padding = (width - max) / 2;
    } else {
      padding = 0;
    }

    final back =
        "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2020/07/trendy-background-ideas-cover.jpg";

    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(image: NetworkImage(back), fit: .cover),
        // ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailTextField(),
                    _buildPasswordTextField(),
                    _buildButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final _emailCtrl = TextEditingController();

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _emailCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Email",
          prefixIcon: Icon(Icons.email),
        ),
        keyboardType: .emailAddress,
        textInputAction: .next,
        validator: (text) {
          if (text!.isEmpty) {
            return "Email is required";
          }
          if (EmailValidator.validate(text) == false) {
            return "Email format is not correct";
          }
          return null; // no error
        },
      ),
    );
  }

  final _passCtrl = TextEditingController();

  bool _hidePassword = true;

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Password",
          prefixIcon: Icon(Icons.key),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
            icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        textInputAction: .next,
        obscureText: _hidePassword,
        validator: (text) {
          if (text!.isEmpty) {
            return "Password is required";
          }
          if (text.length < 6) {
            return "Password length must be at 6 characters";
          }
          return null; // no error
        },
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: 300,
      child: FilledButton.icon(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_emailCtrl.text.toLowerCase().trim() == "kosal@gmail.com" &&
                _passCtrl.text.trim() == "123456") {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          }
        },
        label: Text("LOGIN"),
        icon: Icon(Icons.login),
      ),
    );
  }
}
