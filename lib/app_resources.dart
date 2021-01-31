import 'dart:ui';

import 'package:flutter/widgets.dart';

class AppImages {
  static String imageBloc = 'images/bloc.png';
  static String imageCubit = 'images/cubit.png';
}

class AppStrings {
  static String labelCounter = "COUNTER";
  static String labelAPI = "API";
}

class AppColors {
  static Color colorLightBlue = Color(0xFF7EEDDF);
  static Color colorLightDarkBlue = Color(0xFF03ABBE);
  static Color colorBlue = Color(0xFF0587BF);
  static LinearGradient colorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.colorLightBlue,
      AppColors.colorBlue,
    ],
  );
}

class AppWidgets {
  static Widget appBarFlexibleContainer = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          AppColors.colorLightBlue,
          AppColors.colorBlue,
        ],
      ),
    ),
  );
}
