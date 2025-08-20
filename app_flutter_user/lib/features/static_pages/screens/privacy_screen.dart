import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/gradient_app_bar.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Privacy Policy',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.privacy_tip_outlined,
                    size: 64,
                    color: AppTheme.primaryOrange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Privacy Policy',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last updated: ${DateTime.now().year}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Privacy Policy Content
            _buildSection(
              context,
              'Introduction',
              'GP SIR EDUCATION ("we", "our", or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and services.',
            ),
            
            _buildSection(
              context,
              'Information We Collect',
              'We may collect the following types of information:\n\n'
              '• Personal Information: Name, email address, phone number, and address\n'
              '• Educational Information: Class, subjects, academic progress\n'
              '• Usage Data: App usage patterns, course completion, time spent\n'
              '• Device Information: Device type, operating system, unique device identifiers\n'
              '• Communication Data: Messages sent through our contact forms',
            ),
            
            _buildSection(
              context,
              'How We Use Your Information',
              'We use the collected information for:\n\n'
              '• Providing and maintaining our educational services\n'
              '• Personalizing your learning experience\n'
              '• Communicating with you about courses and updates\n'
              '• Improving our app and services\n'
              '• Ensuring security and preventing fraud\n'
              '• Complying with legal obligations',
            ),
            
            _buildSection(
              context,
              'Information Sharing',
              'We do not sell, trade, or rent your personal information to third parties. We may share your information only in the following circumstances:\n\n'
              '• With your explicit consent\n'
              '• To comply with legal requirements\n'
              '• To protect our rights and safety\n'
              '• With trusted service providers who assist in our operations',
            ),
            
            _buildSection(
              context,
              'Data Security',
              'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.',
            ),
            
            _buildSection(
              context,
              'Your Rights',
              'You have the right to:\n\n'
              '• Access your personal information\n'
              '• Correct inaccurate information\n'
              '• Delete your account and data\n'
              '• Opt-out of marketing communications\n'
              '• Data portability',
            ),
            
            _buildSection(
              context,
              'Cookies and Tracking',
              'We may use cookies and similar tracking technologies to enhance your experience. You can control cookie settings through your device or browser settings.',
            ),
            
            _buildSection(
              context,
              'Children\'s Privacy',
              'Our services are intended for students of all ages. For users under 13, we require parental consent before collecting personal information. We are committed to protecting children\'s privacy in accordance with applicable laws.',
            ),
            
            _buildSection(
              context,
              'Changes to This Policy',
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.',
            ),
            
            _buildSection(
              context,
              'Contact Us',
              'If you have any questions about this Privacy Policy, please contact us at:\n\n'
              'Email: ${AppConstants.supportEmail}\n'
              'Phone: ${AppConstants.supportPhone}\n'
              'Website: ${AppConstants.websiteUrl}',
            ),
            
            const SizedBox(height: 32),
            
            // Consent Section
            Card(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 32,
                      color: AppTheme.primaryOrange,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your Privacy Matters',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'By using our app, you acknowledge that you have read and understood this Privacy Policy and agree to our data practices.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
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
}

