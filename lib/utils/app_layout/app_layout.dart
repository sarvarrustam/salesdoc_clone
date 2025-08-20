// lib/app_layout/app_layout.dart

import 'package:flutter/material.dart';
import 'package:salesdoc_clone/utils/design/app_colors.dart';
import 'package:salesdoc_clone/utils/widgets/header.dart';
import 'package:salesdoc_clone/utils/widgets/sidebar.dart';

class AppLayout extends StatelessWidget {
  final Widget content;

  const AppLayout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            // 1. Yon menyu (Sidebar) har doim mavjud
            const Sidebar(),

            // 2. Asosiy kontent
            Expanded(
              child: Column(
                children: [
                  // 2.1. Yuqori qism (Header) har doim mavjud
                  const Header(),

                  // 2.2. Asosiy kontent maydoni (bu qism o'zgaradi)
                  Expanded(child: content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
