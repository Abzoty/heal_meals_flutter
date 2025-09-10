import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/search_container.dart';
import '../widgets/filter_buttons_row.dart';
import '../widgets/added_item_tile.dart';
import '../widgets/suggestions_list.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';

class HealthProfilePage extends StatefulWidget {
  static const routeName = '/healthProfile';
  const HealthProfilePage({super.key});

  @override
  State<HealthProfilePage> createState() => _HealthProfilePageState();
}

enum FilterMode { all, allergies, diseases }

class _HealthProfilePageState extends State<HealthProfilePage> {
  // Built-in lists
  final List<String> allergies = [
    'Pollen',
    'Dust',
    'Peanuts',
    'Shellfish',
    'Pet dander',
    'Latex',
    'Insect sting',
  ];

  final List<String> diseases = [
    //Close keyboard on press of any buttons or empty space
    'Asthma',
    'Diabetes',
    'Hypertension',
    'Thyroid disorder',
    'Eczema',
    'Migraine',
    'Arthritis',
  ];

  // Combined for suggestion matching
  late final List<String> _allItems;

  // State
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<_AddedItem> _added = [];
  FilterMode _filter = FilterMode.all;
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _allItems = [...allergies, ...diseases];
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      // keep suggestions visible until text cleared or explicit collapse behavior desired
    });
  }

  void _onTextChanged() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    final matches = _allItems
        .where(
          (item) =>
              item.toLowerCase().contains(text.toLowerCase()) &&
              !_added
                  .map((a) => a.name.toLowerCase())
                  .contains(item.toLowerCase()),
        )
        .toList();

    setState(() {
      _suggestions = matches;
      _showSuggestions = matches.isNotEmpty;
    });
  }

  void _applySuggestion(String suggestion) {
    setState(() {
      _controller.text = suggestion;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: suggestion.length),
      );
      _showSuggestions = false;
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  bool _isBuiltIn(String text) {
    return _allItems.any((item) => item.toLowerCase() == text.toLowerCase());
  }

  String _getItemType(String text) {
    if (allergies.any((a) => a.toLowerCase() == text.toLowerCase())) {
      return 'Allergy';
    }
    if (diseases.any((d) => d.toLowerCase() == text.toLowerCase())) {
      return 'Disease';
    }
    return 'Unknown';
  }

  void _onAddPressed() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter an item to add.')));
      return;
    }

    if (!_isBuiltIn(text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No such item exists.'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    final normalized = _allItems.firstWhere(
      (i) => i.toLowerCase() == text.toLowerCase(),
    );
    if (_added.any((a) => a.name.toLowerCase() == normalized.toLowerCase())) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Already added.')));
      return;
    }

    setState(() {
      _added.add(_AddedItem(name: normalized, type: _getItemType(normalized)));
      _controller.clear();
      _suggestions = [];
      _showSuggestions = false;
    });
  }

  void _removeItem(_AddedItem item) {
    setState(() {
      _added.remove(item);
    });
  }

  List<_AddedItem> get _visibleItems {
    switch (_filter) {
      case FilterMode.all:
        return _added;
      case FilterMode.allergies:
        return _added.where((a) => a.type == 'Allergy').toList();
      case FilterMode.diseases:
        return _added.where((a) => a.type == 'Disease').toList();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Design colors
  final Color _bgPink = const Color(0xFFF6EDEE);
  final Color _accentGreen = const Color(0xFF1B512D);
  final Color _accentGreenDark = const Color(0xFF1B512D);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: _bgPink,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Health Profile',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search container (extracted widget)
              SearchContainer(
                controller: _controller,
                focusNode: _focusNode,
                onAddPressed: _onAddPressed,
                accentGreenDark: _accentGreenDark,
              ),

              // Suggestions
              SuggestionsList(
                visible: _showSuggestions,
                suggestions: _suggestions,
                onTapSuggestion: _applySuggestion,
                maxHeight: 200.h,
              ),

              SizedBox(height: 14.h),

              // Filter buttons row
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 8.w),
                child: FilterButtonsRow(
                  current: _filter,
                  onChanged: (mode) {
                    FocusScope.of(context).unfocus();
                    setState(() => _filter = mode);
                  },
                ),
              ),

              SizedBox(height: 12.h),

              // Items list
              // List inside a scrollable page
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _visibleItems.length,
                itemBuilder: (context, index) {
                  final item = _visibleItems[index];
                  return AddedItemTile(
                    name: item.name,
                    accentGreen: _accentGreen,
                    onRemove: () => _removeItem(item),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomNavBar(currentPage: 'profile'),
      ),
    );
  }
}

class _AddedItem {
  final String name;
  final String type; // Allergy | Disease

  _AddedItem({required this.name, required this.type});
}
