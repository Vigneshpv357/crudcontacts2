import 'package:crudcontacts2/provider/contact_provider.dart';
import 'package:crudcontacts2/screens/display_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app_constants.dart';

void main() {
  sqfliteFfiInit();
  // Change the default factory
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: AppConstants.globalNavKey,
        debugShowCheckedModeBanner: false,
        home: UserListScreen(),
      ),
    );
  }
}

