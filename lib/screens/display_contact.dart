// ignore_for_file: library_private_types_in_public_api


import 'package:crudcontacts2/screens/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_constants.dart';
import '../model/contactmodel.dart';
import '../provider/contact_provider.dart';
import 'create_contacts.dart';
import 'edit_contacts.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
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
        automaticallyImplyLeading: false,
        title: const Text('User List'),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return userProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : userProvider.users.isEmpty
            ? const Center(
            child: Text(
              "Data Not Found",
              style: TextStyle(fontSize: 18),
            ))
            : Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              final user = userProvider.users[index];
              return InkWell(
                onTap: (){
                  _navigateToShowUser(context, user);
                },
                child: Card(
                  elevation: 3,
                  color: Colors.teal.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.email,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            user.desc,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),

                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     _navigateToEditUser(context, user);
                      //   },
                      // ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateUser(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateUser(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateUserScreen()),
    );
    setState(() {});
  }




  void _navigateToShowUser(BuildContext context, UserModel user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserViewScreen(user: user)),
    );
    setState(() {});
  }
}
