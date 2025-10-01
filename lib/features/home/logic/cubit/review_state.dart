part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final ReviewModel review;
  const ReviewSuccess({required this.review});

  @override
  List<Object> get props => [review];
}

class ReviewError extends ReviewState {
  final String message;
  const ReviewError(this.message);
}
