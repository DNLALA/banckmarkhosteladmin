// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../api/base.dart';
import '../../models/issue.dart';
import '../../services/Token.dart';
import 'issuedetail.dart';
import 'transfarDetail.dart';

class TransfarScreen extends StatefulWidget {
  const TransfarScreen({super.key});

  @override
  _TransfarScreenState createState() => _TransfarScreenState();
}

class _TransfarScreenState extends State<TransfarScreen> {
  late Future<List<Transfar>> futureIssues;

  @override
  void initState() {
    super.initState();
    _loadIssues();
  }

  Future<void> _loadIssues() async {
    var box = await Hive.openBox(tokenBox);
    String token = box.get('token');
    setState(() {
      futureIssues = fetchtransfar(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Transfar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<Transfar>>(
        future: futureIssues,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No issues found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final issue = snapshot.data![index];
                return ListTile(
                  title: Text(
                    issue.transfar,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    issue.email,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    issue.transfarStatus,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TransfarDetailsScreen(issue: issue),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
