import 'package:lightingPalazzoli/data/repository.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/app/base_midleware.dart';
import 'package:lightingPalazzoli/redux/data/data_actions.dart';

class ActivityMiddleware extends BaseMiddleware<LoadActivityAction> {
  ActivityMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data in repository.getActivities()) {
      yield LoadedActivityAction(data);
    }
  }
}
