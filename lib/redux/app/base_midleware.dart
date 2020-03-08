import 'package:lightingPalazzoli/data/repository.dart';
import 'package:lightingPalazzoli/main.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/utils/network_utils.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseMiddleware<T> implements EpicClass<AppState> {
  final Repository repository;
  final bool checkForInternet;

  BaseMiddleware(this.repository, {this.checkForInternet = true});

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<T>())
        .switchMap((action) => _fetchData(store.state, action));
  }

  Stream<dynamic> fetchData(AppState state, T action);

  Stream<dynamic> _fetchData(AppState state, dynamic action) async* {
    try {
      await for (var data in fetchData(state, action)) {
        yield data;
      }
    } catch (e, stackTrace) {
      reportError(e, stackTrace);
      yield ErrorAction(
          error: e,
          action: action,
          hasConnection:
              checkForInternet ? await NetworkUtils.checkConnectivity() : true);
    }
  }
}
