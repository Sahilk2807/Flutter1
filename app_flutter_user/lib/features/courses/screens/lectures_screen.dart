import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/gradient_app_bar.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import '../widgets/lecture_card.dart';
import '../widgets/subject_filter_chips.dart';

class LecturesScreen extends ConsumerStatefulWidget {
  const LecturesScreen({super.key});

  @override
  ConsumerState<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends ConsumerState<LecturesScreen> {
  String _selectedSubject = 'All Subjects';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLectures();
  }

  Future<void> _loadLectures() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Free Lectures',
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement search
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Watch and learn anytime',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ),
          
          // Subject Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SubjectFilterChips(
              subjects: AppConstants.subjects.take(4).toList(),
              selectedSubject: _selectedSubject,
              onSubjectSelected: (subject) {
                setState(() => _selectedSubject = subject);
                _loadLectures();
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lectures List
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _buildLecturesList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Content',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed(AppConstants.homeRoute);
              break;
            case 1:
              // Already on lectures
              break;
            case 2:
              Navigator.of(context).pushReplacementNamed(AppConstants.coursesRoute);
              break;
            case 3:
              // TODO: Navigate to settings
              break;
          }
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: LoadingShimmer(
        isLoading: true,
        child: Column(
          children: [
            ShimmerCard(height: 200),
            SizedBox(height: 16),
            ShimmerCard(height: 200),
            SizedBox(height: 16),
            ShimmerCard(height: 200),
          ],
        ),
      ),
    );
  }

  Widget _buildLecturesList() {
    // Mock lecture data
    final lectures = [
      {
        'title': 'Quadratic Equations - Part 1',
        'subject': 'Mathematics',
        'duration': '45 min',
        'views': '12.5k',
        'thumbnail': 'assets/images/math_lecture.png',
        'isWatched': false,
      },
      {
        'title': 'Laws of Motion',
        'subject': 'Physics',
        'duration': '38 min',
        'views': '8.2k',
        'thumbnail': 'assets/images/physics_lecture.png',
        'isWatched': true,
      },
      {
        'title': 'Periodic Table',
        'subject': 'Chemistry',
        'duration': '52 min',
        'views': '15.7k',
        'thumbnail': 'assets/images/chemistry_lecture.png',
        'isWatched': false,
      },
      {
        'title': 'Cell Structure and Function',
        'subject': 'Biology',
        'duration': '41 min',
        'views': '9.8k',
        'thumbnail': 'assets/images/biology_lecture.png',
        'isWatched': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final lecture = lectures[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: LectureCard(
            title: lecture['title'] as String,
            subject: lecture['subject'] as String,
            duration: lecture['duration'] as String,
            views: lecture['views'] as String,
            isWatched: lecture['isWatched'] as bool,
            onTap: () {
              // TODO: Navigate to video player
            },
          ),
        );
      },
    );
  }
}

