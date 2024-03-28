import 'package:catapp/config/validator.dart';
import 'package:catapp/repository/user_repository.dart';
import 'package:flutter/material.dart';

import 'widget/loading.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _resetPassword() {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog();
      UserRepository.instance.resetPassword(emailController.text).then((value) {
        hideLoadingDialog();
        if (value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value),
            ),
          );
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Please check your email!'),
                  content: const Text(
                      'We have send email reset password for you, please check your email!'),
                  actions: [
                    OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    FilledButton(
                        onPressed: () => Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                        child: const Text('To sign in')),
                  ],
                );
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: Validator.validator,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: _resetPassword,
                    child: Text('Reset password'.toUpperCase())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
