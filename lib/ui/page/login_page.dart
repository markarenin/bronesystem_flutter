import 'dart:convert';

import 'package:bronesystem/authprovider.dart';
import 'package:bronesystem/ui/widgets/SafeContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  String? nameErrorText;
  String? apartmentErrorText;

  void apartmentValidator(String text) {
    if (text.isEmpty) {
      setState(() {
        apartmentErrorText = null;
      });
      return;
    }
    int apartment = int.parse(text);
    print(apartment);
    if (apartment < 200 || apartment > 418) {
      setState(() {
        apartmentErrorText = "Apartment number can be only greater than 200 and lower than 418";
      });
    } else if (apartmentErrorText != null) {
      setState(() {
        apartmentErrorText = null;
      });
    }
  }

  void auth() {
    if (_nameController.text.length < 4 || !_nameController.text.contains(' ')) {
      setState(() {
        nameErrorText = "Enter your first and second name";
      });
      return;
    } else {
      setState(() {
        nameErrorText = null;
      });
    }
    if (apartmentErrorText != null || _apartmentController.text.isEmpty) {
      return;
    }

    context.read<AuthProvider>().login(_nameController.text, int.parse(_apartmentController.text));
  }

  @override
  void initState() {
    _apartmentController.addListener(() => apartmentValidator(_apartmentController.text));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeContainer(
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          const Text("Authorize"),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(errorText: nameErrorText),
          ),
          TextField(
            controller: _apartmentController,
            maxLength: 3,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(errorText: apartmentErrorText),
          ),
          ElevatedButton(onPressed: () => auth(), child: Text("Auth")),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    ));
  }
}
