import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_session/api/models/user.dart';
import 'package:flutter_bloc_session/app_resources.dart';
import 'package:flutter_bloc_session/app_widgets/app_arrow_icon.dart';
import 'package:flutter_bloc_session/app_widgets/app_loader.dart';
import 'package:flutter_bloc_session/bloc/api/bloc_api_home_state.dart';

import 'bloc_api_home_bloc.dart';
import 'bloc_api_home_event.dart';

class BlocApiHomeScreen extends StatefulWidget {
  @override
  _BlocApiHomeScreenState createState() => _BlocApiHomeScreenState();
}

class _BlocApiHomeScreenState extends State<BlocApiHomeScreen> {
  BlocApiHomeBloc _homeBloc;
  bool _displayAsGrid;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _displayAsGrid = false;
    _homeBloc = BlocProvider.of<BlocApiHomeBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback(onLayoutDone);
    super.initState();
  }

  void onLayoutDone(Duration timeStamp) {
    _homeBloc.add(HomeEventGet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('BLoC API Demo'),
        flexibleSpace: AppWidgets.appBarFlexibleContainer,
        /*leading: Switch(
          activeTrackColor: AppColors.colorBlue,
          inactiveTrackColor: Colors.white,
          activeColor: Colors.black,
          inactiveThumbColor: Colors.black87,
          value: _displayAsGrid,
          onChanged: (val) {
            setState(
              () {
                _displayAsGrid = val;
              },
            );
          },
        ),*/
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: BlocListener<BlocApiHomeBloc, BlocApiHomeState>(
          listener: (context, state) {
            if (state is HomeStateSuccess) {
              Future.delayed(Duration(milliseconds: 500), () {
                _displaySnackBar("API Response Success", Colors.green.shade600);
              });
            }
            if (state is HomeStateFail) {
              Future.delayed(Duration(milliseconds: 500), () {
                _displaySnackBar("API Response Failed", Colors.red.shade600);
              });
            }
          },
          child: BlocBuilder<BlocApiHomeBloc, BlocApiHomeState>(
            builder: (context, state) {
              if (state is HomeStateSuccess) {
                return _buildUsers(state);
              }
              if (state is HomeStateFail) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Oops !\nFailed to get user response',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      AppArrowIcon(
                        iconData: Icons.refresh,
                        iconSize: 50,
                        iconColor: AppColors.colorLightBlue,
                        onPress: () {
                          _homeBloc.add(HomeEventGet());
                        },
                      ),
                    ],
                  ),
                );
              }
              return AppLoader();
            },
          ),
        ),
      ),
    );
  }

  /// Build User Listing
  Widget _buildUsers(HomeStateSuccess state) {
    List<User> users = state.list.asList();
    if (users.isNotEmpty) {
      return _displayAsGrid ? _buildAsGridView(users) : _buildAsListView(users);
    } else {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Text(
          'There is no User Registered in the system yet!\n\nCome & Try Later.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w400,
              ),
        ),
      );
    }
  }

  /// Display User list as ListView
  Widget _buildAsListView(List<User> users) {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (context, position) => Divider(
        thickness: 0.5,
        color: Colors.lightBlueAccent,
      ),
      itemBuilder: (context, position) {
        User user = users[position];
        return _buildUserListItem(user);
      },
    );
  }

  /// User Item for ListView
  Widget _buildUserListItem(User user) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.colorGradient,
        ),
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle:
          Text('${user.firstName[0].toLowerCase()}${user.lastName}@gmail.com'),
    );
  }

  /// Display User list as GridView
  Widget _buildAsGridView(List<User> users) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: GridView.builder(
        itemCount: users.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        shrinkWrap: true,
        itemBuilder: (context, position) {
          User user = users[position];
          return _buildUserGridItem(user);
        },
      ),
    );
  }

  /// User Item for GridView
  Widget _buildUserGridItem(User user) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
        border: Border.all(
          color: Colors.lightBlueAccent,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.colorGradient,
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text('${user.firstName} ${user.lastName}'),
          Text('${user.firstName[0].toLowerCase()}${user.lastName}@gmail.com')
        ],
      ),
    );
  }

  /// Display Snackbar
  void _displaySnackBar(String message, Color color) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: color,
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}
