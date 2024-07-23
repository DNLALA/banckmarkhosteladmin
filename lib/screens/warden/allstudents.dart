import 'dart:convert';
import 'package:banckmarkhosteladmin/api/base.dart';
import 'package:banckmarkhosteladmin/services/Token.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class HostelListScreen extends StatefulWidget {
  const HostelListScreen({Key? key}) : super(key: key);

  @override
  _HostelListScreenState createState() => _HostelListScreenState();
}

class _HostelListScreenState extends State<HostelListScreen> {
  late List<dynamic> hostels = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchHostels();
  }

  Future<void> fetchHostels() async {
    try {
      var box = await Hive.openBox(tokenBox);
      String? token = box.get('token');
      final url = Uri.parse('$baseUrl/hostel/hostel-list/');
      final response = await http.get(url, headers: {
        'Authorization': 'Token $token',
      });

      if (response.statusCode == 200) {
        setState(() {
          hostels = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load hostels');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Student Details",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? const Center(child: Text('Failed to load hostels.'))
              : ListView.builder(
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 160, 98, 160),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 190,
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Student Name: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['user']['username'] ?? 'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Student Email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['user']['email'] ?? 'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Student Reg No: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['user']['reg_no'] ?? 'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Hostel: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['hostel'] ?? 'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Room Type: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['room_type'] ?? 'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Seater: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['seater']?.toString() ?? 'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Room: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['room_number']?.toString() ??
                                      'N/A'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Bed: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(hostel['bed']?.toString() ?? 'N/A'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
