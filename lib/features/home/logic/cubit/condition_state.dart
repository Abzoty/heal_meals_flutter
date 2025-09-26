part of 'condition_cubit.dart';

abstract class ConditionState extends Equatable {
  const ConditionState();

  @override
  List<Object> get props => [];
}

class ConditionInitial extends ConditionState {}
class ConditionLoading extends ConditionState {}

class ConditionAllLoaded extends ConditionState {
  final List<ConditionModel> conditions;
  const ConditionAllLoaded(this.conditions);
  @override
  List<Object> get props => [conditions];
}

class ConditionUserLoaded extends ConditionState {
  final List<UserConditionModel> userConditions;
  const ConditionUserLoaded(this.userConditions);
  @override
  List<Object> get props => [userConditions];
}

class ConditionUserAdded extends ConditionState {
  final UserConditionModel userCondition;
  const ConditionUserAdded(this.userCondition);
  @override
  List<Object> get props => [userCondition];
}

class ConditionUserRemoved extends ConditionState {
  final UserConditionModel userCondition;
  const ConditionUserRemoved(this.userCondition);
  @override
  List<Object> get props => [userCondition];
}

class ConditionError extends ConditionState {
  final String message;
  const ConditionError(this.message);
  @override
  List<Object> get props => [message];
}
