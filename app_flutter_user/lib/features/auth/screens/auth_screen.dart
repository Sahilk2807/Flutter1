import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/gradient_button.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  
  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailLinkController = TextEditingController();
  
  bool _isSignInLoading = false;
  bool _isSignUpLoading = false;
  bool _isGoogleLoading = false;
  bool _isEmailLinkLoading = false;
  bool _obscureSignInPassword = true;
  bool _obscureSignUpPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    _emailLinkController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    if (!_signInFormKey.currentState!.validate()) return;
    
    setState(() => _isSignInLoading = true);
    
    try {
      await ref.read(authProvider.notifier).signInWithEmail(
        _signInEmailController.text.trim(),
        _signInPasswordController.text,
      );
      
      Fluttertoast.showToast(message: 'Signed in successfully!');
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppTheme.error,
      );
    } finally {
      if (mounted) setState(() => _isSignInLoading = false);
    }
  }

  Future<void> _signUpWithEmail() async {
    if (!_signUpFormKey.currentState!.validate()) return;
    
    setState(() => _isSignUpLoading = true);
    
    try {
      await ref.read(authProvider.notifier).signUpWithEmail(
        _signUpEmailController.text.trim(),
        _signUpPasswordController.text,
      );
      
      Fluttertoast.showToast(message: 'Account created successfully!');
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppTheme.error,
      );
    } finally {
      if (mounted) setState(() => _isSignUpLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    
    try {
      await ref.read(authProvider.notifier).signInWithGoogle();
      Fluttertoast.showToast(message: 'Signed in with Google!');
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppTheme.error,
      );
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  Future<void> _signInWithEmailLink() async {
    if (_emailLinkController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter your email');
      return;
    }
    
    setState(() => _isEmailLinkLoading = true);
    
    try {
      await ref.read(authProvider.notifier).signInWithEmailLink(
        _emailLinkController.text.trim(),
      );
      
      Fluttertoast.showToast(
        msg: 'Sign-in link sent to your email!',
        backgroundColor: AppTheme.success,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppTheme.error,
      );
    } finally {
      if (mounted) setState(() => _isEmailLinkLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.school,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome to',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      AppConstants.appName,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Auth Forms
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Tab Bar
                      Container(
                        margin: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: AppTheme.primaryOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: AppTheme.onSurfaceVariant,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'Sign In'),
                            Tab(text: 'Sign Up'),
                            Tab(text: 'Email Link'),
                          ],
                        ),
                      ),
                      
                      // Tab Views
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildSignInForm(),
                            _buildSignUpForm(),
                            _buildEmailLinkForm(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _signInFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _signInEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Email is required';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _signInPasswordController,
              obscureText: _obscureSignInPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(_obscureSignInPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscureSignInPassword = !_obscureSignInPassword),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Password is required';
                if (value!.length < AppConstants.minPasswordLength) {
                  return 'Password must be at least ${AppConstants.minPasswordLength} characters';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 24),
            
            GradientButton(
              text: 'Sign In',
              onPressed: _signInWithEmail,
              isLoading: _isSignInLoading,
            ),
            
            const SizedBox(height: 16),
            
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            
            const SizedBox(height: 16),
            
            OutlinedButton.icon(
              onPressed: _isGoogleLoading ? null : _signInWithGoogle,
              icon: _isGoogleLoading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.login),
              label: const Text('Continue with Google'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _signUpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _signUpEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Email is required';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _signUpPasswordController,
              obscureText: _obscureSignUpPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(_obscureSignUpPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscureSignUpPassword = !_obscureSignUpPassword),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Password is required';
                if (value!.length < AppConstants.minPasswordLength) {
                  return 'Password must be at least ${AppConstants.minPasswordLength} characters';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please confirm your password';
                if (value != _signUpPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 24),
            
            GradientButton(
              text: 'Create Account',
              onPressed: _signUpWithEmail,
              isLoading: _isSignUpLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailLinkForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.email_outlined,
            size: 64,
            color: AppTheme.primaryOrange,
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Passwordless Sign In',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Enter your email and we\'ll send you a secure link to sign in.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          TextFormField(
            controller: _emailLinkController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          
          const SizedBox(height: 24),
          
          GradientButton(
            text: 'Send Sign-in Link',
            onPressed: _signInWithEmailLink,
            isLoading: _isEmailLinkLoading,
          ),
        ],
      ),
    );
  }
}

