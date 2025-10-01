import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      'stars': '9',
      "id": "1"
    };
  });

  @override
  void initState() {
    super.initState();
    for (var group in _filterDefinitions) {
      final key = group.keys.first;
      _selectedFilters[key] = <String>{};
    }
  }

  void _toggleFilterOpen() {
    setState(() => _filtersOpen = !_filtersOpen);
  }

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

  /// 🔑 This is where you'll later put your GET request
  void _performSearch() {
    print("Search");
    // TODO: Replace with GET request using _searchController.text and _selectedFilters
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
                SizedBox(height: 22.h),
                DiscoverSearchBar(
                  controller: _searchController,
                  onSearch: _performSearch,
                ),
                SizedBox(height: 6.h),
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
