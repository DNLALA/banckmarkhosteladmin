import 'package:banckmarkhosteladmin/componets/botton/SubmitBotton.dart';
import 'package:banckmarkhosteladmin/componets/botton/choise.dart';
import 'package:banckmarkhosteladmin/screens/hotsel/hotelType.dart';
import 'package:flutter/material.dart';

class Seater extends StatefulWidget {
  final String roomType;

  const Seater({
    Key? key,
    required this.roomType,
  }) : super(key: key);

  @override
  State<Seater> createState() => _SeaterState();
}

class _SeaterState extends State<Seater> {
  String? seater;
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
                      image: AssetImage('assets/busstation.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Select Seater",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: '1 Seater',
                  onPressed: () {
                    setState(() {
                      seater = '1 Seater';
                    });
                  },
                  textColor: Colors.black,
                  isActive: seater == '1 Seater',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: '2 Seater',
                  onPressed: () {
                    setState(() {
                      seater = '2 Seater';
                    });
                  },
                  textColor: Colors.black,
                  isActive: seater == '2 Seater',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: '3 Seater',
                  onPressed: () {
                    setState(() {
                      seater = '3 Seater';
                    });
                  },
                  textColor: Colors.black,
                  isActive: seater == '3 Seater',
                ),
                const SizedBox(height: 10),
                ChoiceButton(
                  buttonText: '4 Seater',
                  onPressed: () {
                    setState(() {
                      seater = '4 Seater';
                    });
                  },
                  textColor: Colors.black,
                  isActive: seater == '4 Seater',
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
    if (seater != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HostelType(
            roomType: widget.roomType,
            seater: seater!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a seater'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
