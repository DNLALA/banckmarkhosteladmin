import 'package:banckmarkhosteladmin/componets/botton/SubmitBotton.dart';
import 'package:banckmarkhosteladmin/componets/botton/choise.dart';
import 'package:banckmarkhosteladmin/screens/hotsel/room.dart';
import 'package:flutter/material.dart';

class HostelType extends StatefulWidget {
  final String roomType;
  final String seater;

  const HostelType({
    Key? key,
    required this.roomType,
    required this.seater,
  }) : super(key: key);

  @override
  State<HostelType> createState() => _HostelTypeState();
}

class _HostelTypeState extends State<HostelType> {
  String? hostel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Student Dashboard",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  "Choose Any Hostel",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Boys Hostel 1',
                  onPressed: () {
                    setState(() {
                      hostel = 'Boys Hostel 1';
                    });
                  },
                  textColor: Colors.black,
                  isActive: hostel == 'Boys Hostel 1',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Boys Hostel 2',
                  onPressed: () {
                    setState(() {
                      hostel = 'Boys Hostel 2';
                    });
                  },
                  textColor: Colors.black,
                  isActive: hostel == 'Boys Hostel 2',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Boys Hostel 3',
                  onPressed: () {
                    setState(() {
                      hostel = 'Boys Hostel 3';
                    });
                  },
                  textColor: Colors.black,
                  isActive: hostel == 'Boys Hostel 3',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Girls Hostel 1',
                  onPressed: () {
                    setState(() {
                      hostel = 'Girls Hostel 1';
                    });
                  },
                  textColor: Colors.black,
                  isActive: hostel == 'Girls Hostel 1',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Girls Hostel 2',
                  onPressed: () {
                    setState(() {
                      hostel = 'Girls Hostel 2';
                    });
                  },
                  textColor: Colors.black,
                  isActive: hostel == 'Girls Hostel 2',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Girls Hostel 3',
                  onPressed: () {
                    setState(() {
                      hostel = 'Girls Hostel 3';
                    });
                  },
                  textColor: Colors.black,
                  isActive: hostel == 'Girls Hostel 3',
                ),
              ],
            ),
            Column(
              children: [
                SubmitButton(
                  buttonText: "Next",
                  textColor: Colors.white,
                  onPressed: nextPage,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    if (hostel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoomNumber(
            roomType: widget.roomType,
            seater: widget.seater,
            hostel: hostel!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select hostel'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
