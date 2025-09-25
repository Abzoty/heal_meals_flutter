import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/data/models/recipe_list_model.dart';
import 'package:heal_meals/features/home/logic/cubit/recipe_cubit.dart';
import 'package:heal_meals/features/home/ui/pages/recipe_page.dart';

class TopPics extends StatelessWidget {
  final List<RecipeListModel> recipes;

  const TopPics({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Top Picks",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Horizontal List of Cards
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final recipeCubit = context.read<RecipeCubit>();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: recipeCubit, // 👈 reuse the existing cubit
                        child: RecipePage(recipeId: recipes[index].recipeId,),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 300.w,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: index == recipes.length - 1 ? 16.w : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: AssetImage('assets/images/food.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Gradient overlay for text visibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromARGB(88, 0, 0, 0),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Recipe title text and stars
                      Positioned(
                        left: 12.w,
                        bottom: 12.h,
                        child: Row(
                          children: [
                            Text(
                              recipes[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.star, color: Colors.yellow, size: 16.r),
                            SizedBox(width: 2.w),
                            Text(
                              recipes[index].stars.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
