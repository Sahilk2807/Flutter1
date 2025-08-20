import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/services/api_service.dart';
import '../../../shared/widgets/gradient_app_bar.dart';
import '../../../shared/widgets/gradient_button.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ApiService.submitContact(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );

      Fluttertoast.showToast(
        msg: 'Message sent successfully! We\'ll get back to you soon.',
        backgroundColor: AppTheme.success,
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppTheme.error,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Contact Us',
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
                    Icons.support_agent,
                    size: 64,
                    color: AppTheme.primaryOrange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Get in Touch',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Contact Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name *',
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: 'Enter your full name',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Name is required';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address *',
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Enter your email address',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Email is required';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Message *',
                      prefixIcon: Icon(Icons.message_outlined),
                      hintText: 'Tell us how we can help you...',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Message is required';
                      if (value!.length < 10) return 'Message must be at least 10 characters';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  GradientButton(
                    text: 'Send Message',
                    onPressed: _submitContact,
                    isLoading: _isLoading,
                    height: 56,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Alternative Contact Methods
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Ways to Reach Us',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildContactMethod(
                      context,
                      Icons.email_outlined,
                      'Email Support',
                      'support@gpsireducation.com',
                      'We typically respond within 24 hours',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildContactMethod(
                      context,
                      Icons.phone_outlined,
                      'Phone Support',
                      '+91-9876543210',
                      'Available Mon-Fri, 9 AM - 6 PM',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildContactMethod(
                      context,
                      Icons.chat_outlined,
                      'Live Chat',
                      'Available on website',
                      'Instant support during business hours',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // FAQ Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildFAQItem(
                      context,
                      'How do I access premium courses?',
                      'You can purchase premium courses from the Courses section. Once purchased, you\'ll have lifetime access.',
                    ),
                    
                    _buildFAQItem(
                      context,
                      'Can I download lectures for offline viewing?',
                      'Yes, premium course lectures can be downloaded for offline viewing through our mobile app.',
                    ),
                    
                    _buildFAQItem(
                      context,
                      'Do you provide study materials?',
                      'Yes, we provide comprehensive study materials, practice tests, and notes for all subjects.',
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

  Widget _buildContactMethod(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.primaryOrange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryOrange,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

