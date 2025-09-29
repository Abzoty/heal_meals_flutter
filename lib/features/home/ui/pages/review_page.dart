import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/data/models/review_model.dart';
import 'package:heal_meals/features/home/logic/cubit/review_cubit.dart';

class ReviewPage extends StatelessWidget {
  final String recipeId;
  final String userId;

  ReviewPage({super.key, required this.recipeId, required this.userId});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is ReviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Review submitted successfully!")),
              );
              Navigator.pop(context);
            } else if (state is ReviewError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "Recipe Review",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Rating input
                    TextFormField(
                      controller: _ratingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Your Rating (0-10)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Enter rating";
                        final num = int.tryParse(val);
                        if (num == null || num < 0 || num > 10) {
                          return "Rating must be between 0 and 10";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Comment input
                    TextFormField(
                      controller: _commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Your Comment",
                        hintText: "Share your thoughts on this recipe...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        onPressed: state is ReviewLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final review = ReviewModel(
                                    userId: userId,
                                    recipeId: recipeId,
                                    rating: int.parse(
                                      _ratingController.text.trim(),
                                    ),
                                    comment: _commentController.text.trim(),
                                  );
                                  context.read<ReviewCubit>().submitReview(
                                    review,
                                  );
                                }
                              },
                        child: state is ReviewLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
