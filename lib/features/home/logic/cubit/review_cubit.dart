import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/home/data/models/review_model.dart';
import 'package:heal_meals/features/home/data/repositories/review_repo.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepo _reviewRepo;
  ReviewCubit({required ReviewRepo reviewRepo})
    : _reviewRepo = reviewRepo,
      super(ReviewInitial());

  Future<void> submitReview(ReviewModel review) async {
    emit(ReviewLoading());
    final result = await _reviewRepo.makeReview(review);
    result.when(
      success: (_) => emit(ReviewSuccess(review: review)),
      error: (e) => emit(ReviewError(e)),
    );
  }
}
