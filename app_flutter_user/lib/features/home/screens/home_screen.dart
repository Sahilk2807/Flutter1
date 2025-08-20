import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/gradient_app_bar.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/stats_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Dashboard',
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GradientButton(
              text: 'Go Live',
              onPressed: () {
                // TODO: Implement live class functionality
              },
              width: 80,
              height: 36,
              borderRadius: 18,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
                      child: Text(
                        (profile?.name?.isNotEmpty == true) 
                            ? profile!.name![0].toUpperCase()
                            : 'S',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primaryOrange,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            profile?.name ?? 'Student',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (profile?.userClass != null)
                            Text(
                              profile!.userClass!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.primaryOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Navigate to profile settings
                      },
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Total Courses',
                    value: '12',
                    icon: Icons.book_outlined,
                    color: AppTheme.info,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatsCard(
                    title: 'Completed',
                    value: '8',
                    icon: Icons.check_circle_outline,
                    color: AppTheme.success,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Hours Studied',
                    value: '45',
                    icon: Icons.access_time,
                    color: AppTheme.warning,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatsCard(
                    title: 'Certificates',
                    value: '3',
                    icon: Icons.emoji_events_outlined,
                    color: AppTheme.primaryOrange,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                QuickActionTile(
                  title: 'Free Lectures',
                  icon: Icons.play_circle_outline,
                  backgroundColor: AppTheme.contentTileBackground,
                  iconColor: AppTheme.contentTileIcon,
                  onTap: () => context.go(AppConstants.lecturesRoute),
                ),
                QuickActionTile(
                  title: 'Premium Courses',
                  icon: Icons.school_outlined,
                  backgroundColor: AppTheme.usersTileBackground,
                  iconColor: AppTheme.usersTileIcon,
                  onTap: () => context.go(AppConstants.coursesRoute),
                ),
                QuickActionTile(
                  title: 'Study Materials',
                  icon: Icons.library_books_outlined,
                  backgroundColor: AppTheme.paymentsTileBackground,
                  iconColor: AppTheme.paymentsTileIcon,
                  onTap: () {
                    // TODO: Navigate to study materials
                  },
                ),
                QuickActionTile(
                  title: 'Practice Tests',
                  icon: Icons.quiz_outlined,
                  backgroundColor: AppTheme.notificationsTileBackground,
                  iconColor: AppTheme.notificationsTileIcon,
                  onTap: () {
                    // TODO: Navigate to practice tests
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Recent Activity
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.success.withOpacity(0.1),
                      child: const Icon(
                        Icons.check_circle,
                        color: AppTheme.success,
                      ),
                    ),
                    title: const Text('Completed Mathematics Chapter 1'),
                    subtitle: const Text('2 hours ago'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.info.withOpacity(0.1),
                      child: const Icon(
                        Icons.play_circle,
                        color: AppTheme.info,
                      ),
                    ),
                    title: const Text('Watched Physics Lecture'),
                    subtitle: const Text('Yesterday'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.warning.withOpacity(0.1),
                      child: const Icon(
                        Icons.quiz,
                        color: AppTheme.warning,
                      ),
                    ),
                    title: const Text('Attempted Chemistry Quiz'),
                    subtitle: const Text('2 days ago'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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
              // Already on dashboard
              break;
            case 1:
              context.go(AppConstants.lecturesRoute);
              break;
            case 2:
              context.go(AppConstants.coursesRoute);
              break;
            case 3:
              // TODO: Navigate to settings
              break;
          }
        },
      ),
    );
  }
}

