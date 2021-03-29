import 'package:kpiRedux/app/redux/app_state/app_state.dart';
import 'package:kpiRedux/app/redux/reducers/artist_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    artistState: artistReducer(state.artistState, action),
  );
}
