import 'package:flutter/material.dart';

void main() => runApp(const HologramApp());

const ink = Color(0xFF101326);
const violet = Color(0xFF7657F6);
const canvas = Color(0xFFF7F7FB);

class HologramApp extends StatelessWidget {
  const HologramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOLOGRAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: violet),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  final stories = const ['Your story', 'Aarav', 'Meera', 'Kabir', 'Isha', 'Rohan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: canvas,
        title: const Text('HOLOGRAM', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5, color: ink)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
          const SizedBox(width: 4),
        ],
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          _feed(),
          _placeholder(Icons.search_rounded, 'Explore', 'Discover creators and communities'),
          _placeholder(Icons.add_box_outlined, 'Create', 'Share your first moment with the world'),
          _placeholder(Icons.movie_creation_outlined, 'Reels', 'Short videos are coming soon'),
          _placeholder(Icons.person_outline_rounded, 'Your profile', 'Your identity. Your space.'),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) => setState(() => selectedTab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.play_circle_outline_rounded), label: 'Reels'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _feed() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [Color(0xFFFA7A45), violet, Color(0xFFDA43A8)]),
                  ),
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFE9E5FF),
                      child: index == 0
                          ? const Icon(Icons.add, color: violet, size: 28)
                          : Text(stories[index][0], style: const TextStyle(fontWeight: FontWeight.bold, color: ink, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(stories[index], style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
        _postCard('Aarav Sharma', '@aarav.creates', 'A little inspiration for your day. Big things start with small steps.', 'A', const Color(0xFFB9B2FF), '2 hours ago'),
        _postCard('Meera Kapoor', '@meerainmotion', 'Collect moments, not things. ✨', 'M', const Color(0xFFFFD6C9), '5 hours ago'),
      ],
    );
  }

  Widget _postCard(String name, String handle, String caption, String initial, Color artColor, String time) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 2),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Color(0xFFECECF2))),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundColor: artColor, child: Text(initial, style: const TextStyle(color: ink, fontWeight: FontWeight.bold))),
            title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Text('$handle • $time', style: const TextStyle(fontSize: 11)),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          ),
          Container(
            height: 260,
            width: double.infinity,
            color: artColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome_rounded, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  Text('HOLOGRAM', style: TextStyle(color: Colors.white.withValues(alpha: .95), fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 3)),
                  Text('YOUR WORLD', style: TextStyle(color: Colors.white.withValues(alpha: .8), letterSpacing: 2, fontSize: 10)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.mode_comment_outlined)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border_rounded)),
                ]),
                Text(caption, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 5),
                const Text('Be the first to comment', style: TextStyle(color: Colors.black45, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder(IconData icon, String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 54, color: violet),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ink)),
            const SizedBox(height: 6),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
