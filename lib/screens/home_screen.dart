import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/app_colors.dart';
import '../core/app_images.dart';
import '../models/contact.dart';
import '../widgets/add_contact_sheet.dart';
import '../widgets/contact_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int maxContacts = 6;
  final List<Contact> _contacts = [];

  void _openAddSheet() {
    showModalBottomSheet<Contact>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const AddContactSheet(),
    ).then((contact) {
      if (contact != null) setState(() => _contacts.add(contact));
    });
  }

  void _deleteContact(int index) => setState(() => _contacts.removeAt(index));

  void _deleteLast() {
    if (_contacts.isNotEmpty) setState(() => _contacts.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppImages.logo,
          height: 32,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _contacts.isEmpty ? _buildEmpty(theme) : _buildGrid(),
      ),
      floatingActionButton: _buildFabs(),
    );
  }

  Widget _buildEmpty(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            AppImages.emptyList,
            width: 250,
          ),
          const SizedBox(height: 16),
          Text('There is No Contacts Added Here',
              style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 140),
      itemCount: _contacts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, i) => ContactCard(
        contact: _contacts[i],
        onDelete: () => _deleteContact(i),
      ),
    );
  }

  Widget _buildFabs() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_contacts.isNotEmpty)
          FloatingActionButton(
            heroTag: 'delete',
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            onPressed: _deleteLast,
            child: const Icon(Icons.delete),
          ),
        const SizedBox(height: 12),
        if (_contacts.length < maxContacts)
          FloatingActionButton(
            heroTag: 'add',
            backgroundColor: AppColors.gold,
            foregroundColor: AppColors.darkBlue,
            onPressed: _openAddSheet,
            child: const Icon(Icons.add),
          ),
      ],
    );
  }
}