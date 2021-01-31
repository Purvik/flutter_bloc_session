import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_session/app_resources.dart';
import 'package:flutter_bloc_session/app_widgets/app_arrow_icon.dart';
import 'package:flutter_bloc_session/bloc/counter/counter_bloc.dart';

class BlocCounterHome extends StatelessWidget {
  static final String routeName = 'bloc-counter-home';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => CounterBloc(0),
      child: BlocCounterPage(),
    );
  }
}

class BlocCounterPage extends StatefulWidget {
  @override
  _BlocCounterPageState createState() => _BlocCounterPageState();
}

class _BlocCounterPageState extends State<BlocCounterPage> {
  CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = BlocProvider.of<CounterBloc>(context);
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Counter Demo'),
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
              onPress: () => _counterBloc.add(CounterEvent.increment),
            ),
            SizedBox(
              height: 50,
            ),
            BlocBuilder<CounterBloc, int>(
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
              onPress: () => _counterBloc.add(CounterEvent.decrement),
            ),
          ],
        ),
      ),
    );
  }
}
