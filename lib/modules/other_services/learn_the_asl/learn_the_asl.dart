import 'package:flutter/material.dart';
import 'package:social_app/modules/other_services/learn_the_asl/widgets/item_card.dart';
import 'package:social_app/modules/other_services/model/photo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearnTheASL extends StatefulWidget {
  const LearnTheASL({super.key});

  @override
  State<LearnTheASL> createState() => _LearnTheASLState();
}

class _LearnTheASLState extends State<LearnTheASL> {
  YoutubePlayerController? controller;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: '6_gXiBe9y9A',
        flags: const YoutubePlayerFlags(
            autoPlay: false, mute: true, isLive: false));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
              playedColor: Colors.amber, handleColor: Colors.amberAccent),
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: const Align(
                  child: Text(
                'Learn The ASL',
                style: TextStyle(color: Colors.white),
              )),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                player,
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    itemCount: photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: .75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                      photo: photos[index],
                    ),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
