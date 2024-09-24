import 'package:chat_app_bloc/features/auth/models/user_model.dart';
import 'package:chat_app_bloc/features/auth/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId:
                "129176526505-4kk6fp3ju20ca3bsuosrdchq91e55a3e.apps.googleusercontent.com")
        .signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    print(googleUser.photoUrl);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // Get the signed-in user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Create a UserModel with the user information
      final userModel = UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
        photoUrl: user.photoURL!,
      );

      // Update the UserProvider with the new user information
      Provider.of<UserProvider>(context, listen: false).setUser(userModel);
    }
  }
}
