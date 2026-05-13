import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/validators.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final List<String> _countries = [
    'Ukraine',
    'Poland',
    'Germany',
    'USA',
    'UK',
  ];

  String? _selectedCountry;
  String? _selectedGender;
  DateTime? _birthDate;
  bool _agreeToTerms = false;
  bool _subscribeToNewsletter = false;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const Color _primaryPink = Color(0xFFE9AFC1);
  static const Color _lightPink = Color(0xFFF9EEF2);
  static const Color _darkText = Color(0xFF4A3F45);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your birth date')),
      );
      return;
    }

    if (_selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your country')),
      );
      return;
    }

    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your gender')),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms')),
      );
      return;
    }

    final user = User(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      birthDate: _birthDate!,
      country: _selectedCountry!,
      gender: _selectedGender!,
      subscribeToNewsletter: _subscribeToNewsletter,
    );

    _showSuccessDialog(user);
  }

  void _showSuccessDialog(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 30),
            SizedBox(width: 8),
            Expanded(child: Text('Registration Successful')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.fullName}!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _darkText,
              ),
            ),
            const SizedBox(height: 16),
            Text('Email: ${user.email}'),
            Text('Phone: ${user.phone}'),
            Text('Birth date: ${user.formattedBirthDate}'),
            Text('Country: ${user.country}'),
            Text('Gender: ${user.gender}'),
            Text('Age: ${user.age} years'),
            const SizedBox(height: 12),
            Text(
              'Verification email sent to ${user.email}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: _primaryPink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _darkText,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final birthDateText = _birthDate == null
        ? 'Select Birth Date'
        : '${_birthDate!.day.toString().padLeft(2, '0')}.'
            '${_birthDate!.month.toString().padLeft(2, '0')}.'
            '${_birthDate!.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Registration',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: _primaryPink.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _darkText,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Fill in your personal information to register.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              _buildSectionCard(
                title: 'Personal Information',
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) =>
                        Validators.requiredString(value, 'Name'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) => Validators.combine([
                      (v) => Validators.requiredString(v, 'Email'),
                      Validators.emailString,
                    ])(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      hintText: '380XXXXXXXXX',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (value) => Validators.combine([
                      (v) => Validators.requiredString(v, 'Phone'),
                      Validators.phoneUAString,
                    ])(value),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _selectDate,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE7D7DD)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              color: Colors.black54),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              birthDateText,
                              style: TextStyle(
                                fontSize: 16,
                                color: _birthDate == null
                                    ? Colors.black54
                                    : _darkText,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      prefixIcon: Icon(Icons.flag_outlined),
                    ),
                    items: _countries
                        .map(
                          (country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a country' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _darkText,
                    ),
                  ),
                  RadioListTile<String>(
                    activeColor: _primaryPink,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    activeColor: _primaryPink,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ],
              ),

              _buildSectionCard(
                title: 'Security',
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) => Validators.combine([
                      (v) => Validators.requiredString(v, 'Password'),
                      Validators.strongPasswordString,
                    ])(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              Card(
                child: Column(
                  children: [
                    CheckboxListTile(
                      activeColor: _primaryPink,
                      title: const Text('I agree to Terms and Conditions'),
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      activeColor: _primaryPink,
                      title: const Text('Subscribe to newsletter'),
                      value: _subscribeToNewsletter,
                      onChanged: (value) {
                        setState(() {
                          _subscribeToNewsletter = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _register,
                child: const Text('REGISTER'),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}