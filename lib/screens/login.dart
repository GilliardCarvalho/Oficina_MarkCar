import 'package:flutter/cupertino.dart';
import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9FAFD),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(CupertinoIcons.wrench, size: 76),
              const SizedBox(height: 12),
              const Center(child: Text("Mark Car", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800))),
              const SizedBox(height: 36),
              _input("Email", emailCtrl, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _input("Senha", passCtrl, obscureText: true),
              const SizedBox(height: 28),
              primaryButton("Entrar", onPressed: () {
                Navigator.of(context).pushReplacementNamed("/home");
              }),
              const SizedBox(height: 14),
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Text("Esqueceu a senha?", style: TextStyle(color: CupertinoColors.black)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Text("Criar conta", style: TextStyle(color: kPrimaryBlue, fontSize: 20, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(String placeholder, TextEditingController c, {bool obscureText = false, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE1E6EF)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CupertinoTextField(
        controller: c,
        placeholder: placeholder,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: const BoxDecoration(color: CupertinoColors.white),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}