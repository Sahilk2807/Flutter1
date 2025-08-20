import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/gradient_app_bar.dart';
import '../../../shared/widgets/gradient_button.dart';

class ProfileCompletionScreen extends ConsumerStatefulWidget {
  const ProfileCompletionScreen({super.key});

  @override
  ConsumerState<ProfileCompletionScreen> createState() => _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends ConsumerState<ProfileCompletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  
  String? _selectedClass;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadExistingProfile();
  }

  void _loadExistingProfile() {
    final profile = ref.read(userProfileProvider);
    if (profile != null) {
      _nameController.text = profile.name ?? '';
      _mobileController.text = profile.mobile ?? '';
      _addressController.text = profile.address ?? '';
      _selectedClass = profile.userClass;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClass == null) {
      Fluttertoast.showToast(msg: 'Please select your class');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(userProfileProvider.notifier).updateProfile(
        name: _nameController.text.trim(),
        mobile: _mobileController.text.trim(),
        address: _addressController.text.trim(),
        userClass: _selectedClass!,
      );

      Fluttertoast.showToast(
        msg: 'Profile completed successfully!',
        backgroundColor: AppTheme.success,
      );
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
    final user = ref.watch(authProvider);
    
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Complete Your Profile',
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Message
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 48,
                        color: AppTheme.primaryOrange,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome ${user?.email ?? 'Student'}!',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please complete your profile to access all features.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Name is required';
                  if (value!.length > AppConstants.maxNameLength) {
                    return 'Name must be less than ${AppConstants.maxNameLength} characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Mobile Field
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number *',
                  prefixIcon: Icon(Icons.phone_outlined),
                  hintText: 'Enter your mobile number',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Mobile number is required';
                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value!)) {
                    return 'Enter a valid 10-digit mobile number';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Address Field
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Address *',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  hintText: 'Enter your complete address',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Address is required';
                  if (value!.length > AppConstants.maxAddressLength) {
                    return 'Address must be less than ${AppConstants.maxAddressLength} characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Class Dropdown
              DropdownButtonFormField<String>(
                value: _selectedClass,
                decoration: const InputDecoration(
                  labelText: 'Class *',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                items: AppConstants.classes.map((String className) {
                  return DropdownMenuItem<String>(
                    value: className,
                    child: Text(className),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() => _selectedClass = newValue);
                },
                validator: (value) {
                  if (value == null) return 'Please select your class';
                  return null;
                },
              ),
              
              const SizedBox(height: 32),
              
              // Save Button
              GradientButton(
                text: 'Complete Profile',
                onPressed: _saveProfile,
                isLoading: _isLoading,
                height: 56,
              ),
              
              const SizedBox(height: 16),
              
              // Sign Out Option
              TextButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).signOut();
                  ref.read(userProfileProvider.notifier).clearProfile();
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

