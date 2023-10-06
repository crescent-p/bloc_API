import 'package:bloc/bloc.dart';
import 'package:bloc_api/authentication/models/user.dart';
import 'package:bloc_api/methods/weather/weather_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial(isLoading: true)) {





    on<InitialWeatherFetchEvent>((event, emit) async {
      WeatherData weatherData = await WeatherData().getWeatherData();
      emit(GotWeatherState(weatherData, isLoading: false));
    });


    on<GetUserEvent>((event, emit) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        MyUser myUser = MyUser.fromFirebaseUser(user);
        emit(GotUserState(myUser, isLoading: false));
      } else {
        emit(HomeErrorState("User not found", isLoading: false));
      }
    });
  }
}
