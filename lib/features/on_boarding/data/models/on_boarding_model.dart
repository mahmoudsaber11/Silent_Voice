import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  final String image;
  final String title;

  OnBoardingModel({required this.image, required this.title});

  @override
  List<Object?> get props => [
        title,
        image,
      ];
}
