import 'package:chat_app_bloc/features/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Bloc Chat',
              style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: isLoading ? 85 : 200,
              height: 50,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  foregroundColor: WidgetStateProperty.all(Colors.grey[800]),
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  AuthService().signInWithGoogle(context);
                },
                label: isLoading
                    ? const CupertinoActivityIndicator(
                        color: Colors.white,
                      )
                    : Text('Google Sign In',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                icon: Image.network(
                    height: 30,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/480px-Google_%22G%22_logo.svg.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
