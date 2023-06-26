import 'package:flutter/material.dart';
import 'package:social_app/modules/other_services/model/photo.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.photo});
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(photo.image),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            photo.title,
            //style: const TextStyle(color: kTextLightColor),
          ),
        ),
      ],
    );
  }
}
