import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SubjectFilterChips extends StatelessWidget {
  final List<String> subjects;
  final String selectedSubject;
  final Function(String) onSubjectSelected;

  const SubjectFilterChips({
    super.key,
    required this.subjects,
    required this.selectedSubject,
    required this.onSubjectSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final isSelected = subject == selectedSubject;
          
          return Padding(
            padding: EdgeInsets.only(
              right: index < subjects.length - 1 ? 12 : 0,
            ),
            child: FilterChip(
              label: Text(subject),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onSubjectSelected(subject);
                }
              },
              backgroundColor: AppTheme.chipUnselectedBackground,
              selectedColor: AppTheme.chipSelectedBackground,
              labelStyle: TextStyle(
                color: isSelected 
                    ? AppTheme.chipSelectedText 
                    : AppTheme.chipUnselectedText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}

