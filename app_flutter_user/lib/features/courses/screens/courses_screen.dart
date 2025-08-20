import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/gradient_app_bar.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import '../widgets/course_card.dart';
import '../widgets/subject_filter_chips.dart';

class CoursesScreen extends ConsumerStatefulWidget {
  const CoursesScreen({super.key});

  @override
  ConsumerState<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  String _selectedSubject = 'All Courses';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
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
        title: 'Courses',
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Wallet: ₹0.00',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Add Money',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Subject Filter
          Container(
            padding: const EdgeInsets.all(16),
            child: SubjectFilterChips(
              subjects: const ['All Courses', 'Featured', 'Mathematics', 'Science'],
              selectedSubject: _selectedSubject,
              onSubjectSelected: (subject) {
                setState(() => _selectedSubject = subject);
                _loadCourses();
              },
            ),
          ),
          
          // Courses List
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _buildCoursesGrid(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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
              Navigator.of(context).pushReplacementNamed(AppConstants.lecturesRoute);
              break;
            case 2:
              // Already on courses
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
        child: ShimmerGrid(
          itemCount: 6,
          crossAxisCount: 1,
          childAspectRatio: 2.5,
        ),
      ),
    );
  }

  Widget _buildCoursesGrid() {
    // Mock course data
    final courses = [
      {
        'title': 'Complete Mathematics Course',
        'description': 'Master all mathematics concepts for MP Board',
        'price': '₹999',
        'originalPrice': '₹1999',
        'duration': '6 months',
        'lessons': '120 lessons',
        'rating': 4.8,
        'students': '2.5k',
        'image': 'assets/images/math_course.png',
      },
      {
        'title': 'Physics Fundamentals',
        'description': 'Complete physics course with practical examples',
        'price': '₹799',
        'originalPrice': '₹1599',
        'duration': '4 months',
        'lessons': '80 lessons',
        'rating': 4.7,
        'students': '1.8k',
        'image': 'assets/images/physics_course.png',
      },
      {
        'title': 'Chemistry Mastery',
        'description': 'Comprehensive chemistry course for board exams',
        'price': '₹899',
        'originalPrice': '₹1799',
        'duration': '5 months',
        'lessons': '100 lessons',
        'rating': 4.9,
        'students': '3.2k',
        'image': 'assets/images/chemistry_course.png',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CourseCard(
            title: course['title'] as String,
            description: course['description'] as String,
            price: course['price'] as String,
            originalPrice: course['originalPrice'] as String,
            duration: course['duration'] as String,
            lessons: course['lessons'] as String,
            rating: course['rating'] as double,
            students: course['students'] as String,
            onTap: () {
              // TODO: Navigate to course details
            },
          ),
        );
      },
    );
  }
}

