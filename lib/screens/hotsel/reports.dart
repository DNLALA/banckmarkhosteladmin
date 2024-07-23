import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../api/base.dart';
import '../../models/issue.dart';
import '../../services/Token.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late Future<List<Report>> futureReports;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    var box = await Hive.openBox(tokenBox);
    String token = box.get('token');
    setState(() {
      futureReports = fetchReports(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Report>>(
        future: futureReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reports found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final report = snapshot.data![index];
                return ListTile(
                  title: Text(
                    report.report,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    report.email,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    DateFormat('yyyy-MM-dd').format(report.createdAt),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  onTap: () {
                    // Handle report tap if needed
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
