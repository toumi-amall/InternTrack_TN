import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/themes/theme.dart';
import 'screens/home/home_page.dart';
import 'screens/authentication/login_page.dart';
import 'screens/authentication/signup_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const InternTrackTN());
}

class InternTrackTN extends StatelessWidget {
  const InternTrackTN({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'InternTrack TN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/home', page: () => const MainNavigation()),
      ],
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const _ApplicationsPlaceholder(),
    const _CalendarPlaceholder(),
    const _ProfilePlaceholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_rounded),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Temporary placeholders - replace with real pages when created
class _ApplicationsPlaceholder extends StatelessWidget {
  const _ApplicationsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applications')),
      body: const Center(child: Text('Applications Page - Coming Soon')),
    );
  }
}

class _CalendarPlaceholder extends StatelessWidget {
  const _CalendarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: const Center(child: Text('Calendar Page - Coming Soon')),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
      body: const Center(child: Text('Profile Page - Coming Soon')),
    );
  }
}
