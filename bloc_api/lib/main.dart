import 'package:bloc_api/Loading/loading_screen.dart';
import 'package:bloc_api/authentication/bloc/auth_bloc.dart';
import 'package:bloc_api/authentication/screens/login.dart';
import 'package:bloc_api/firebase_options.dart';
import 'package:bloc_api/home/screen/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // await dotenv.load();
  //ensure flutter widgets are loaded
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
        child: const ControlPage(),
      ),
    ),
  );
}

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(context: context, text: 'Loading...');
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoginScreen();
        }
        if (state is AuthSuccess) {
          return const HomePage();
        } else {
          return const CircularProgressIndicator(
            color: Colors.deepPurple,
          );
        }
      },
    );
  }
}
