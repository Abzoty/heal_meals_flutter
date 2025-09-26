import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/home/data/models/condition_model.dart';
import 'package:heal_meals/features/home/data/models/user_condition_model.dart';
import 'package:heal_meals/features/home/data/repositories/condition_repo.dart';

part 'condition_state.dart';

class ConditionCubit extends Cubit<ConditionState> {
  final ConditionRepo _conditionRepo;
  ConditionCubit({required ConditionRepo conditionRepo})
    : _conditionRepo = conditionRepo,
      super(ConditionInitial());

  Future<void> getAllConditions() async {
    emit(ConditionLoading());
    final result = await _conditionRepo.getAllConditions();
    result.when(
      success: (conditions) => emit(ConditionAllLoaded(conditions)),
      error: (e) => emit(ConditionError(e)),
    );
  }

  Future<void> getUserConditions() async {
    emit(ConditionLoading());
    final result = await _conditionRepo.getAllUserConditions();
    result.when(
      success: (userConditions) => emit(ConditionUserLoaded(userConditions)),
      error: (e) => emit(ConditionError(e)),
    );
  }

  Future<void> addUserCondition(String userId, String conditionId) async {
    emit(ConditionLoading());
    final result = await _conditionRepo.addUserCondition(userId, conditionId);
    result.when(
      success: (_) => getUserConditions(),
      error: (e) => emit(ConditionError(e)),
    );
  }

  Future<void> deleteUserCondition(String userConditionId) async {
    emit(ConditionLoading());
    final result = await _conditionRepo.deleteUserCondition(userConditionId);
    result.when(
      success: (_) => getUserConditions(),
      error: (e) => emit(ConditionError(e)),
    );
  }
}
