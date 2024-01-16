import 'package:flutter/material.dart';
import 'package:social_app/features/other_services/view/dumb_and_deaf_services_camera.dart';
import 'package:social_app/features/other_services/widgets/other_services/custom_card.dart';

import 'learn_the_asl_view.dart';

class OtherServicesView extends StatelessWidget {
  const OtherServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomCard(
                title: 'Dumb and Deaf Services Camera ==>',
                image: 'assets/images/cv2.webp',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              const DumbDeafServicesCamera())));
                }),
            CustomCard(
              image: 'assets/images/cv3.png',
              title: 'Learn The ASL ==>',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LearnTheASL())),
            ),
          ],
        ),
      ),
    );
  }
}
