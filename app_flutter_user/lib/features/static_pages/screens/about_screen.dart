import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/gradient_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'About Us',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo and Title
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 50,
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Empowering Students for Success',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // About Section
            _buildSection(
              context,
              'Our Mission',
              'GP SIR EDUCATION is dedicated to providing high-quality education to students preparing for MP Board examinations. We believe in making learning accessible, engaging, and effective for every student.',
            ),
            
            _buildSection(
              context,
              'What We Offer',
              '• Comprehensive video lectures by experienced teachers\n'
              '• Interactive study materials and practice tests\n'
              '• Live doubt-solving sessions\n'
              '• Regular assessments and progress tracking\n'
              '• Affordable premium courses with lifetime access',
            ),
            
            _buildSection(
              context,
              'Our Vision',
              'To become the leading educational platform for MP Board students, helping them achieve their academic goals and build a strong foundation for their future careers.',
            ),
            
            const SizedBox(height: 32),
            
            // Contact Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get in Touch',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildContactItem(
                      context,
                      Icons.email_outlined,
                      'Email',
                      AppConstants.supportEmail,
                      () => _launchEmail(),
                    ),
                    const SizedBox(height: 12),
                    _buildContactItem(
                      context,
                      Icons.phone_outlined,
                      'Phone',
                      AppConstants.supportPhone,
                      () => _launchPhone(),
                    ),
                    const SizedBox(height: 12),
                    _buildContactItem(
                      context,
                      Icons.language_outlined,
                      'Website',
                      AppConstants.websiteUrl,
                      () => _launchWebsite(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Social Media
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Us',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSocialButton(
                          context,
                          Icons.facebook,
                          'Facebook',
                          () => _launchUrl(AppConstants.facebookUrl),
                        ),
                        _buildSocialButton(
                          context,
                          Icons.play_arrow,
                          'YouTube',
                          () => _launchUrl(AppConstants.youtubeUrl),
                        ),
                        _buildSocialButton(
                          context,
                          Icons.camera_alt,
                          'Instagram',
                          () => _launchUrl(AppConstants.instagramUrl),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // App Version
            Center(
              child: Text(
                'Version ${AppConstants.appVersion}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: AppTheme.primaryOrange,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryOrange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: AppTheme.primaryOrange,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.primaryOrange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      query: 'subject=Support Request',
    );
    await _launchUrl(emailUri.toString());
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: AppConstants.supportPhone,
    );
    await _launchUrl(phoneUri.toString());
  }

  Future<void> _launchWebsite() async {
    await _launchUrl(AppConstants.websiteUrl);
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

