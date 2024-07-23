import 'dart:convert';
import 'package:banckmarkhosteladmin/screens/room/hostelDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import '../../api/base.dart';
import '../../services/Token.dart';
import '../hotsel/roomType.dart';

class RoomManagement extends StatefulWidget {
  const RoomManagement({super.key});

  @override
  State<RoomManagement> createState() => _RoomManagementState();
}

class _RoomManagementState extends State<RoomManagement> {
  late List<dynamic> hostels = [];
  bool isLoading = true;

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
      });
      print(e.toString());
    }
  }

  void navigateToDetailPage(dynamic hostel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HostelDetailPage(hostel: hostel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Room Management',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hostels.isEmpty
              ? const Center(child: Text('No hostels available'))
              : ListView.builder(
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
                    final user = hostel['user'];
                    return ListTile(
                      onTap: () => navigateToDetailPage(hostel),
                      trailing: user == null
                          ? const Text(
                              'Not assigned',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )
                          : const Text(
                              'Assigned',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                      title: user != null
                          ? Text(
                              user['username'] ?? 'No name',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'No user assigned',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      subtitle: Text(
                        hostel['room_type'] ?? 'No location',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add room screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoomType()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
