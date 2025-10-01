// features/home/logic/donation_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/home/data/repositories/donation.repo.dart';
import 'package:heal_meals/features/home/data/models/donation_model.dart';
import 'package:heal_meals/features/home/logic/cubit/donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  final DonationRepository _donationRepository;

  DonationCubit({required DonationRepository donationRepository})
    : _donationRepository = donationRepository,
      super(DonationInitial());

  Future<void> makeDonation(DonationModel donationModel) async {
    emit(DonationLoading());

    final result = await _donationRepository.makeDonation(donationModel);

    result.when(
      success: (data) {
        emit(
          DonationSuccess(
            message: data['message'] ?? 'Donation made successfully!',
          ),
        );
      },
      error: (error) {
        emit(DonationFailure(error: error));
      },
    );
  }
}
