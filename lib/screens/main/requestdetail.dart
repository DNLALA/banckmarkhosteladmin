import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../api/base.dart';
import '../../models/issue.dart';
import '../../services/Token.dart';
import 'package:http/http.dart' as http;

class RequestDetailsScreen extends StatefulWidget {
  final Request issue;

  const RequestDetailsScreen({super.key, required this.issue});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  late String requestStatus;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    requestStatus = widget.issue.requestStatus;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formattedDate = formatter.format(widget.issue.createdAt);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Issue Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.issue.request,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'email: ${widget.issue.email}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Status: $requestStatus',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Created At: $formattedDate',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showStatusModal,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  void _showStatusModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.pending, color: Colors.white),
              title:
                  const Text('Pending', style: TextStyle(color: Colors.white)),
              onTap: () {
                _updateStatus('pending');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work, color: Colors.white),
              title: const Text('In Progress',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                _updateStatus('in_progress');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.check, color: Colors.white),
              title:
                  const Text('Resolved', style: TextStyle(color: Colors.white)),
              onTap: () {
                _updateStatus('resolved');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateStatus(String newStatus) async {
    setState(() {
      isLoading = true;
    });

    var box = await Hive.openBox(tokenBox);
    String token = box.get('token');

    var url = Uri.parse('$baseUrl/hostel/request-update/${widget.issue.id}/');
    var res = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode({
        'request_status': newStatus,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (res.statusCode == 200 || res.statusCode == 201) {
      setState(() {
        requestStatus = newStatus; // Update the local state
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update status')),
      );
    }
  }
}
