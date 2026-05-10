class OnBoardingModel {
  final String? index;
  final String image;
  final String image2;
  final String title;
  final String description;
  final bool showBackButton;

  OnBoardingModel({
    required this.index,
    required this.image,
    required this.image2,
    required this.title,
    required this.description,
    this.showBackButton = false,
  });
}