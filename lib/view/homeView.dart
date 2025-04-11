import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/userSession.dart';
import 'package:mvvm/utils/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            UserSessionManager.clearToken();
            Util.toastMessage(message: "Logout Successfully");
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.login,(route) => false,);
          }, child: Text("Log Out"))
        ],
      ),
      body: const Center(
        child: Text("greeting from home screen"),
      ),
    );
  }
}
