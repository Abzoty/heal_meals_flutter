import 'package:flutter/material.dart';

enum FilterMode { all, allergies, diseases }

class HealthProfileLogic {
  // Built-in lists of valid entries
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
    'Asthma',
    'Diabetes',
    'Hypertension',
    'Thyroid disorder',
    'Eczema',
    'Migraine',
    'Arthritis',
  ];

  late final List<String> _allItems;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final List<AddedItem> _added = [];
  FilterMode filter = FilterMode.all;
  List<String> suggestions = [];
  bool showSuggestions = false;

  HealthProfileLogic() {
    _allItems = [...allergies, ...diseases];
    controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = controller.text.trim();
    if (text.isEmpty) {
      suggestions = [];
      showSuggestions = false;
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

    suggestions = matches;
    showSuggestions = matches.isNotEmpty;
  }

  void applySuggestion(String suggestion) {
    controller.text = suggestion;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: suggestion.length),
    );
    showSuggestions = false;
    focusNode.requestFocus();
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

  String? onAddPressed(BuildContext context) {
    final text = controller.text.trim();
    if (text.isEmpty) {
      return 'Enter an item to add.';
    }

    if (!_isBuiltIn(text)) {
      return 'No such item exists.';
    }

    final normalized = _allItems.firstWhere(
      (i) => i.toLowerCase() == text.toLowerCase(),
    );

    if (_added.any((a) => a.name.toLowerCase() == normalized.toLowerCase())) {
      return 'Already added.';
    }

    _added.add(AddedItem(name: normalized, type: _getItemType(normalized)));
    controller.clear();
    suggestions = [];
    showSuggestions = false;

    return null; // success
  }

  void removeItem(AddedItem item) {
    _added.remove(item);
  }

  List<AddedItem> get visibleItems {
    switch (filter) {
      case FilterMode.all:
        return _added;
      case FilterMode.allergies:
        return _added.where((a) => a.type == 'Allergy').toList();
      case FilterMode.diseases:
        return _added.where((a) => a.type == 'Disease').toList();
    }
  }

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}

class AddedItem {
  final String name;
  final String type; // Allergy | Disease

  AddedItem({required this.name, required this.type});
}
