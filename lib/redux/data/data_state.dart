import 'package:equatable/equatable.dart';
import 'package:lightingPalazzoli/models/activity.dart';
import 'package:meta/meta.dart';

@immutable
class DataState extends Equatable {
  final ActivityList activities;

  DataState({this.activities}) : super([activities]);
}
