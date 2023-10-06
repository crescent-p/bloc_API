part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final String? loadingText;
  final bool isLoading;
  const HomeState(
      {this.loadingText = "Please wait...", required this.isLoading});
}

final class HomeInitial extends HomeState {

  const HomeInitial({required super.isLoading});

}

final class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message, {required super.isLoading});
}


final class GotWeatherState extends HomeState {
  final WeatherData weatherData;

  const GotWeatherState(this.weatherData, {required super.isLoading});
}

final class GotUserState extends HomeState {
  final MyUser user;

  const GotUserState(this.user, {required super.isLoading});
}