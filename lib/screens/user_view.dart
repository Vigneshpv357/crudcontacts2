import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_constants.dart';
import '../model/contactmodel.dart';
import '../provider/contact_provider.dart';
import 'edit_contacts.dart';
class UserViewScreen extends StatefulWidget {
  final UserModel user;
  const UserViewScreen({super.key, required this.user});

  @override
  State<UserViewScreen> createState() => _USerViewScreenState();
}

class _USerViewScreenState extends State<UserViewScreen> {
  final userProvider =
  Provider.of<UserProvider>(AppConstants.globalNavKey.currentContext!);
  @override
  void initState() {
    // TODO: implement initState
    userProvider.loadUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider,_){
        return userProvider.users.isEmpty
            ? const Center(
            child: Text(
              "Data Not Found",
              style: TextStyle(fontSize: 18),
            ))
            : ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index){
              final user = userProvider.users[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Name:"),
                            Text(widget.user.name),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Email:"),
                            Text(widget.user.email),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Contact:"),
                            Text(widget.user.desc),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(onPressed: () {
                          _navigateToEditUser(context, user);
                        },
                          icon: Icon(Icons.edit_note_outlined),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(onPressed: () {
                          userProvider.deleteUser(user.id ?? 0);
                        },
                          icon: Icon(Icons.delete),),
                      )
                    ],
                  ),

                ],
              );
            });
      },),
    );
  }
  void _navigateToEditUser(BuildContext context, UserModel user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUserScreen(user: user)),
    );
    setState(() {});
  }
}
