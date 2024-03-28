import 'package:catapp/config/validator.dart';
import 'package:catapp/feature/auth/forget_password_page.dart';
import 'package:catapp/feature/auth/signup_page.dart';
import 'package:catapp/feature/auth/widget/loading.dart';
import 'package:catapp/feature/home/home_page.dart';
import 'package:catapp/repository/user_repository.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;
  _signIn() async {
    // kiểm tra xem form đã điền chưa
    // đã điền thì mới thực hiện xử lý đăng nhập
    if (_formKey.currentState!.validate()) {
      showLoadingDialog();
      UserRepository.instance
          .signIn(emailController.text.trim(), passwordController.text.trim())
          .then((value) {
        hideLoadingDialog();
        if (value is String) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const HomePage(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/cat-logo.png',
                      width: screenWidth / 2,
                    ),
                    Text(
                      'Sign in'.toUpperCase(),
                      style: textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: Validator.validator,
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
                      // update lại trang thái ẩn hiện của password
                      onPressed: () => setState(() {
                        hiddenPassword = !hiddenPassword;
                      }),
                      icon: Icon(!hiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordPage(),
                      ),
                    ),
                    child: const Text('For get password ?'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _signIn,
                    child: const Text('Sign in'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Or',
                style: textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have account?',
                  style: textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  ),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
