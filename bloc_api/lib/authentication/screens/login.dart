import 'package:bloc_api/authentication/bloc/auth_bloc.dart';
import 'package:bloc_api/authentication/methods/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
        child: LimitedBox(
          maxHeight: 1000,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  // color: Colors.brown[50],
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/locked.png',
                    colorBlendMode: BlendMode.difference,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.brown, fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Sign up tapped');
                          },
                          child: const Text(
                            ' SIGN UP',
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 60),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.brown[50],
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.accessibility,
                                    color: Colors.brown,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TextField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'E M A I L',
                                      hintStyle: TextStyle(
                                          color: Colors.brown, fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.brown[50],
                            child: Row(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.brown,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TextField(
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'P A S S W O R D',
                                      hintStyle: TextStyle(
                                          color: Colors.brown, fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.brown, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 30, bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.brown,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  print('Sign in tapped');
                                },
                                child: const Text('S I G N  I N',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: SignInButton(
                                Buttons.AppleDark,
                                text: "Sign in",
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: SignInButton(
                                Buttons.Google,
                                text: "Sign in",
                                onPressed: () async {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthEventLogin());
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: SignInButton(
                                Buttons.Facebook,
                                text: "Sign in",
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
