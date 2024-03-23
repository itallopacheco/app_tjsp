import 'package:app_tjsp/app/views/login_page.dart';
import 'package:app_tjsp/app/views/register_page.dart';
import 'package:flutter/material.dart';

class SwitchLoginRegister extends StatefulWidget {
  const SwitchLoginRegister({super.key});

  @override
  State<SwitchLoginRegister> createState() => _SwitchLoginRegisterState();
}

class _SwitchLoginRegisterState extends State<SwitchLoginRegister> {
  // Demonstra a página de login inicialmente
  bool showLoginPage = true;

  void switchPages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        switchTap: switchPages,
      );
    } else {
      return RegisterPage(
        switchTap: switchPages,
      );
    }
  }
}
