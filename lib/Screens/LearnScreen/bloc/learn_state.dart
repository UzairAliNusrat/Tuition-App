part of 'learn_bloc.dart';

@immutable
abstract class LearnState {}

class LearnActionState extends LearnState {}


class LearnInitial extends LearnState {}

class LearnLoadingState extends LearnState {}

class LearnLoadedSuccessState extends LearnState {}
