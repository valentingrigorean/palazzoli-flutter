import 'package:lightingPalazzoli/data/repository.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/app/base_midleware.dart';

class AppConfigMiddleware extends BaseMiddleware<LoadAppConfigAction> {
  AppConfigMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data in repository.getAppConfig()) {
      yield LoadedAppConfigAction(appConfig: data);
    }
  }
}
