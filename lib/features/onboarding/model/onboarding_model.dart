
import '../../../core/gen/assets.gen.dart' show Assets;
import '../data/onboarding_data.dart';

class OnBoardingData {
  static List<OnBoardingModel> items = [

    OnBoardingModel(
      index: '0',
      image: Assets.images.onboarding11.path,
      image2: Assets.images.onboarding1.path,
      title: 'Find Your Next\nFavorite Movie Here',
      description:
      'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    ),

    OnBoardingModel(
      index: '1',
      image: Assets.images.onboarding22.path,
      image2: Assets.images.onboarding2.path,
      title: 'Discover Movies',
      description:
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    ),

    OnBoardingModel(
      index: '2',
      image: Assets.images.onboarding33.path,
      image2: Assets.images.onboarding3.path,
      title: 'Explore All Genres',
      description:
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      showBackButton: true,
    ),

    OnBoardingModel(
      index: '3',
      image: Assets.images.onboarding44.path,
      image2: Assets.images.onboarding4.path,
      title: 'Create Watchlists',
      description:
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      showBackButton: true,
    ),

    OnBoardingModel(
      index: '4',
      image: Assets.images.onboarding55.path,
      image2: Assets.images.onboarding5.path,
      title: 'Rate, Review, and Learn',
      description:
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      showBackButton: true,
    ),

    OnBoardingModel(
      index: '5',
      image: Assets.images.onboarding66.path,
      image2: Assets.images.onboarding6.path,
      title: 'Start Watching Now',
      description:
      'Enjoy the best movie experience.',
      showBackButton: true,
    ),
  ];
}