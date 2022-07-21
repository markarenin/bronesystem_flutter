import 'package:bronesystem/ui/page/login_page.dart';
import 'package:bronesystem/ui/widgets/SafeContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authprovider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AuthProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paul Kerese 14',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: context.watch<AuthProvider>().loggedInStatus == Status.notLoggedIn ? LoginPage() : Container(decoration: BoxDecoration(color: Colors.red,)),
    );
  }
}
