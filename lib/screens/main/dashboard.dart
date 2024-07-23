import 'package:banckmarkhosteladmin/models/issue.dart';
import 'package:banckmarkhosteladmin/screens/main/requestscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/base.dart';
import '../../services/Token.dart';
import '../hotsel/reports.dart';
import '../profile/profile.dart';
import '../room/roomlist.dart';
import '../warden/allstudents.dart';
import 'issuescreen.dart';
import 'transfarscreen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Future<String?> _username;

  @override
  void initState() {
    super.initState();
    _username = _getUsername();
  }

  Future<String?> _getUsername() async {
    var box = await Hive.openBox(tokenBox);
    String token = box.get('token');
    getUserdata(token);
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 80.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTimeBasedGreeting(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            FutureBuilder<String?>(
                              future: _username,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Text(
                                    'Error loading username',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data ?? 'No username found',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person_2_rounded,
                              size: 40,
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Warden Dashboard',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildDashboardCard(
                      context,
                      'Room Management',
                      'assets/student.jpeg',
                      () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RoomManagement(),
                          ),
                        );
                      },
                    ),
                    buildDashboardCard(
                      context,
                      'All Issues',
                      'assets/student.jpeg',
                      () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IssuesScreen(),
                          ),
                        );
                      },
                    ),
                    buildDashboardCard(
                      context,
                      'Transfer Requests',
                      'assets/student.jpeg',
                      () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TransfarScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildDashboardCard(
                      context,
                      'Maintenance Requests',
                      'assets/student.jpeg',
                      () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RequestScreen(),
                          ),
                        );
                      },
                    ),
                    buildDashboardCard(
                      context,
                      'Student Records',
                      'assets/student.jpeg',
                      () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HostelListScreen(),
                          ),
                        );
                      },
                    ),
                    buildDashboardCard(
                      context,
                      'Reports',
                      'assets/student.jpeg',
                      () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDashboardCard(
      BuildContext context, String title, String imagePath, Function() onTap) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: screenHeight * 0.25,
        width: screenWidth * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenWidth * 0.47,
              decoration: const BoxDecoration(
                color: Color.fromARGB(133, 53, 8, 57),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTimeBasedGreeting() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (currentHour >= 0 && currentHour < 12) {
      return 'Good Morning';
    } else if (currentHour >= 12 && currentHour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
