import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_session/bloc/api/bloc_api_home_bloc.dart';

import 'bloc_api_home_screen.dart';

class BlocApiHomePage extends StatelessWidget {
  static const String routeName = 'bloc-api-home-page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocApiHomeBloc>(
      create: (context) => BlocApiHomeBloc(context: context),
      child: BlocApiHomeScreen(),
    );
  }
}
