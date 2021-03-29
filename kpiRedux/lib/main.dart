import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kpiRedux/app/redux/app_state/app_state.dart';
import 'package:kpiRedux/app/redux/reducers/app_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'app/view/homepage/page/homepage_page.dart';
import 'logger.dart';
import 'theme/config.dart';
import 'theme/custom_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, apiMiddleware, loggingMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Artist app',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        themeMode: currentTheme.currentTheme,
        home: Home(),
      ),
    );
  }
}
