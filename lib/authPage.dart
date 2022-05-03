import 'package:flutter/material.dart';
// import 'package:de_app/login_page_upt.dart';
import 'loginPage.dart';
import 'signUp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin ? const LoginPage() : const SignUpPage();
}
