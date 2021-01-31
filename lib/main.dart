import 'dart:ui';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_session/app_home.dart';
import 'package:flutter_bloc_session/app_resources.dart';
import 'package:flutter_bloc_session/bloc/api/bloc_api_home_page.dart';
import 'package:flutter_bloc_session/bloc/counter/bloc_counter_home.dart';
import 'package:flutter_bloc_session/cubit/api/cubit_api_page.dart';
import 'package:flutter_bloc_session/cubit/counter/cubit_counter_home.dart';
import 'package:provider/provider.dart';

import 'api/api_handler.dart';
import 'api/converter/build_value_converter.dart';
import 'api/urls.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ChopperClient(
        baseUrl: URLS.BASE_URL,
        services: [APIHandler.create()],
        converter: BuiltValueConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ]);

    return Provider(
      create: (_) => APIHandler.create(client),
      dispose: (context, APIHandler apiHandler) => apiHandler.client.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 3.0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.colorBlue,
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
              ),
            ),
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppHome(title: 'Flutter BloC Demo Application'),
        routes: {
          CubitCounterPage.routeName: (context) => CubitCounterPage(),
          CubitApiPage.routeName: (context) => CubitApiPage(),
          BlocCounterHome.routeName: (context) => BlocCounterHome(),
          BlocApiHomePage.routeName: (context) => BlocApiHomePage(),
        },
      ),
    );
  }
}
