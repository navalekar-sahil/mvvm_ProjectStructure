import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../res/components/button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final ValueNotifier<bool> _obscurePassword =ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authViewModel= Provider.of<AuthViewModel>(context);

    final height=MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.blue,title: Text("Login",style: TextStyle(color: Colors.white),),centerTitle: true,),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                label: Text('Email'),
                prefixIcon: Icon(Icons.alternate_email),
              ),
              onFieldSubmitted: (value){
                Util.changeFieldFocusNode(context: context, currentNode: emailFocusNode, nextFocus: passwordFocusNode);
              },
            ),

            SizedBox(height: 10,),

            ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword.value,
                    focusNode: passwordFocusNode,
                    obscuringCharacter: "*",
                    decoration:  InputDecoration(
                      hintText: 'Password',
                      label: Text('Password'),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                          child: Icon( _obscurePassword.value?Icons.visibility_off:Icons.visibility))
                    ),
                  );
                }
            ),
            
            SizedBox(height: height*0.05,),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.register);
              },
                child: Text("Dont have an account")),

            SizedBox(height: 10,),
            SizedBox(
                width:200,
                child: regulerButton(
                  text: "Login",
                  loading: authViewModel.isLoading,
                  onPressed: authViewModel.isLoading?null:() {
                    if(_emailController.text.isEmpty){
                      Util.flushBarErrorMessages(message: "please enter your email", context: context);
                      return;
                    }else if(_passwordController.text.isEmpty){
                      Util.flushBarErrorMessages(message: "please enter password", context: context);
                      return;
                    }else if(_passwordController.text.length<6){
                      Util.flushBarErrorMessages(message: "please enter 6 digit password", context: context);
                      return;
                    }else{
                      var data={
                        "email" : _emailController.text,
                        "password" :_passwordController.text
                      };

                      authViewModel.loginApi(data: data, context: context);
                    }

                  },
                )
            )

          ],
        ),
      ),
    );
  }
}
