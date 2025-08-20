// lib/features/dashboard/widgets/sidebar.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesdoc_clone/bloc/app_bloc.dart';
import 'package:salesdoc_clone/bloc/app_event.dart';
import 'package:salesdoc_clone/bloc/app_state.dart';
import 'package:salesdoc_clone/utils/design/app_colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        String activePage = '';
        if (appState is AppStateWithPage) {
          activePage = appState.activePage;
        }

        return Container(
          width: 250,
          color: AppColors.card,
          child: Column(
            children: [
              // Logo qismi...
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'SalesDoc',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Divider(color: AppColors.border),
              Expanded(
                child: ListView(
                  children: [
                    SidebarItem(
                      icon: Icons.dashboard_outlined,
                      title: 'Dashboard',
                      isSelected: activePage == 'Dashboard',
                      onTap: () {
                        context.read<AppBloc>().add(
                          const NavigateToPage('Dashboard'),
                        );
                      },
                    ),
                    SidebarItem(
                      icon: Icons.assignment_outlined,
                      title: 'Documents',
                      isSelected: activePage == 'Documents',
                      onTap: () {
                        context.read<AppBloc>().add(
                          const NavigateToPage('Documents'),
                        );
                      },
                    ),
                    SidebarItem(
                      icon: Icons.people_outline,
                      title: 'Clients',
                      isSelected: activePage == 'Clients',
                      onTap: () {
                        context.read<AppBloc>().add(
                          const NavigateToPage('Clients'),
                        );
                      },
                    ),
                    SidebarItem(
                      icon: Icons.person_add_outlined,
                      title: 'Leads',
                      isSelected: activePage == 'Leads',
                      onTap: () {
                        context.read<AppBloc>().add(
                          const NavigateToPage('Leads'),
                        );
                      },
                    ),
                    SidebarItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      isSelected: activePage == 'Settings',
                      onTap: () {
                        context.read<AppBloc>().add(
                          const NavigateToPage('Settings'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Profil va boshqa qism...
            ],
          ),
        );
      },
    );
  }
}

// SidebarItem widgeti o'zgarmasdan qolaveradi, faqat onTap funksiyasi qo'shiladi.
// ...
class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected
          ? AppColors.primary.withOpacity(0.1)
          : Colors.transparent,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
