import 'package:equatable/equatable.dart';

abstract class DonationState extends Equatable {
  const DonationState();

  @override
  List<Object> get props => [];
}

class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationSuccess extends DonationState {
  final String message;

  const DonationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DonationFailure extends DonationState {
  final String error;

  const DonationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
