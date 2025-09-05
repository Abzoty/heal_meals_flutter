import 'package:flutter/material.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/filter_button.dart';
import 'package:heal_meals/features/home/ui/widgets/filter_panel.dart';
import 'package:heal_meals/features/home/ui/widgets/results_section.dart';
import 'package:heal_meals/features/home/ui/widgets/search_bar.dart';


class DiscoverPage extends StatefulWidget {
  static const routeName = '/discover';
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _filtersOpen = false;

  final List<Map<String, List<String>>> _filterDefinitions = [
    {
      'Type': ['Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Snack'],
    },
    {
      'Diseases': [
        'Diabetes',
        'Heart Failure',
        'Arthritis',
        'Obesity',
        'Cancer',
        'COPD',
        'Stroke',
      ],
    },
    {
      'Sort By': ['Relevance', 'Rating', 'Newest'],
    },
    {
      'Duration': ['Under 10 minutes', '10 - 20 minutes', 'Over 20 minutes'],
    },
    {
      'Allergies': [
        'Milk',
        'Eggs',
        'Fish',
        'Crustacean shellfish',
        'Tree nuts',
        'Peanuts',
        'Wheat',
        'Soybeans',
        'Sesame',
      ],
    },
  ];

  final Map<String, Set<String>> _selectedFilters = {};

  final List<Map<String, String>> _sampleRecipes = List.generate(6, (i) {
    return {
      'imageUrl': 'assets/images/food.jpg',
      'title': 'Grilled Chicken Salad',
      'description': 'A quick description about the recipe, and other text.',
    };
  });

  @override
  // initializing the selected filters to empty
  void initState() {
    super.initState();
    for (var group in _filterDefinitions) {
      final key = group.keys.first;
      _selectedFilters[key] = <String>{};
    }
  }

  // toggle the filter panel boolean
  void _toggleFilterOpen() {
    setState(() => _filtersOpen = !_filtersOpen);
  }

  // update the selected filters, and only one option from "sort by" & "duration" can be selected
  void _onChipTapped(String group, String value, bool selected) {
    setState(() {
      if (group == 'Sort By' || group == 'Duration') {
        _selectedFilters[group]!.clear();
        if (selected) _selectedFilters[group]!.add(value);
      } else {
        final set = _selectedFilters[group]!;
        if (selected) {
          set.add(value);
        } else {
          set.remove(value);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 22),
                DiscoverSearchBar(
                  controller: _searchController,
                  onSubmitted: (q) {
                    // TODO: wire search logic
                  },
                ),
                const SizedBox(height: 6),
                DiscoverFilterButton(onPressed: _toggleFilterOpen),
                DiscoverFilterPanel(
                  filtersOpen: _filtersOpen,
                  filterDefinitions: _filterDefinitions,
                  selectedFilters: _selectedFilters,
                  onChipTapped: _onChipTapped,
                ),
                DiscoverResultsSection(recipes: _sampleRecipes),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomNavBar(currentPage: 'discover'),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

