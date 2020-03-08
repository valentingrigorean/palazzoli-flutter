import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ErrorState extends Equatable {
  final dynamic error;
  final String message;
  final bool hasConnection;
  final dynamic action;

  ErrorState({this.error, this.message, this.action, this.hasConnection = true})
      : super([error, message, action]);

  factory ErrorState.initial() => ErrorState();

  bool get hasError => error != null || message != null;
}
