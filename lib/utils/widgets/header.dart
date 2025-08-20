import 'package:flutter/material.dart';
import 'package:salesdoc_clone/utils/design/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          // Qidiruv paneli
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          // Ikonkalar (bildirishnoma va profil)
          IconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
