import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:social_app/features/on_boarding/data/repositories/on_boarding_repo.dart';
import 'package:social_app/features/on_boarding/presentation/cubit/on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingRepo onBoardingRepo;

  OnBoardingCubit({required this.onBoardingRepo})
      : super(const OnBoardingInitial());

  List<OnBoardingModel> onBoardingPages() {
    return onBoardingRepo.onBoardingPages();
  }

  bool isLastBoarding = false;
  void onChangePageIndex(int index) {
    if (index == onBoardingPages().length - 1) {
      isLastBoarding = true;
    } else {
      isLastBoarding = false;
    }
    emit(PageViewIndexChanged(index: index));
  }
}
