import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget
{
  final void Function(String email,String password,String username,bool isLogin,BuildContext ctx) submitfunction;
  AuthForm(this.submitfunction);
  @override
  _AuthFormState createState() => _AuthFormState();

}
class _AuthFormState extends State<AuthForm>
{
  final _formkey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = "";
  String _password = "";
  String _username = "";

  void _submit()
  {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formkey.currentState.save();
      widget.submitfunction(
        _email.trim(),_password.trim(),_username.trim(),_isLogin,context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key:ValueKey('email'),
                  validator: (val){
                    if(val.isEmpty || !val.contains('@'))
                      {
                        return 'please enter a vaild email address';
                      }
                    return null;
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: " Email Address "),
                ),
                if(!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val){
                      if(val.isEmpty)
                        {
                          return 'please enter username';
                        }
                      return null;
                    },
                    onSaved: (val) => _username = val,
                    decoration: InputDecoration(labelText:'Username'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val){
                    if(val.isEmpty)
                      {
                        return 'please enter password';
                      }
                    return null;
                  },
                  onSaved: (val) => _password=val,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 12,),
                  RaisedButton(
                  child: Text(_isLogin ? 'Login' : 'Sign up'),
                  onPressed: _submit,
                ),
                  FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
                  onPressed: (){
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}