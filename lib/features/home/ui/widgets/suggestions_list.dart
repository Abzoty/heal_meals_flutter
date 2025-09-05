import 'package:flutter/material.dart';

class SuggestionsList extends StatelessWidget {
  final bool visible;
  final List<String> suggestions;
  final ValueChanged<String> onTapSuggestion;
  final double maxHeight;

  const SuggestionsList({
    super.key,
    required this.visible,
    required this.suggestions,
    required this.onTapSuggestion,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final s = suggestions[index];
            return InkWell(
              onTap: () => onTapSuggestion(s),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  s,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
