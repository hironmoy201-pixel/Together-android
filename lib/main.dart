import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

const Color purple = Color(0xFF9B72FF);
const Color background = Color(0xFF101014);
const Color cardColor = Color(0xFF1D1D25);
const Color secondaryText = Color(0xFFAAAAAA);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TogetherApp());
}

class TogetherApp extends StatelessWidget {
  const TogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOGETHER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// SPLASH SCREEN

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _scale = Tween<double>(begin: 0.55, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.9,
            colors: [Color(0xFF29203D), background],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 108,
                    width: 108,
                    decoration: BoxDecoration(
                      color: purple.withAlpha(38),
                      shape: BoxShape.circle,
                      border: Border.all(color: purple, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: purple.withAlpha(75),
                          blurRadius: 32,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 76,
                      color: purple,
                    ),
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'TOGETHER',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Different places. One experience.',
                    style: TextStyle(color: secondaryText, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// MAIN NAVIGATION

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
        child: IndexedStack(index: selectedIndex, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: cardColor,
        indicatorColor: purple.withAlpha(45),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library_outlined),
            selectedIcon: Icon(Icons.video_library_rounded),
            label: 'Rooms',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// HOME

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openRoom(BuildContext context, String type) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RoomSetupPage(roomType: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOGETHER',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              IconButton(
                onPressed: () => _showMessage(context, 'No new notifications.'),
                icon: const Icon(Icons.notifications_none_rounded),
                style: IconButton.styleFrom(backgroundColor: cardColor),
              ),
            ],
          ),
          const SizedBox(height: 34),
          const Text(
            'Different places.',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          ),
          const Text(
            'One experience.',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              color: purple,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Watch movies and shows together, wherever you are.',
            style: TextStyle(
              color: secondaryText,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          AnimatedActionCard(
            icon: Icons.add_circle_outline_rounded,
            title: 'Create a room',
            subtitle: 'Start a watch party with your friends',
            buttonText: 'Create room',
            onTap: () => openRoom(context, 'Create'),
          ),
          const SizedBox(height: 17),
          AnimatedActionCard(
            icon: Icons.login_rounded,
            title: 'Join a room',
            subtitle: 'Enter a room code and watch together',
            buttonText: 'Join room',
            onTap: () => openRoom(context, 'Join'),
          ),
          const SizedBox(height: 32),
          const Text(
            'Your experience',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Expanded(
                child: InfoCard(
                  icon: Icons.sync_rounded,
                  title: 'Sync',
                  subtitle: 'Watch together',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: InfoCard(
                  icon: Icons.chat_rounded,
                  title: 'Chat',
                  subtitle: 'Stay connected',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: InfoCard(
                  icon: Icons.lock_outline_rounded,
                  title: 'Private',
                  subtitle: 'Your own rooms',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: InfoCard(
                  icon: Icons.people_outline_rounded,
                  title: 'Together',
                  subtitle: 'With friends',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// REUSABLE CARDS

class AnimatedActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  const AnimatedActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  State<AnimatedActionCard> createState() => _AnimatedActionCardState();
}

class _AnimatedActionCardState extends State<AnimatedActionCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedScale(
        scale: isPressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 140),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(21),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: purple.withAlpha(65)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: purple, size: 32),
              const SizedBox(height: 15),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.subtitle,
                style: const TextStyle(color: secondaryText),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Text(
                    widget.buttonText,
                    style: const TextStyle(
                      color: purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(Icons.arrow_forward_rounded,
                      color: purple, size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: purple, size: 25),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: secondaryText, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ROOM SETUP AND LOCAL DEMO ROOM

class RoomSetupPage extends StatefulWidget {
  final String roomType;

  const RoomSetupPage({super.key, required this.roomType});

  @override
  State<RoomSetupPage> createState() => _RoomSetupPageState();
}

class _RoomSetupPageState extends State<RoomSetupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool isPrivate = true;

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    super.dispose();
  }

  String createCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random();
    return List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
  }

  void continueRoom() {
    final isCreate = widget.roomType == 'Create';
    final roomName = nameController.text.trim();
    final roomCode = isCreate ? createCode() : codeController.text.trim().toUpperCase();

    if (isCreate && roomName.isEmpty) {
      _showMessage(context, 'Please enter a room name.');
      return;
    }
    if (!isCreate && roomCode.length < 4) {
      _showMessage(context, 'Please enter a valid room code.');
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => DemoRoomPage(
          roomName: isCreate ? roomName : 'Joined room',
          roomCode: roomCode,
          isHost: isCreate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCreate = widget.roomType == 'Create';
    return Scaffold(
      appBar: AppBar(title: Text('${widget.roomType} room')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Icon(
            isCreate ? Icons.video_call_rounded : Icons.meeting_room_rounded,
            color: purple,
            size: 58,
          ),
          const SizedBox(height: 18),
          Text(
            isCreate ? 'Set up your watch party' : 'Join your friends',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This is a local prototype. Room codes are not connected to a server yet.',
            style: TextStyle(color: secondaryText, height: 1.5),
          ),
          const SizedBox(height: 28),
          if (isCreate) ...[
            const Text('Room name'),
            const SizedBox(height: 9),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Friday movie night',
                prefixIcon: Icon(Icons.movie_outlined),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isPrivate,
              activeThumbColor: purple,
              title: const Text('Private room'),
              subtitle: const Text('Only people with your code can join'),
              onChanged: (value) => setState(() => isPrivate = value),
            ),
          ] else ...[
            const Text('Room code'),
            const SizedBox(height: 9),
            TextField(
              controller: codeController,
              textCapitalization: TextCapitalization.characters,
              maxLength: 8,
              decoration: const InputDecoration(
                hintText: 'ENTER CODE',
                prefixIcon: Icon(Icons.key_rounded),
              ),
            ),
          ],
          const SizedBox(height: 26),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 17),
            ),
            onPressed: continueRoom,
            child: Text(isCreate ? 'Create room' : 'Join room'),
          ),
        ],
      ),
    );
  }
}

class DemoRoomPage extends StatefulWidget {
  final String roomName;
  final String roomCode;
  final bool isHost;

  const DemoRoomPage({
    super.key,
    required this.roomName,
    required this.roomCode,
    required this.isHost,
  });

  @override
  State<DemoRoomPage> createState() => _DemoRoomPageState();
}

class _DemoRoomPageState extends State<DemoRoomPage> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch room')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: purple.withAlpha(65)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_circle_outline, color: purple, size: 62),
                const SizedBox(height: 10),
                const Text('Video player coming soon'),
                const SizedBox(height: 5),
                Text(
                  'Playback is not connected yet',
                  style: TextStyle(color: secondaryText, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            widget.roomName,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Share this code with your friends:'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.roomCode,
                  style: const TextStyle(
                    color: purple,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                IconButton(
                  onPressed: () => _showMessage(
                    context,
                    'Room code: ${widget.roomCode}',
                  ),
                  icon: const Icon(Icons.copy_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => setState(() => isPlaying = !isPlaying),
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(isPlaying ? 'Pause preview' : 'Play preview'),
            style: FilledButton.styleFrom(
              backgroundColor: purple,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.isHost
                ? 'You are the room host.'
                : 'You joined this room in local demo mode.',
            style: const TextStyle(color: secondaryText),
          ),
          const SizedBox(height: 8),
          const Text(
            'Note: this screen is a UI demonstration only. Other phones cannot see this room yet.',
            style: TextStyle(color: secondaryText, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// OTHER NAVIGATION TABS

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      icon: Icons.video_library_outlined,
      title: 'Your rooms',
      subtitle: 'Rooms you create or join will appear here.',
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      icon: Icons.chat_bubble_outline_rounded,
      title: 'Messages',
      subtitle: 'Your watch-party conversations will appear here.',
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      icon: Icons.person_outline_rounded,
      title: 'Your profile',
      subtitle: 'Profile settings will be added in a future update.',
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const PlaceholderScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: purple, size: 62),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 9),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: secondaryText, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
