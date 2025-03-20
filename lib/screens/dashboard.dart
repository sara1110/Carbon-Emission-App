import 'package:carbon_emission_app/config/theme.dart';
import 'package:carbon_emission_app/providers/bottom_nav_bar/bottom_nav_bar_provider.dart';
import 'package:carbon_emission_app/screens/electricityscreen.dart';
import 'package:carbon_emission_app/screens/homescreen.dart';
import 'package:carbon_emission_app/screens/transportation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final List<Widget> _screens = [
    Homescreen(),
    TransportationScreen(),
    ElectricityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavBarIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: secondaryGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.car),
            label: 'Transportation',
            backgroundColor: primaryBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Electricity',
            backgroundColor: primaryYellow,
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavBarIndexProvider.notifier).state = index;
        },
        selectedLabelStyle: label(bold: true),
      ),
    );
  }
}
