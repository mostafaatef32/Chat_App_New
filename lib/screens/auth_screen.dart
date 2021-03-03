import 'package:flutter/material.dart';
import 'package:chat_application_new/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget
{
  @override
  _AuthScreenState createState() => _AuthScreenState();

}
class _AuthScreenState extends State<AuthScreen>
{
  void _submitAuthForm(String email,String password,String username,bool isLogin,BuildContext ctx)async
  {
    try {
      if(isLogin)
        {
          UserCredential authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password:password
          );
        }else
          {
            UserCredential authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password);
         await  FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
              'username' : username,
              'password' : password

            });
          }

    } on FirebaseAuthException catch (e) {
      String message = 'error Ocurred';

      if (e.code == 'weak-password') {
        message= 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message='The account already exists for that email';
      }else if (e.code == 'user-not-found') {
        message='No user found for that email';
      } else if (e.code == 'wrong-password') {
        message='Wrong password provided for that user';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message) , backgroundColor: Theme.of(ctx).errorColor,));
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm ),
    );
  }
  
}