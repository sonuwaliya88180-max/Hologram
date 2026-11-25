import 'package:flutter/material.dart';

import '../services/auth_service.dart';

const _bg = Color(0xFF090811);
const _surface = Color(0xFF151321);
const _muted = Color(0xFF9692A8);
const _pink = Color(0xFFFF3D9A);
const _purple = Color(0xFF8B5CF6);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  final _titles = const ['HOLOGRAM', 'Reels', 'Explore', 'Activity', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _FeedPage(),
      const _ComingSoonPage(icon: Icons.play_circle_fill_rounded, title: 'Reels', subtitle: 'A world of short videos is coming.'),
      const _ExplorePage(),
      const _ComingSoonPage(icon: Icons.notifications_active_rounded, title: 'Your activity', subtitle: 'Likes, comments and new followers will appear here.'),
      const _ProfilePage(),
    ];
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg, elevation: 0, titleSpacing: 20,
        title: Text(_titles[_tab], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.7, fontSize: 20)),
        actions: [
          if (_tab == 0) ...[
            IconButton(onPressed: () => _showNotice(context, 'Messaging is coming in the next milestone.'), icon: const Icon(Icons.send_outlined, color: Colors.white)),
            IconButton(onPressed: () => _showNotice(context, 'Search is available in Explore.'), icon: const Icon(Icons.search_rounded, color: Colors.white)),
          ],
          if (_tab == 4) IconButton(
            tooltip: 'Sign out',
            onPressed: () async {
              await AuthService.instance.signOut();
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Color(0xFF100E19), border: Border(top: BorderSide(color: Color(0xFF282438)))),
        child: SafeArea(top: false, child: NavigationBar(
          height: 66, backgroundColor: const Color(0xFF100E19), indicatorColor: _purple.withValues(alpha: .22),
          selectedIndex: _tab, onDestinationSelected: (value) => setState(() => _tab = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded, color: _pink), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.video_library_outlined), selectedIcon: Icon(Icons.video_library_rounded, color: _pink), label: 'Reels'),
            NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded, color: _pink), label: 'Explore'),
            NavigationDestination(icon: Icon(Icons.favorite_border_rounded), selectedIcon: Icon(Icons.favorite_rounded, color: _pink), label: 'Activity'),
            NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded, color: _pink), label: 'Profile'),
          ],
        )),
      ),
    );
  }
}

class _FeedPage extends StatelessWidget {
  const _FeedPage();
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(bottom: 24),
    children: const [
      _StoriesStrip(),
      Padding(padding: EdgeInsets.fromLTRB(18, 12, 18, 14), child: Row(children: [
        Icon(Icons.auto_awesome, color: _pink, size: 17), SizedBox(width: 7),
        Text('DISCOVER YOUR WORLD', style: TextStyle(color: _muted, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
      ])),
      _PostCard(username: 'hologram.community', location: 'Your world, your way',
        caption: 'Welcome to HOLOGRAM ✨ A new space to share your moments, find your people and express your identity. The journey starts here.',
        tag: 'WELCOME', icon: Icons.public_rounded, gradient: [Color(0xFF251344), Color(0xFF702D83), Color(0xFFD62976)]),
      _PostCard(username: 'creator.diary', location: 'Creator inspiration',
        caption: 'Every creator starts with one idea. Make it yours. 🚀',
        tag: 'CREATE', icon: Icons.camera_alt_rounded, gradient: [Color(0xFF112D43), Color(0xFF235B72), Color(0xFF6C4CB5)]),
    ],
  );
}

class _StoriesStrip extends StatelessWidget {
  const _StoriesStrip();
  @override
  Widget build(BuildContext context) {
    const names = ['Your story', 'Aarav', 'Maya', 'Noah', 'Zoya', 'Leo'];
    return SizedBox(height: 112, child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), scrollDirection: Axis.horizontal,
      itemCount: names.length, separatorBuilder: (_, __) => const SizedBox(width: 15),
      itemBuilder: (context, index) {
        final own = index == 0;
        return SizedBox(width: 62, child: Column(children: [
          Container(padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: own ? null : const LinearGradient(colors: [_pink, _purple, Color(0xFFFFB454)]),
              border: own ? Border.all(color: const Color(0xFF5A5668), width: 1.4) : null),
            child: CircleAvatar(radius: 27, backgroundColor: const Color(0xFF282438),
              child: own ? const Icon(Icons.add_rounded, color: Colors.white, size: 27)
                : Text(names[index][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 19)))),
          const SizedBox(height: 6),
          Text(names[index], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 10.5)),
        ]));
      },
    ));
  }
}

