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
      home: const HomePage(),
    );
  }
}

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
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: cardColor,
        indicatorColor: purple.withOpacity(0.2),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: purple),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            label: 'Rooms',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

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
              const Icon(Icons.play_circle_fill,
                  color: purple, size: 35),
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
              const Icon(Icons.notifications_none, size: 27),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Different places.',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
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
            style: TextStyle(color: Colors.white60, fontSize: 15),
          ),
          const SizedBox(height: 35),
          _actionCard(
            context,
            Icons.add_circle_outline,
            'Create a room',
            'Start a watch party and invite friends.',
            () => _openRoom(context, true),
          ),
          const SizedBox(height: 16),
          _actionCard(
            context,
            Icons.login,
            'Join a room',
            'Enter a room code and watch together.',
            () => _openRoom(context, false),
          ),
          const SizedBox(height: 35),
          const Text(
            'Your experience',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
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
                Icon(Icons.movie_outlined, color: purple, size: 35),
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

  Widget _actionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: purple.withOpacity(0.35)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: purple.withOpacity(0.18),
              child: Icon(icon, color: purple, size: 27),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: purple, size: 17),
          ],
        ),
      ),
    );
  }

  void _openRoom(BuildContext context, bool create) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoomSetupPage(create: create),
      ),
    );
  }
}

class RoomSetupPage extends StatefulWidget {
  final bool create;

  const RoomSetupPage({super.key, required this.create});

  @override
  State<RoomSetupPage> createState() => _RoomSetupPageState();
}

class _RoomSetupPageState extends State<RoomSetupPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch Party')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 35),
            Icon(
              widget.create ? Icons.add_circle : Icons.groups,
              size: 65,
              color: purple,
            ),
            const SizedBox(height: 25),
            Text(
              widget.create ? 'Create your room' : 'Join a room',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              widget.create
                  ? 'Start a watch party with your friends.'
                  : 'Enter the invitation code shared by your friend.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 35),
            if (!widget.create)
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter room code',
                  filled: true,
                  fillColor: cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            const SizedBox(height: 22),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(17),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Room functionality is coming in the next update!',
                    ),
                  ),
                );
              },
              child: Text(widget.create ? 'Create Room' : 'Join Room'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.groups,
      title: 'Your Rooms',
      subtitle: 'Your watch parties will appear here.',
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.chat_bubble_outline,
      title: 'Messages',
      subtitle: 'Chat with your friends.',
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.person_outline,
      title: 'Your Profile',
      subtitle: 'Your TOGETHER account.',
    );
  }
}

class SimplePage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SimplePage({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: purple, size: 65),
          const SizedBox(height: 20),
          Text(title,
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(subtitle,
              style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
