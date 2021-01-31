import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_session/app_resources.dart';
import 'package:flutter_bloc_session/app_widgets/app_arrow_icon.dart';
import 'package:flutter_bloc_session/cubit/counter/counter_cubit.dart';

class CubitCounterPage extends StatelessWidget {
  static final String routeName = 'cubit-counter-page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CubitCounterHome(),
    );
  }
}

class CubitCounterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Counter Demo'),
        flexibleSpace: AppWidgets.appBarFlexibleContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppArrowIcon(
              iconData: Icons.keyboard_arrow_up,
              onPress: () => context.read<CounterCubit>().increment(),
            ),
            SizedBox(
              height: 50,
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$state',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            AppArrowIcon(
              iconData: Icons.keyboard_arrow_down,
              onPress: () => context.read<CounterCubit>().decrement(),
            ),
          ],
        ),
      ),
    );
  }
}
