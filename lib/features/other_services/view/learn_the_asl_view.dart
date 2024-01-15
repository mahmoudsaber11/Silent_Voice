import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/other_services/widgets/learn_the_asl/item_card.dart';
import 'package:social_app/features/other_services/data/model/photo.dart';
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
          progressIndicatorColor: AppColors.primaryColor,
          progressColors: const ProgressBarColors(
              playedColor: AppColors.primaryColor,
              handleColor: AppColors.primaryColor),
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'Learn The ASL',
                style: AppTextStyles.textStyle25,
              ),
              leading: IconButton(
                  onPressed: () {
                    context.getBack();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
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
