import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

final back="https://i.pinimg.com/736x/e4/e8/88/e4e8883588ab25519e03217a7e51ebfa.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(back),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 350,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildEmailField(),
                    _buildPasswordField(),
                    _buildLoginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Center(
  //         child: SingleChildScrollView(
  //           padding: const EdgeInsets.all(24),
  //           child: SizedBox(
  //             width: 350,
  //             child: Form(
  //               key: _formKey,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   _buildEmailField(),
  //                   _buildPasswordField(),
  //                   _buildLoginButton(),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _emailCtrl,
        enabled: true,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter your email',
          prefixIcon: Icon(Icons.email),
        ),
        validator: (text) {
          if (text == null || text.trim().isEmpty) {
            return 'Please enter your email';
          }
          if (!text.contains('@')) return 'Invalid email format';
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _passCtrl,
        enabled: true,
        obscureText: _hidePassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Enter password',
          prefixIcon: const Icon(Icons.key),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
            icon: Icon(
              _hidePassword ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        validator: (text) {
          if (text == null || text.isEmpty) return 'Password is required';
          if (text.length < 6) return 'Password must be at least 6 characters';
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
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            // Login logic goes here.
          }
        },
      ),
    );
  }
}
 
