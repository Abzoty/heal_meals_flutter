import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/home/data/repositories/condition_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/search_container.dart';
import '../widgets/filter_buttons_row.dart';
import '../widgets/added_item_tile.dart';
import '../widgets/suggestions_list.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/logic/cubit/condition_cubit.dart';
import 'package:heal_meals/features/home/data/models/condition_model.dart';
import 'package:heal_meals/features/home/data/models/user_condition_model.dart';

class HealthProfilePage extends StatefulWidget {
  static const routeName = '/healthProfile';
  const HealthProfilePage({super.key});

  @override
  State<HealthProfilePage> createState() => _HealthProfilePageState();
}

// Wrapper widget that provides the cubit
class HealthProfileWrapper extends StatelessWidget {
  static const routeName = '/healthProfile';

  const HealthProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConditionCubit(conditionRepo: getIt<ConditionRepo>()),
      child: const HealthProfilePage(),
    );
  }
}

enum FilterMode { all, allergies, diseases }

class _HealthProfilePageState extends State<HealthProfilePage> {
  // Lists populated from API
  List<ConditionModel> _allConditions = [];
  // ignore: unused_field
  List<ConditionModel> _allergies = [];
  // ignore: unused_field
  List<ConditionModel> _diseases = [];
  List<UserConditionModel> _userConditions = [];

  // State
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  FilterMode _filter = FilterMode.all;
  List<ConditionModel> _suggestions = [];
  bool _showSuggestions = false;

  Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return '';
    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    final user = UserProfileModel.fromJson(userMap);
    return user.userId;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    // Fetch initial data
    // context.read<ConditionCubit>().getAllConditions();
    // context.read<ConditionCubit>().getUserConditions();
  }

  void _populateConditionLists(List<ConditionModel> conditions) {
    _allConditions = conditions;
    _allergies = conditions
        .where((c) => c.conditionType.toLowerCase() == 'allergy')
        .toList();
    _diseases = conditions
        .where((c) => c.conditionType.toLowerCase() == 'disease')
        .toList();
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

    // Get condition IDs that are already added by the user
    final addedConditionIds = _userConditions
        .map((uc) => uc.userConditionId)
        .toSet();

    final matches = _allConditions
        .where(
          (condition) =>
              condition.conditionName.toLowerCase().contains(
                text.toLowerCase(),
              ) &&
              !addedConditionIds.contains(condition.conditionId),
        )
        .toList();

    setState(() {
      _suggestions = matches;
      _showSuggestions = matches.isNotEmpty;
    });
  }

  void _applySuggestion(ConditionModel condition) {
    setState(() {
      _controller.text = condition.conditionName;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: condition.conditionName.length),
      );
      _showSuggestions = false;
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  ConditionModel? _findConditionByName(String name) {
    try {
      return _allConditions.firstWhere(
        (condition) =>
            condition.conditionName.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> _onAddPressed() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      _showSnackBar('Enter a condition to add.');
      return;
    }

    final condition = _findConditionByName(text);
    if (condition == null) {
      _showSnackBar('No such condition exists.');
      return;
    }

    // Check if already added
    if (_userConditions.any((uc) => uc.conditionId == condition.conditionId)) {
      _showSnackBar('Condition already added.');
      return;
    }

    // Add condition via Cubit
    context.read<ConditionCubit>().addUserCondition(
      await _getUserId(),
      condition.conditionId,
    );

    setState(() {
      _controller.clear();
      _suggestions = [];
      _showSuggestions = false;
    });
  }

  void _removeUserCondition(String userConditionId) {
    context.read<ConditionCubit>().deleteUserCondition(userConditionId);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  List<UserConditionModel> get _visibleUserConditions {
    if (_userConditions.isEmpty) return [];

    // Create a lookup map from conditionId -> ConditionModel
    final allConditionsMap = {
      for (var condition in _allConditions) condition.conditionId: condition,
    };

    switch (_filter) {
      case FilterMode.all:
        return List<UserConditionModel>.from(
          _userConditions,
        ); // force materialization

      case FilterMode.allergies:
        return _userConditions
            .where(
              (uc) =>
                  (allConditionsMap[uc.conditionId]?.conditionType
                          .toLowerCase() ??
                      '') ==
                  'allergy',
            )
            .toList(); // ensures eager evaluation

      case FilterMode.diseases:
        return _userConditions
            .where(
              (uc) =>
                  (allConditionsMap[uc.conditionId]?.conditionType
                          .toLowerCase() ??
                      '') ==
                  'disease',
            )
            .toList(); // ensures eager evaluation
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
          title: Text(
            'Health Profile',
            style: TextStyle(color: Colors.black87, fontSize: 28.sp),
          ),
        ),
        body: BlocConsumer<ConditionCubit, ConditionState>(
          listener: (context, state) {
            if (state is ConditionError) {
              _showSnackBar('Error: ${state.message}');
            }
          },
          builder: (context, state) {
            // Handle different states
            if (state is ConditionLoading && _allConditions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF1B512D)),
              );
            }

            // Update data when loaded
            if (state is ConditionAllLoaded) {
              _populateConditionLists(state.conditions);
            } else if (state is ConditionUserLoaded) {
              _userConditions = state.userConditions;
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Search container
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: SearchContainer(
                      controller: _controller,
                      focusNode: _focusNode,
                      onAddPressed: _onAddPressed,
                      accentGreenDark: _accentGreenDark,
                    ),
                  ),

                  // Suggestions
                  if (_showSuggestions)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SuggestionsList(
                        visible: _showSuggestions,
                        suggestions: _suggestions
                            .map((c) => c.conditionName)
                            .toList(),
                        onTapSuggestion: (suggestionName) {
                          final condition = _suggestions.firstWhere(
                            (c) => c.conditionName == suggestionName,
                          );
                          _applySuggestion(condition);
                        },
                        maxHeight: 200.h,
                      ),
                    ),

                  // Filter buttons row
                  Padding(
                    padding: EdgeInsets.only(left: 36.w, right: 36.w),
                    child: FilterButtonsRow(
                      current: _filter,
                      onChanged: (mode) {
                        FocusScope.of(context).unfocus();
                        setState(() => _filter = mode);
                      },
                    ),
                  ),

                  // Loading indicator for operations
                  if (state is ConditionLoading && _allConditions.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(16.w),
                      child: const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF1B512D),
                          ),
                        ),
                      ),
                    ),

                  // User conditions list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _visibleUserConditions.length,
                    itemBuilder: (context, index) {
                      final userCondition = _visibleUserConditions[index];
                      return AddedItemTile(
                        name: userCondition.userConditionName,
                        accentGreen: _accentGreen,
                        onRemove: () =>
                            _removeUserCondition(userCondition.userConditionId),
                      );
                    },
                  ),

                  // Empty state message
                  if (_visibleUserConditions.isEmpty &&
                      _allConditions.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(32.w),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.health_and_safety_outlined,
                              size: 48.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              _filter == FilterMode.all
                                  ? 'No conditions added yet'
                                  : 'No ${_filter.name} added yet',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Bottom padding for scroll
                  SizedBox(height: 100.h),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: const CustomNavBar(currentPage: 'profile'),
      ),
    );
  }
}
