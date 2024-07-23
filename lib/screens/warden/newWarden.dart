// ignore_for_file: use_build_context_synchronously

import 'package:banckmarkhosteladmin/api/base.dart';
import 'package:banckmarkhosteladmin/componets/botton/SubmitBotton.dart';
import 'package:banckmarkhosteladmin/componets/TextFields/BaseText.dart';
import 'package:banckmarkhosteladmin/screens/home/home.dart';
import 'package:flutter/material.dart';

class NewWarden extends StatefulWidget {
  const NewWarden({Key? key}) : super(key: key);

  @override
  _NewWardenState createState() => _NewWardenState();
}

class _NewWardenState extends State<NewWarden> {
  late TextEditingController _nameController;
  late TextEditingController _regController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _regController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _regController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 160, 98, 160),
            ),
          );
        });

    // Implement your registration logic here
    String name = _nameController.text;
    String regNo = _regController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Example validation and registration logic
    if (name.isNotEmpty &&
        regNo.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      var result = await wardenReg(email, password, name, regNo);
      if (result is String && result == email) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reg successful'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reg failed: $result'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey, // Assign scaffoldKey to Scaffold
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Warden Registration",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenSize.height * 0.3,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/warden.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _nameController,
                hintText: 'Name',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _regController,
                hintText: 'Reg No',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubmitButton(
                buttonText: "Register",
                textColor: Colors.white,
                onPressed: () {
                  _registerUser();
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          context); // Navigate back to previous screen
                    },
                    child: const Text(
                      'Login here',
                      style: TextStyle(
                        color: Color.fromARGB(255, 160, 98, 160),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
