import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> signOut ();
}
class Auth implements AuthBase {
  @override User? get currenUser => FirebaseAuth.instance.currentUser;

  @override Stream<User?> authStateChanges () => _firebaseAuth.authStateChanges();

  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User> signInWithGoogle () async {
    final googleSignIn = GoogleSignIn();
    //call google sign in method
    final googleUser = await googleSignIn.signIn();
    //request sign in from device to google
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      //get authentication of google
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        // pass idtoken and access token to firebase to sign in with google
        return userCredential.user!;
        //firebase return google account
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google ID Token');
        //throw exception when idtoken is null
      }
    } else {
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
      //can not sign in
    }
  }
  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final respronse = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    print("responese ${respronse.status}");
    switch (respronse.status) {
      case FacebookLoginStatus.success:
        final accessToken = respronse.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken!.token),
        );
        return userCredential.user!;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign In Abort By User',
        );

      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: "ERROR_FACEBOOK_LOGIN_FAILED",
          message: respronse.error!.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

}