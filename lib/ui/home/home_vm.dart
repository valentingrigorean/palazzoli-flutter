import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class HomeViewModel extends BaseViewModel {
  final String mainImage;

  HomeViewModel({this.mainImage}) : super(props: [mainImage]);

  factory HomeViewModel.fromStore(Store<AppState> store) {
    var appState = store.state;
    return HomeViewModel(mainImage: appState.appConfig?.mainImage);
  }
}
