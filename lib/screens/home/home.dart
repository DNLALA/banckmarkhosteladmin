// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:banckmarkhosteladmin/screens/main/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../api/base.dart';
import '../../componets/TextFields/BaseText.dart';
import '../../componets/botton/SubmitBotton.dart';
import '../../services/Token.dart';
import '../warden/newWarden.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final List<String> imagePaths = [
    'assets/bspbg.jpg',
    'assets/hostelrooms.jpg',
  ];

  int currentPage = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _getUserdetale();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        currentPage = (currentPage + 1) % imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _getUserdetale() async {
    var box = await Hive.openBox(tokenBox);
    String? token = box.get('token');

    if (token != null) {
      await getUserdata(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: imagePaths.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            imagePaths[index],
                            fit: BoxFit.cover,
                            width: screenWidth,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            imagePaths.length,
                            (index) => Container(
                              width: 10.0,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPage == index
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                'Benchmark Hostel',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hostel Management System',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
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
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubmitButton(
                  buttonText: "Login",
                  textColor: Colors.white,
                  onPressed: () {
                    _wardenLogin();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Don't have an account "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewWarden(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register here',
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
      ),
    );
  }

  void _wardenLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // setState(() {
    //   _isLoading = true;
    // });
    showDialog(
        context: context,
        builder: (c) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 160, 98, 160),
            ),
          );
        });

    var result = await wardenLogin(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      // _isLoading = false;
    });

    if (result is String && result == _emailController.text) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $result'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
