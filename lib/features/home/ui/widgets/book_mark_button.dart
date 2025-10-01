import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookmarkButton extends StatefulWidget {
  final bool isBookmarked;
  final String recipeId; // to know which recipe to send in the request

  const BookmarkButton({
    super.key,
    this.isBookmarked = false,
    required this.recipeId,
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        size: 38.sp,
        color: _isBookmarked ? Colors.red : Colors.black,
      ),
      onPressed: () async {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });

        if (_isBookmarked) {
          // TODO: Make POST request to add recipe to favorites
          // Example: ApiServices.addToFavorites(widget.recipeId);
          print("POST request: add recipe ${widget.recipeId} to favorites");
        } else {
          // TODO: Make DELETE request to remove recipe from favorites
          // Example: ApiServices.removeFromFavorites(widget.recipeId);
          print(
            "DELETE request: remove recipe ${widget.recipeId} from favorites",
          );
        }
      },
    );
  }
}
