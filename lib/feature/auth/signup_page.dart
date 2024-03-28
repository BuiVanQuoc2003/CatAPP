import 'package:catapp/config/validator.dart';
import 'package:catapp/feature/auth/widget/loading.dart';
import 'package:catapp/repository/user_repository.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;

  _signUp() {
    if (confirmPassWordController.text != passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password not match!'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      showLoadingDialog();
      UserRepository.instance
          .signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      )
          .then((value) {
        if (value != null) {
          hideLoadingDialog();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Sign up success!'),
              content: const Text(
                  'Please check your email and  verify your email address.'),
              actions: [
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Ok'),
                )
              ],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up'.toUpperCase(),
                  style: textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    validator: Validator.validator,
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ),
                TextFormField(
                  obscureText: hiddenPassword,
                  controller: passwordController,
                  validator: Validator.validator,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        hiddenPassword = !hiddenPassword;
                      }),
                      icon: Icon(!hiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    controller: confirmPassWordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          hiddenPassword = !hiddenPassword;
                        }),
                        icon: Icon(!hiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _signUp,
                    child: const Text('Sign up'),
                  ),
                ),
                Image.asset(
                  'assets/images/cat-logo.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
