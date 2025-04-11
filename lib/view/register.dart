import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/res/components/button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  ValueNotifier<bool> _obscurePassword =ValueNotifier<bool>(false);

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
      appBar: AppBar(backgroundColor:Colors.blue,foregroundColor: AppColors.white,title: Text("Register",style: TextStyle(color: Colors.white),),centerTitle: true,),
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
                  Navigator.pop(context);
                },
                child: Text("Already have an account")),

            SizedBox(height: 10,),
            SizedBox(
                width:200,
                child: regulerButton(
                  text: "Sign Up",
                  loading: authViewModel.isSignUpLoading,
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

                      authViewModel.register(data: data, context: context);
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
