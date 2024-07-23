import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import '../../api/base.dart';
import '../../services/Token.dart';

class HostelDetailPage extends StatefulWidget {
  final dynamic hostel;

  const HostelDetailPage({Key? key, required this.hostel}) : super(key: key);

  @override
  _HostelDetailPageState createState() => _HostelDetailPageState();
}

class _HostelDetailPageState extends State<HostelDetailPage> {
  bool isRoomAssigned = false;
  List<dynamic> userList = [];

  @override
  void initState() {
    super.initState();
    fetchUsersWithoutHostel();
  }

  Future<void> fetchUsersWithoutHostel() async {
    try {
      var box = await Hive.openBox(tokenBox);
      String? token = box.get('token');

      final url = Uri.parse('$baseUrl/hostel/users/without-hostel/');
      final response = await http.get(url, headers: {
        'Authorization': 'Token $token',
      });

      if (response.statusCode == 200) {
        setState(() {
          userList = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load users without hostel');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    isRoomAssigned = widget.hostel['user'] != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.hostel['name'] ?? 'Hostel Detail',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Room type: ${widget.hostel['room_type'] ?? 'No location'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  'Seater: ${widget.hostel['seater'] ?? 'No location'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  'Hostel: ${widget.hostel['hostel'] ?? 'No location'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  'Room bed: ${widget.hostel['bed'] ?? 'No location'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  'Room Assignment: ${isRoomAssigned ? 'Assigned' : 'Not Assigned'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: isRoomAssigned ? Colors.red : Colors.green,
                  ),
                ),
                if (isRoomAssigned) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Username: ${widget.hostel['user']['username'] ?? 'No location'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Username: ${widget.hostel['user']['email'] ?? 'No location'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Username: ${widget.hostel['user']['reg_no'] ?? 'No location'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ]
              ],
            ),
            Column(
              children: [
                if (!isRoomAssigned)
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              final user = userList[index];
                              return ListTile(
                                title: Text(user['username'] ?? 'No username'),
                                subtitle: Text(user['email'] ?? 'No email'),
                                onTap: () {
                                  assignRoomToUser(
                                      user); // Implement this method
                                  Navigator.pop(
                                      context); // Close the bottom sheet
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Text('Assign Room'),
                  ),
                const SizedBox(
                  height: 40,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> assignRoomToUser(dynamic user) async {
    print(user['id']);
    print(widget.hostel['id']);
    try {
      var box = await Hive.openBox(tokenBox);
      String? token = box.get('token');

      final url = Uri.parse(
          '$baseUrl/hostel/change-hostel-user/${widget.hostel['id']}/');
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'user_id': user['id']}),
      );

      if (response.statusCode == 200) {
        setState(() {
          widget.hostel['user'] = user;
          isRoomAssigned = true;
        });
      } else {
        throw Exception('Failed to assign room to user');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
