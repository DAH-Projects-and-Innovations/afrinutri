// lib/features/auth/presentation/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/network/api_client.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String _sexe = 'Homme';
  DateTime? _birthDate;
  String _activityLevel = 'moderate';
  String _goal = 'maintain';

  bool _isLoading = false;
  String? _error;

  static const _activityLevels = {
    'sedentary': 'Sédentaire (peu ou pas d\'exercice)',
    'light': 'Léger (1-2 séances / semaine)',
    'moderate': 'Modéré (3-4 séances / semaine)',
    'active': 'Actif (5-6 séances / semaine)',
    'very_active': 'Très actif (sport intense quotidien)',
  };

  static const _goals = {
    'lose': 'Perdre du poids',
    'maintain': 'Maintenir mon poids',
    'gain': 'Prendre du poids',
  };

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20, now.month, now.day),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
      helpText: 'Date de naissance',
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  String get _birthDateLabel {
    if (_birthDate == null) return '';
    final d = _birthDate!;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null) {
      setState(() => _error = 'Merci de renseigner ta date de naissance.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await apiClient.post(
        '/auth/register',
        data: {
          'first_name': _firstNameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'sex': _sexe == 'Homme' ? 'M' : 'F',
          'birth_date':
              '${_birthDate!.year.toString().padLeft(4, '0')}-${_birthDate!.month.toString().padLeft(2, '0')}-${_birthDate!.day.toString().padLeft(2, '0')}',
          'height_cm': num.tryParse(_heightController.text.trim()),
          'weight_kg': num.tryParse(_weightController.text.trim()),
          'activity_level': _activityLevel,
          'goal': _goal,
        },
      );

      final token = response.data['access_token'] as String;
      await apiClient.saveToken(token);

      if (mounted) context.go(AppRoutes.home);
    } catch (e) {
      setState(() {
        _error = 'Impossible de créer le compte. Vérifie tes informations.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
            color: AppColors.primaryDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.eco,
                          color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Bienvenue sur AfriNutri',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Crée ton compte et obtiens ton objectif calorique personnalisé.',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 13),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tabs Connexion / Inscription
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.go(AppRoutes.login),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Connexion',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 0.5,
                                ),
                              ),
                              child: const Text(
                                'Inscription',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    if (_error != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEEBEB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    const Text('Prénom', style: _labelStyle),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _firstNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(hintText: 'Horace'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Requis' : null,
                    ),
                    const SizedBox(height: 16),

                    const Text('Email', style: _labelStyle),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: 'toi@exemple.com'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Requis';
                        if (!v.contains('@')) return 'Email invalide';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    const Text('Mot de passe', style: _labelStyle),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: '••••••••'),
                      validator: (v) => (v == null || v.length < 6)
                          ? '6 caractères minimum'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'POUR CALCULER TON OBJECTIF CALORIQUE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sexe', style: _labelStyle),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                initialValue: _sexe,
                                decoration: const InputDecoration(),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Homme', child: Text('Homme')),
                                  DropdownMenuItem(
                                      value: 'Femme', child: Text('Femme')),
                                ],
                                onChanged: (v) =>
                                    setState(() => _sexe = v ?? _sexe),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Naissance', style: _labelStyle),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: _pickBirthDate,
                                child: InputDecorator(
                                  decoration: const InputDecoration(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _birthDate == null
                                            ? 'jj/mm/aaaa'
                                            : _birthDateLabel,
                                        style: TextStyle(
                                          color: _birthDate == null
                                              ? const Color(0xFF9CA3AF)
                                              : AppColors.textPrimary,
                                        ),
                                      ),
                                      const Icon(Icons.calendar_today_outlined,
                                          size: 16,
                                          color: AppColors.textSecondary),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Taille (cm)', style: _labelStyle),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(hintText: '170'),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Requis'
                                        : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Poids (kg)', style: _labelStyle),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(hintText: '65'),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Requis'
                                        : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text('Niveau d\'activité', style: _labelStyle),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _activityLevel,
                      decoration: const InputDecoration(),
                      items: _activityLevels.entries
                          .map((e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(e.value,
                                    overflow: TextOverflow.ellipsis),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _activityLevel = v ?? _activityLevel),
                    ),
                    const SizedBox(height: 16),

                    const Text('Objectif', style: _labelStyle),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _goal,
                      decoration: const InputDecoration(),
                      items: _goals.entries
                          .map((e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(e.value),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _goal = v ?? _goal),
                    ),
                    const SizedBox(height: 28),

                    ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text('Créer mon compte'),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go(AppRoutes.landing),
                        child: const Text(
                          "Retour à l'accueil",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _labelStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  color: AppColors.textPrimary,
);
