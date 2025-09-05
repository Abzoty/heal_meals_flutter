import 'package:flutter/material.dart';

class DiscoverFilterPanel extends StatelessWidget {
  final bool filtersOpen;
  final List<Map<String, List<String>>> filterDefinitions;
  final Map<String, Set<String>> selectedFilters;
  final void Function(String group, String value, bool selected) onChipTapped;

  const DiscoverFilterPanel({
    super.key,
    required this.filtersOpen,
    required this.filterDefinitions,
    required this.selectedFilters,
    required this.onChipTapped,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: filtersOpen
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: filterDefinitions.map((group) {
                  final title = group.keys.first;
                  final values = group.values.first;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: values.map((val) {
                            final selected = selectedFilters[title]!.contains(
                              val,
                            );
                            return FilterChip(
                              selected: selected,
                              label: Text(val),
                              onSelected: (s) => onChipTapped(title, val, s),
                              selectedColor: const Color(
                                0xFF25582B,
                              ).withValues(alpha: 0.25),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
