import 'package:flutter/material.dart';

import 'model/home.dart';
import 'learn_the_asl/learn_the_asl.dart';

class OtherServices extends StatelessWidget {
  const OtherServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const Home())));
              },
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               const DumbandDeafServicesAssistant()));
              // },
              child: Card(
                color: Colors.amber,
                margin: const EdgeInsets.all(8.0),
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(children: [
                  Image.asset(
                    'assets/images/cv2.webp',
                    height: 200,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Dumb and Deaf Services Camera ==>',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LearnTheASL()));
              },
              child: Card(
                color: Colors.amber,
                margin: const EdgeInsets.all(8.0),
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(children: [
                  Image.asset(
                    'assets/images/cv3.png',
                    height: 220,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Learn The ASL ==>',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
