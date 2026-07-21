import 'package:flutter/material.dart';
import 'login_screen.dart';

class ForgotpassScreen extends StatefulWidget {
  const ForgotpassScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotpassScreenState();
  }
}

class _ForgotpassScreenState extends State<ForgotpassScreen> {
  final _forgotpassFormKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _newConfirmPasswordController = TextEditingController();
  bool _hidenewPassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _forgotpassFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Image.asset("assets/images/logo.png", width: 160, height: 160),

                SizedBox(height: 24),

                Text(
                  'Reset Your Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 24),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Enter new Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidenewPassword = !_hidenewPassword;
                        });
                      },
                      icon: Icon(
                        _hidenewPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter valid paswword';
                    }
                    if (value.length < 8) {
                      return "Password needs to be 8 or more characters";
                    }
                    return null;
                  },
                  obscureText: _hidenewPassword,
                ),

                SizedBox(height: 26),

                TextFormField(
                  controller: _newConfirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hideConfirmPassword = !_hideConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _hideConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter valid password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: _hideConfirmPassword,
                ),

                SizedBox(height: 26),

                ElevatedButton(
                  onPressed: () {
                    if (_forgotpassFormKey.currentState!.validate()) {
                      //Perfom Forgot Password Navigate to Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Send', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
