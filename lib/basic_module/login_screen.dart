import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({super.key});
  
  final _formKey = GlobalKey<FormState>();

  
 @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding = 0;
    final max = 600;
    if(width > max){
      padding = (width - max) / 2;
    }
    else{
      padding = 0;
    }

  return Scaffold(
    body: Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 24),
            _buildLoginButton(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildEmailField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter your email',
      prefixIcon: Icon(Icons.email),
    ),

    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    validator: (text) {
      if (text?.isEmpty == true) {  
        return 'Please enter your email';
      }
      if(!EmailValidator.validate(text!)){
        return 'Invalid email format';
      }
      return null;
    },
    ),
  );
}

Widget _buildPasswordField() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter your password',
      prefixIcon: Icon(Icons.lock),
    ),

    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    obscureText: true,
    validator: (text) {
      if (text?.isEmpty == true) {  
        return 'Please enter your password';
      }
      if(text?.length == null || text!.length < 6){ 
        return 'password length must be at least 6 characters';
      }
      return null;
    },
    ),
  );
}

Widget _buildLoginButton() {
  return SizedBox(
    width: 300,
    child: FilledButton.icon(
      icon: const Icon(Icons.login),
      label: const Text('Login'),
      style: FilledButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
    onPressed: () {
        if (_formKey.currentState?.validate() == true) {
        // Login logic
      }
    },
    ),
  );
} 
}