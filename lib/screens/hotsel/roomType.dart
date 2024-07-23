import 'package:banckmarkhosteladmin/componets/botton/SubmitBotton.dart';
import 'package:banckmarkhosteladmin/screens/hotsel/seater.dart';
import 'package:flutter/material.dart';
import 'package:banckmarkhosteladmin/componets/botton/choise.dart';

class RoomType extends StatefulWidget {
  const RoomType({Key? key}) : super(key: key);

  @override
  State<RoomType> createState() => _RoomTypeState();
}

class _RoomTypeState extends State<RoomType> {
  String? selectedRoomType; // Track selected room type

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                Container(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/hostelrooms.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Select Room Type",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Apartment Room AC',
                  onPressed: () {
                    setState(() {
                      selectedRoomType = 'Apartment Room AC';
                    });
                  },
                  textColor: Colors.black,
                  isActive: selectedRoomType == 'Apartment Room AC',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Standard Room AC',
                  onPressed: () {
                    setState(() {
                      selectedRoomType = 'Standard Room AC';
                    });
                  },
                  textColor: Colors.black,
                  isActive: selectedRoomType == 'Standard Room AC',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: 'Standard Room Non-AC',
                  onPressed: () {
                    setState(() {
                      selectedRoomType = 'Standard Room Non-AC';
                    });
                  },
                  textColor: Colors.black,
                  isActive: selectedRoomType == 'Standard Room Non-AC',
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
    if (selectedRoomType != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Seater(roomType: selectedRoomType!),
        ),
      );
    } else {
      // Handle case where selectedRoomType is null
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a room type'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