class _PostCard extends StatefulWidget {
  const _PostCard({required this.username, required this.location, required this.caption, required this.tag, required this.icon, required this.gradient});
  final String username, location, caption, tag;
  final IconData icon;
  final List<Color> gradient;
  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _liked = false, _saved = false;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(14, 0, 14, 18),
    decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF292538))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        leading: Container(width: 40, height: 40, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_pink, _purple])),
          child: const Icon(Icons.person_rounded, color: Colors.white)),
        title: Text(widget.username, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
        subtitle: Text(widget.location, style: const TextStyle(color: _muted, fontSize: 10)),
        trailing: IconButton(onPressed: () => _showNotice(context, 'More post options will be added soon.'), icon: const Icon(Icons.more_horiz, color: Colors.white70)),
      ),
      Container(height: 260, width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: widget.gradient)),
        child: Stack(children: [
          Positioned(right: -25, top: -38, child: Icon(widget.icon, size: 220, color: Colors.white.withValues(alpha: .07))),
          Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(widget.icon, color: Colors.white, size: 54), const SizedBox(height: 12),
            Text(widget.tag, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900, letterSpacing: 4)),
            const SizedBox(height: 5), const Text('HOLOGRAM', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 3)),
          ])),
        ]),
      ),
      Padding(padding: const EdgeInsets.fromLTRB(12, 8, 12, 0), child: Row(children: [
        IconButton(onPressed: () => setState(() => _liked = !_liked), icon: Icon(_liked ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: _liked ? _pink : Colors.white, size: 25)),
        IconButton(onPressed: () => _showNotice(context, 'Comments will be enabled when the backend is connected.'), icon: const Icon(Icons.mode_comment_outlined, color: Colors.white, size: 23)),
        IconButton(onPressed: () => _showNotice(context, 'Sharing will be enabled soon.'), icon: const Icon(Icons.send_outlined, color: Colors.white, size: 22)),
        const Spacer(),
        IconButton(onPressed: () => setState(() => _saved = !_saved), icon: Icon(_saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: _saved ? _pink : Colors.white)),
      ])),
      Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_liked ? 'You and others like this' : 'Be the first to like this', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
        const SizedBox(height: 7),
        Text.rich(TextSpan(children: [
          TextSpan(text: widget.username + '  ', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
          TextSpan(text: widget.caption, style: const TextStyle(color: Colors.white70, height: 1.4)),
        ]), style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 7), const Text('Just now', style: TextStyle(color: _muted, fontSize: 10)),
      ])),
    ]),
  );
}

class _ExplorePage extends StatelessWidget {
  const _ExplorePage();
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(14), child: Column(children: [
    TextField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(
      hintText: 'Search people, tags and places', hintStyle: const TextStyle(color: _muted),
      prefixIcon: const Icon(Icons.search, color: _muted), filled: true, fillColor: _surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
      onSubmitted: (_) => _showNotice(context, 'Search will connect to the user database in a later milestone.')),
    const Expanded(child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.explore_rounded, size: 54, color: _purple), SizedBox(height: 12),
      Text('Find your people', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)),
      SizedBox(height: 5), Text('Explore creators, communities and moments.', style: TextStyle(color: _muted), textAlign: TextAlign.center),
    ]))),
  ]));
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();
  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    final label = user?.displayName ?? user?.phoneNumber ?? user?.email ?? 'Creator';
    return ListView(padding: const EdgeInsets.all(22), children: [
      const SizedBox(height: 16),
      Center(child: Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_pink, _purple])),
        child: const CircleAvatar(radius: 48, backgroundColor: _surface, child: Icon(Icons.person_rounded, color: Colors.white, size: 48)))),
      const SizedBox(height: 14),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      const SizedBox(height: 5),
      Text(user?.email ?? user?.phoneNumber ?? '@creator', textAlign: TextAlign.center, style: const TextStyle(color: _muted, fontSize: 12)),
      const SizedBox(height: 24),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _Stat(value: '0', label: 'Posts'), _Stat(value: '0', label: 'Followers'), _Stat(value: '0', label: 'Following'),
      ]),
      const SizedBox(height: 28),
      OutlinedButton.icon(onPressed: () => _showNotice(context, 'Profile editing will be added with Firestore user profiles.'),
        icon: const Icon(Icons.edit_outlined), label: const Text('Edit profile'),
        style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Color(0xFF393449)))),
      const SizedBox(height: 24), const Center(child: Text('Your posts will appear here.', style: TextStyle(color: _muted))),
    ]);
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900)),
    const SizedBox(height: 4), Text(label, style: const TextStyle(color: _muted, fontSize: 11)),
  ]);
}

class _ComingSoonPage extends StatelessWidget {
  const _ComingSoonPage({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title, subtitle;
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, color: _purple, size: 64), const SizedBox(height: 16),
    Text(title, style: const TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8), Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: _muted)),
    const SizedBox(height: 16), const Text('COMING IN THE NEXT MILESTONE', style: TextStyle(color: _pink, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
  ])));
}

void _showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: const Color(0xFF30283F), behavior: SnackBarBehavior.floating));
}
