part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class InitialWeatherFetchEvent extends HomeEvent {}

class GetUserEvent extends HomeEvent {}