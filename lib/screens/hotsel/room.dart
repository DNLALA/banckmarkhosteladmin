import 'package:banckmarkhosteladmin/componets/botton/SubmitBotton.dart';
import 'package:banckmarkhosteladmin/componets/botton/choise.dart';
import 'package:banckmarkhosteladmin/screens/hotsel/bedType.dart';
import 'package:flutter/material.dart';

class RoomNumber extends StatefulWidget {
  final String roomType;
  final String seater;
  final String hostel;

  const RoomNumber({
    Key? key,
    required this.roomType,
    required this.seater,
    required this.hostel,
  }) : super(key: key);

  @override
  State<RoomNumber> createState() => _RoomNumberState();
}

class _RoomNumberState extends State<RoomNumber> {
  String? roomNumber;
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
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
                  "Choose Any Room",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Room 101 - 109',
                  onPressed: () {
                    setState(() {
                      roomNumber = 'Room 101 - 109';
                    });
                  },
                  textColor: Colors.black,
                  isActive: roomNumber == 'Room 101 - 109',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Room 201 - 209',
                  onPressed: () {
                    setState(() {
                      roomNumber = 'Room 201 - 209';
                    });
                  },
                  textColor: Colors.black,
                  isActive: roomNumber == 'Room 201 - 209',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Room 301 - 309',
                  onPressed: () {
                    setState(() {
                      roomNumber = 'Room 301 - 309';
                    });
                  },
                  textColor: Colors.black,
                  isActive: roomNumber == 'Room 301 - 309',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Room 401 - 409',
                  onPressed: () {
                    setState(() {
                      roomNumber = 'Room 401 - 409';
                    });
                  },
                  textColor: Colors.black,
                  isActive: roomNumber == 'Room 401 - 409',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Room 501 - 509',
                  onPressed: () {
                    setState(() {
                      roomNumber = 'Room 501 - 509';
                    });
                  },
                  textColor: Colors.black,
                  isActive: roomNumber == 'Room 501 - 509',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Room 601 - 609',
                  onPressed: () {
                    setState(() {
                      roomNumber = 'Room 601 - 609';
                    });
                  },
                  textColor: Colors.black,
                  isActive: roomNumber == 'Room 601 - 609',
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
    if (roomNumber != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BedType(
            roomType: widget.roomType,
            seater: widget.seater,
            roomNumber: roomNumber!,
            hostel: widget.hostel,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select room'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
