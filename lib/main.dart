import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/auth_screen.dart';
import 'viewmodel/database_viewmodel.dart';
import 'viewmodel/auth_viewmodel.dart';

import 'viewmodel/local_storage_viewmodel.dart';
import 'view/show_delivery_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<LocalStorageViewModel>(
          create: (context) => LocalStorageViewModel(),
        ),
        ListenableProvider<AuthViewModel>(
          create: (context) => AuthViewModel(),
        ),
        ListenableProvider<DatabaseViewModel>(
          create: (context) => DatabaseViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Consumer<LocalStorageViewModel>(
        builder: (context, localStorageViewModel, _) => FutureBuilder<bool?>(
          future: localStorageViewModel.getUserAuthenticationStatus(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == false) {
              return const AuthScreen();
            }
            return const ShowDeliveryDetailsScreen();
          },
        ),
      ),
    );
  }
}
