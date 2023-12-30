import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:social_app/features/on_boarding/data/repositories/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  @override
  List<OnBoardingModel> onBoardingPages() {
    return <OnBoardingModel>[
      OnBoardingModel(
          image: AppAssets.onBoarding1, title: "Welcome To the Fun Media X"),
      OnBoardingModel(
          image: AppAssets.onBoarding2,
          title: "Best Social App to Make New Friends"),
      OnBoardingModel(
          image: AppAssets.onBoarding3,
          title: "Enjoy Your Life Every Time,Every Where"),
    ];
  }
}
