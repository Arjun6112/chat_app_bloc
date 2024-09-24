import 'package:chat_app_bloc/features/auth/models/user_model.dart';
import 'package:chat_app_bloc/features/auth/providers/user_provider.dart';
import 'package:chat_app_bloc/features/auth/screens/login_screen.dart';
import 'package:chat_app_bloc/features/home/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (snapshot.hasData) {
          // Get the current user from the snapshot
          User? user = snapshot.data;

          // If user is not null, update the UserModel
          if (user != null) {
            UserModel.instance.updateUser(
              uid: user.uid,
              email: user.email!,
              displayName: user.displayName!,
              photoURL: user.photoURL!,
            );

            Provider.of<UserProvider>(context, listen: false).setUser(UserModel.instance);
          }
          return const HomeScreen();
        }
        return const LoginScreen();
      },
    ));
  }
}
