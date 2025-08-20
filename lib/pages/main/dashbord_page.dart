import 'package:flutter/material.dart';
import 'dart:async';

class DashbordPage extends StatefulWidget {
  const DashbordPage({super.key});

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  int _selectedIndex = 0;
  bool _extended = false;

  // Stackning global kaliti (hover panelni to‘g‘ri joylash uchun)
  final GlobalKey _stackKey = GlobalKey();

  // NavigationRail itemlarining kalitlari
  late final List<GlobalKey> _railItemKeys;

  // Hozir hover bo‘layotgan index
  int? _hoveredIndex;

  // Panel joylashuvi (Stack koordinatalarida)
  Offset _panelOffset = Offset.zero;
  Timer? _hideTimer;
  bool _overRailItem = false;
  bool _overPanel = false;
  // Menyu nomlari
  final _titles = const ['Supervayzer', 'Savdo', 'Finansiya', 'Analitika'];
  // 3) Yopishni boshqaruvchi yordamchi metodlar
  void _requestHidePanel() {
    // Ikkalasi ham tashqarida bo'lsa, biroz kutib yopamiz
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 180), () {
      if (!_overRailItem && !_overPanel) {
        if (!mounted) return;
        setState(() => _hoveredIndex = null);
      }
    });
  }

  void _cancelHideTimer() {
    _hideTimer?.cancel();
  }

  // Har bir bo‘lim uchun kichik menyu elementlari
  final Map<int, List<_SubItem>> _subMenus = {
    0: [
      _SubItem('Natijalar', Icons.bar_chart),
      _SubItem('Outlet targeting', Icons.location_on_outlined),
      _SubItem('Reja o‘rnatish', Icons.flag_outlined),
      _SubItem('Tovar bo‘yicha reja', Icons.inventory_2_outlined),
    ],
    1: [
      _SubItem('Buyurtmalar', Icons.shopping_bag_outlined),
      _SubItem('Hisobotlar', Icons.pie_chart_outline),
      _SubItem('Aksiyalar', Icons.local_offer_outlined),
    ],
    2: [
      _SubItem('Kassa', Icons.point_of_sale_outlined),
      _SubItem('To‘lovlar', Icons.account_balance_wallet_outlined),
      _SubItem('Balans', Icons.account_balance_outlined),
    ],
    3: [
      _SubItem('Dashboard', Icons.dashboard_customize_outlined),
      _SubItem('Trendlar', Icons.trending_up),
      _SubItem('Jadval/Graph', Icons.show_chart),
    ],
  };

  @override
  void initState() {
    super.initState();
    _railItemKeys = List.generate(4, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final autoExtended = constraints.maxWidth >= 1100;
        final isExtended = autoExtended || _extended;
        const railWidth = 72.0; // extended=false bo‘lsa default kenglik

        return Scaffold(
          body: Stack(
            key: _stackKey,
            children: [
              Row(
                children: [
                  _buildRail(isExtended, autoExtended),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 56,
                          color: const Color(0xFF263238),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _titles[_selectedIndex],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Tanlangan bo‘lim: ${_titles[_selectedIndex]}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Hover panel (kichik menyu)
              // 6) Positioned submenu'ning MouseRegion'ini yangilang
              if (_hoveredIndex != null)
                Positioned(
                  left: 72, // rail kengligi (dividerni ham hisobga oling)
                  top: _panelOffset.dy,
                  child: MouseRegion(
                    onEnter: (_) {
                      _cancelHideTimer();
                      _overPanel = true;
                    },
                    onExit: (_) {
                      _overPanel = false;
                      _requestHidePanel();
                    },
                    child: _HoverPanel(
                      items: _subMenus[_hoveredIndex] ?? const [],
                      onTap: (label) {
                        // ... action
                        _overPanel = false;
                        _requestHidePanel();
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRail(bool isExtended, bool autoExtended) {
    // NavigationRail ichidagi itemlarni MouseRegion bilan o‘raymiz
    final destinations = [
      _railDestination(
        0,
        Icons.rocket_launch_outlined,
        Icons.rocket_launch,
        'Rejalar',
      ),
      _railDestination(
        1,
        Icons.shopping_cart_outlined,
        Icons.shopping_cart,
        'Savdo',
      ),
      _railDestination(
        2,
        Icons.attach_money_outlined,
        Icons.attach_money,
        'Finansiya',
      ),
      _railDestination(
        3,
        Icons.analytics_outlined,
        Icons.analytics,
        'Analitika',
      ),
    ];

    return NavigationRail(
      selectedIndex: _selectedIndex,
      extended: isExtended,
      backgroundColor: const Color.fromARGB(255, 38, 50, 56),
      selectedIconTheme: const IconThemeData(size: 26),
      selectedLabelTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
      unselectedIconTheme: const IconThemeData(size: 24, color: Colors.white70),
      indicatorColor: Colors.white10,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            const FlutterLogo(size: 40),
            const SizedBox(height: 8),
            if (!autoExtended)
              IconButton(
                onPressed: () => setState(() => _extended = !_extended),
                icon: Icon(
                  isExtended ? Icons.chevron_left : Icons.chevron_right,
                ),
                color: Colors.white,
                tooltip: isExtended ? 'Yig‘ish' : 'Kengaytirish',
              ),
          ],
        ),
      ),
      destinations: destinations,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
    );
  }

  NavigationRailDestination _railDestination(
    int index,
    IconData icon,
    IconData selectedIcon,
    String label,
  ) {
    return NavigationRailDestination(
      icon: _HoverableRailIcon(
        key: _railItemKeys[index],
        icon: icon,
        label: label,
        onPointerEnter: () {
          _cancelHideTimer();
          _overRailItem = true;
          _showPanelFor(index);
        },
        onPointerExit: () {
          _overRailItem = false;
          _requestHidePanel();
        },
      ),
      selectedIcon: _HoverableRailIcon(
        key: _railItemKeys[index],
        icon: selectedIcon,
        label: label,
        selected: true,
        onPointerEnter: () {
          _cancelHideTimer();
          _overRailItem = true;
          _showPanelFor(index);
        },
        onPointerExit: () {
          _overRailItem = false;
          _requestHidePanel();
        },
      ),
      label: Text(label),
    );
  }

  void _showPanelFor(int index) {
    // Panel joylashuvini hisobl-sh (hover qilingan itemning global pozitsiyasi)
    final itemKey = _railItemKeys[index];
    final itemCtx = itemKey.currentContext;
    final stackCtx = _stackKey.currentContext;
    if (itemCtx == null || stackCtx == null) {
      setState(() => _hoveredIndex = index);
      return;
    }

    final itemBox = itemCtx.findRenderObject() as RenderBox;
    final stackBox = stackCtx.findRenderObject() as RenderBox;

    final itemTopLeftGlobal = itemBox.localToGlobal(Offset.zero);
    final itemSize = itemBox.size;
    final stackTopLeftGlobal = stackBox.localToGlobal(Offset.zero);

    // Stack koordinatasiga o‘tkazamiz
    final dy = itemTopLeftGlobal.dy - stackTopLeftGlobal.dy;

    setState(() {
      _hoveredIndex = index;
      // Panel item bilan vertikal markazda turadi
      _panelOffset = Offset(
        0,
        dy + (itemSize.height - _HoverPanel.panelHeight) / 2,
      );
    });
  }

  void _scheduleHideIfOutside(int index) {
    // Itemdan chiqqan zahoti yopmaymiz — foydalanuvchi panelga o‘tishi uchun kichik imkon qoldiramiz
    Future.delayed(const Duration(milliseconds: 120), () {
      // Agar panel ustida kursor bo'lmasa va hover index o'sha bo'lsa, yopamiz
      if (!mounted) return;
      setState(() {
        _hoveredIndex = _hoveredIndex == index ? null : _hoveredIndex;
      });
    });
  }

  void _hidePanel() {
    if (!mounted) return;
    setState(() => _hoveredIndex = null);
  }
}

/// Rail item uchun “hover”ni ushlab turuvchi soddalashtirilgan vidjet
class _HoverableRailIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final void Function()? onPointerEnter;
  final void Function()? onPointerExit;

  const _HoverableRailIcon({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
    this.onPointerEnter,
    this.onPointerExit,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onPointerEnter?.call(),
      onExit: (_) => onPointerExit?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(icon, color: selected ? Colors.white : Colors.white70),
      ),
    );
  }
}

/// Hoverda ochiladigan kichik panel
class _HoverPanel extends StatelessWidget {
  static const double panelWidth = 240;
  static const double panelHeight = 180; // o‘rtacha; mazmunga qarab o‘sadi

  final List<_SubItem> items;
  final void Function(String label) onTap;

  const _HoverPanel({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: panelWidth,
          maxWidth: panelWidth,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 2,
                offset: Offset(0, 8),
                color: Colors.black26,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items
                .map(
                  (e) => _HoverTile(
                    icon: e.icon,
                    label: e.label,
                    onTap: () => onTap(e.label),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _HoverTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _HoverTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_HoverTile> createState() => _HoverTileState();
}

class _HoverTileState extends State<_HoverTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          color: _hover ? Colors.white10 : Colors.transparent,
          child: Row(
            children: [
              Icon(widget.icon, size: 20, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.label,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const Icon(Icons.chevron_right, size: 18, color: Colors.white38),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubItem {
  final String label;
  final IconData icon;
  const _SubItem(this.label, this.icon);
}
