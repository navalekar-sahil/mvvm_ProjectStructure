import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util{

  //toast messages
  static toastMessage({required String message,bool? isError=false} ){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: isError! ? Colors.red: Colors.grey.shade700,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  //flushBar
  static flushBarErrorMessages({required String message,required BuildContext context}){
    showFlushbar(context: context,
        flushbar: Flushbar(
          // forwardAnimationCurve: Curves.bounceIn,
          // reverseAnimationCurve: Curves.ease,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          message: message,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(8),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(Icons.error_outline,color: Colors.white,),
        )..show(context)
    );
  }

  //snack bar
  static snackBar({required String message, required BuildContext context}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          content: Text(message),
      )
    );
  }

  static changeFieldFocusNode({required BuildContext context, required FocusNode currentNode, required FocusNode nextFocus}){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}