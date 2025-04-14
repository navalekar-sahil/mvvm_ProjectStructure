import 'package:flutter/material.dart';
import 'package:mvvm/model/usersModel.dart';
import 'package:mvvm/view_model/home_view_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewViewModel>(context, listen: false);

    homeViewModel.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<HomeViewViewModel>(
              builder: (context, value, child) {
        
                if (value.usersData.status == Status.LOADING) {
                  return const Center(child: CircularProgressIndicator());
        
                } else if (value.usersData.status == Status.ERROR) {
                  return Center(child: Text(value.usersData.message.toString()));
        
                } else if (value.usersData.status == Status.COMPLETED) {
        
                  List<Data>? usersList = value.usersData.data?.data;
        
                  if (usersList == null || usersList.isEmpty) {
                    return const Center(child: Text('No data found'));
                  }
                  Consumer<HomeViewViewModel>(
                    builder: (context, value, child) {

                      if (value.usersData.status == Status.LOADING) {
                        return const Center(child: CircularProgressIndicator());

                      } else if (value.usersData.status == Status.ERROR) {
                        return Center(child: Text(value.usersData.message.toString()));

                      } else if (value.usersData.status == Status.COMPLETED) {

                        List<Data>? usersList = value.usersData.data?.data;

                        if (usersList == null || usersList.isEmpty) {
                          return const Center(child: Text('No data found'));
                        }

                        return Column(
                          children: usersList.map((user) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatar ?? ''),
                            ),
                            title: Text(user.firstName ?? ''),
                            subtitle: Text(user.email ?? ''),
                          )).toList(),

                        );
                      } else {
                        return const Center(child: Text('Something went wrong'));
                      }
                    },
                  );
                  return Column(
                    children: [
                      for(int index =0; index< usersList.length;index++)
                   ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usersList[index].avatar ?? ''),
                    ),
                    title: Text('${usersList[index].firstName} ${usersList[index].lastName}'),
                    subtitle: Text(usersList[index].email ?? ''),
                  )
                    ],
                  );
        

                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),
        
        
            Consumer<HomeViewViewModel>(
              builder: (context, value, child) {
        
                if (value.usersData.status == Status.LOADING) {
                  return const Center(child: CircularProgressIndicator());
        
                } else if (value.usersData.status == Status.ERROR) {
                  return Center(child: Text(value.usersData.message.toString()));
        
                } else if (value.usersData.status == Status.COMPLETED) {
        
                  List<Data>? usersList = value.usersData.data?.data;
        
                  if (usersList == null || usersList.isEmpty) {
                    return const Center(child: Text('No data found'));
                  }
        
                  return Column(
                    children: usersList.map((user) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar ?? ''),
                      ),
                      title: Text(user.firstName ?? ''),
                      subtitle: Text(user.email ?? ''),
                    )).toList(),

                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
