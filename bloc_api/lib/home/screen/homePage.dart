import 'package:bloc_api/authentication/bloc/auth_bloc.dart';
import 'package:bloc_api/consts/colors.dart';
import 'package:bloc_api/home/screen/homeScreenItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  int _page = 0;

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state.isLoading) {
          CircularProgressIndicator;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
            backgroundColor: tertiaryColor,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: primaryColor,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventLogout());
                },
              ),
            ],
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: homeScreenItems,
          ),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: tertiaryColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: (_page == 0) ? primaryColor : secondaryColor,
                ),
                label: '',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: (_page == 1) ? primaryColor : secondaryColor,
                  ),
                  label: '',
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    color: (_page == 2) ? primaryColor : secondaryColor,
                  ),
                  label: '',
                  backgroundColor: primaryColor),
            ],
            onTap: (value) => navigationTapped(value),
            currentIndex: _page,
          ),
        );
      },
    );
  }
}
