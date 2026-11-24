import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_colors.dart';
import '../models/contact.dart';
import 'package:lottie/lottie.dart';
import '../core/app_images.dart';

class AddContactSheet extends StatefulWidget {
  const AddContactSheet({super.key});

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    for (final c in [_name, _email, _phone]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }
 // بفتح الجالير علشان المستخدم يختار صوره وبعد ما يختارها بخزنها في متغير
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Contact(
        name: _name.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        image: _image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 145,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _image == null
                          ? Lottie.asset(
                        AppImages.imagePicker,
                        fit: BoxFit.cover,
                      )
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_name.text.isEmpty ? 'User Name' : _name.text,
                            style: theme.textTheme.titleMedium),
                        const Divider(
                          height: 16,
                          thickness: 1,
                          color: AppColors.white
                        ),
                        Text(
                            _email.text.isEmpty
                                ? 'example@gmail.com'
                                : _email.text,
                            style: theme.textTheme.titleMedium),
                        const Divider(
                          height: 16,
                          thickness: 1,
                          color: AppColors.white,
                        ),
                        Text(
                            _phone.text.isEmpty
                                ? '+200000000000'
                                : _phone.text,
                            style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _name,
                style: const TextStyle(fontSize: 16, color: AppColors.white),
                decoration: const InputDecoration(hintText: 'Enter User Name'),
                validator: (value) =>(value == null || value.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 16, color: AppColors.white),
                decoration: const InputDecoration(hintText: 'Enter User Email'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Email is required';
                  final ok =
                  RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
                  return ok ? null : 'Enter a valid email';
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 16, color: AppColors.white),
                decoration: const InputDecoration(hintText: 'Enter User Phone'),
                validator: (value) => (value == null || value.trim().length < 8)
                    ? 'Enter a valid phone'
                    : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Enter user'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}