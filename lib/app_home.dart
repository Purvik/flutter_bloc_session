import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_session/app_resources.dart';
import 'package:flutter_bloc_session/bloc/api/bloc_api_home_page.dart';
import 'package:flutter_bloc_session/bloc/counter/bloc_counter_home.dart';
import 'package:flutter_bloc_session/cubit/api/cubit_api_page.dart';
import 'package:flutter_bloc_session/cubit/counter/cubit_counter_home.dart';

class AppHome extends StatefulWidget {
  AppHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  PageController pageController;
  int currentPage = 0;

  List<Map<String, dynamic>> _data = [
    {
      "image": AppImages.imageCubit,
      "label1": AppStrings.labelCounter,
      "label2": AppStrings.labelAPI,
    },
    {
      "image": AppImages.imageBloc,
      "label1": AppStrings.labelCounter,
      "label2": AppStrings.labelAPI,
    },
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  void _pageViewChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget _activeIndicator() => Row(
        children: List<Widget>.generate(
          _data.length,
          (index) => AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
            height: 5,
            width: MediaQuery.of(context).size.width * 0.4 / _data.length,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5,
              ),
              gradient: currentPage == index ? AppColors.colorGradient : null,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        flexibleSpace: AppWidgets.appBarFlexibleContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: _pageViewChanged,
                itemCount: _data.length,
                itemBuilder: (context, position) {
                  Map<String, dynamic> content = _data[position];
                  return AnimatedPadding(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      vertical: currentPage != position ? 20.0 : 0.0,
                    ),
                    child: SingleCard(
                      imagePath: content['image'],
                      button1Label: content['label1'],
                      button2Label: content['label2'],
                      button1CallBack: _button1CallBack(position),
                      button2CallBack: _button2CallBack(position),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Container(
                height: 6,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  color: Colors.white,
                ),
                child: _activeIndicator(),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: AppElevatedButton(
                  label: getLabelByPageIndex(),
                  callback: _updatePage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getLabelByPageIndex() {
    if (currentPage < _data.length - 1) {
      return 'NEXT';
    } else {
      return 'PREV';
    }
  }

  VoidCallback _button1CallBack(int position) {
    if (position == 0) {
      return () {
        Navigator.pushNamed(context, CubitCounterPage.routeName);
      };
    } else {
      return () {
        Navigator.pushNamed(context, BlocCounterHome.routeName);
      };
    }
  }

  VoidCallback _button2CallBack(int position) {
    if (position == 0) {
      return () {
        Navigator.pushNamed(context, CubitApiPage.routeName);
      };
    } else {
      return () {
        Navigator.pushNamed(context, BlocApiHomePage.routeName);
      };
    }
  }

  void _updatePage() {
    if (currentPage < _data.length - 1) {
      pageController.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.decelerate,
      );
      setState(() {
        currentPage = currentPage + 1;
      });
    } else {
      pageController.animateToPage(
        currentPage - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.decelerate,
      );
      setState(() {
        currentPage = currentPage - 1;
      });
    }
  }
}

class SingleCard extends StatelessWidget {
  final String imagePath;
  final String button1Label;
  final VoidCallback button1CallBack;
  final VoidCallback button2CallBack;
  final String button2Label;
  const SingleCard({
    Key key,
    @required this.imagePath,
    this.button1Label,
    this.button1CallBack,
    this.button2CallBack,
    this.button2Label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: AppElevatedButton(
                    label: button1Label,
                    callback: button1CallBack,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  flex: 1,
                  child: AppElevatedButton(
                    label: button2Label,
                    callback: button2CallBack,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;

  const AppElevatedButton({
    Key key,
    @required this.label,
    @required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: ElevatedButton(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: callback,
      ),
    );
  }
}
