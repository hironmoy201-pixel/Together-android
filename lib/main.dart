import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TogetherApp());
}

const Color purple = Color(0xFF9B72FF);
const Color background = Color(0xFF101014);
const Color cardColor = Color(0xFF1D1D25);

class TogetherApp extends StatelessWidget {
  const TogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOGETHER',

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}

// ======================================
// ANIMATED SPLASH SCREEN
// ======================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    scale = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );

    fade = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    controller.forward();

    Timer(const Duration(milliseconds: 2800), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (_, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.96,
                  end: 1,
                ).animate(animation),
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: FadeTransition(
          opacity: fade,
          child: ScaleTransition(
            scale: scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: purple.withOpacity(0.15),
                    boxShadow: [
                      BoxShadow(
                        color: purple.withOpacity(0.45),
                        blurRadius: 45,
                        spreadRadius: 8,
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: purple,
                    size: 75,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'TOGETHER',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Different places. One experience.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================
// HOME PAGE
// ======================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    RoomsScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey(selectedIndex),
            child: pages[selectedIndex],
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        backgroundColor: cardColor,
        indicatorColor: purple.withOpacity(0.22),
        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: purple),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups, color: purple),
            label: 'Rooms',
          ),

          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat, color: purple),
            label: 'Messages',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: purple),
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}

// ======================================
// HOME SCREEN
// ======================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(22),

      child: ListView(
        children: [

          const SizedBox(height: 15),

          Row(
            children: [

              const Icon(
                Icons.play_circle_fill,
                color: purple,
                size: 38,
              ),

              const SizedBox(width: 10),

              const Text(
                'TOGETHER',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.notifications_none,
                size: 27,
              ),

            ],
          ),

          const SizedBox(height: 40),

          const Text(
            'Different places.',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            'One experience.',
            style: TextStyle(
              fontSize: 29,
              color: purple,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Watch movies and shows together, wherever you are.',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 35),

          AnimatedActionCard(
            icon: Icons.add_circle_outline,
            title: 'Create a room',
            subtitle: 'Start a watch party and invite friends.',
            onTap: () => openRoom(context, true),
          ),

          const SizedBox(height: 16),

          AnimatedActionCard(
            icon: Icons.login,
            title: 'Join a room',
            subtitle: 'Enter a room code and watch together.',
            onTap: () => openRoom(context, false),
          ),

          const SizedBox(height: 35),

          const Text(
            'Your experience',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
            ),

            child: const Row(
              children: [

                Icon(
                  Icons.movie_outlined,
                  color: purple,
                  size: 35,
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Text(
                    'Your watch parties will appear here.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  void openRoom(BuildContext context, bool create) {

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),

        pageBuilder: (_, animation, secondaryAnimation) =>
            RoomSetupPage(create: create),

        transitionsBuilder: (_, animation, secondaryAnimation, child) {

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset
