import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/utils/error_utils.dart';
import 'package:lightingPalazzoli/widgets/custom_error_widget.dart';
import 'package:lightingPalazzoli/widgets/loading_widget.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
abstract class BaseViewModel extends Equatable {
  final bool isLoading;

  BaseViewModel({List props = const [], this.isLoading = false})
      : super(props + [isLoading]);
}

class ErrorViewModel extends BaseViewModel {
  final dynamic action;
  final String message;
  final void Function(dynamic action) retry;

  ErrorViewModel({this.action, this.message, this.retry, bool isLoading})
      : super(isLoading: isLoading, props: [action, message]);

  factory ErrorViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var appState = store.state;
    if (!appState.hasError) return null;
    var state = appState.errorState;

    return ErrorViewModel(
        isLoading: appState.isLoading,
        retry: (action) {
          store.dispatch(ClearErrorAction());
          store.dispatch(action);
        },
        message:
            state.message ?? ErrorUtils.getErrorDescription(state, context),
        action: state.action);
  }
}

class ContentWidget<VM extends BaseViewModel> extends StatelessWidget {
  final Widget loading;
  final Widget Function(ErrorViewModel viewModel) errorBuilder;
  final ViewModelBuilder<VM> viewModelBuilder;
  final StoreConverter<AppState, VM> converter;
  final bool useSafeArea;
  final OnDidChangeCallback<VM> onDidChange;
  final dynamic dispatchAction;

  ContentWidget(
      {Key key,
      @required this.viewModelBuilder,
      @required this.converter,
      this.loading = const LoadingWidget(),
      this.errorBuilder = _defaultErrorBuilder,
      this.onDidChange,
      this.useSafeArea = false,
      this.dispatchAction})
      : super(key: key);

  static Widget _defaultErrorBuilder(ErrorViewModel viewModel) {
    return CustomErrorWidget.fromViewModel(viewModel);
  }

  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: StoreConnector<AppState, _ViewModelProxy>(
          onInit: _onInit,
          converter: (store) {
            var vm = _ViewModelProxy.fromStore(store, converter, context);
            return vm;
          },
          onDidChange: _onDidChange,
          distinct: true,
          builder: (context, vm) {
            if (vm.hasError) {
              return errorBuilder(vm.errorViewModel);
            }
            if (vm.isLoading) {
              return loading;
            }
            return getContent(context, vm);
          }),
    );
  }

  Widget getContent(BuildContext context, _ViewModelProxy vm) {
    var content = viewModelBuilder(context, vm.viewModel);
    content = useSafeArea ? SafeArea(child: content) : content;
    return content;
  }

  void _onInit(Store<AppState> store) {
    if (dispatchAction != null) store.dispatch(dispatchAction);
  }

  void _onDidChange(_ViewModelProxy viewModel) {
    if (!viewModel.hasError &&
        viewModel.viewModel != null &&
        onDidChange != null) {
      onDidChange(viewModel.viewModel);
    }
  }
}

class _ViewModelProxy<VM extends BaseViewModel> extends Equatable {
  final VM viewModel;
  final ErrorViewModel errorViewModel;
  final bool isLoading;

  _ViewModelProxy(this.viewModel, this.errorViewModel, this.isLoading)
      : super([viewModel, errorViewModel, isLoading]);

  factory _ViewModelProxy.fromStore(Store<AppState> store,
      StoreConverter<AppState, VM> converter, BuildContext context) {
    var errorViewModel = ErrorViewModel.fromStore(store, context);
    return _ViewModelProxy(errorViewModel == null ? converter(store) : null,
        errorViewModel, store.state.isLoading);
  }

  bool get hasError => errorViewModel != null;

  bool get haveContent => errorViewModel == null && !isLoading;
}
