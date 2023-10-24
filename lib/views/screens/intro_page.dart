import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class intro_page extends StatefulWidget {
  const intro_page({super.key});

  @override
  State<intro_page> createState() => _intro_pageState();
}

class _intro_pageState extends State<intro_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Galaxy Planets (Animator) in App",
            body:
            "A galaxy is a huge collection of gas, dust, and billions of stars and their solar systems, all held together by gravity. We live on a planet called Earth that is part of our solar system. But where is our solar system? It's a small part of the Milky Way Galaxy",
            image: Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1295851454/photo/earth-and-solar-system-planets.jpg?s=612x612&w=0&k=20&c=OKx3C55qBrlC7LISNSnUngKyaNrzLOOE2btTcITVaLs= "),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          PageViewModel(
            title: " The Random Quotes in App",
            body:
            "A galaxy is a huge collection of gas, dust, and billions of stars and their solar systems, all held together by gravity. We live on a planet called Earth that is part of our solar system. But where is our solar system? It's a small part of the Milky Way Galaxy",
            image: Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://t4.ftcdn.net/jpg/00/69/92/65/360_F_69926574_2kFde23NqDdigOTVSOwgUCP9C8kgLBdD.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ],
        done: Text("done"),
        onDone: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("isIntroVisited", true);
          Navigator.pushReplacementNamed(context, 'splashScreen');
        },
        next: Text("Next"),
        showNextButton: true,
      ),
    );
  }
}