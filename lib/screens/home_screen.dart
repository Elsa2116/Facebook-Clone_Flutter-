import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'menu_screen.dart';
import 'watch_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

/// HomeScreen is the main screen shown after login
/// It contains Facebook-style bottom navigation and feed UI
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State class manages navigation, user data, and UI
class _HomeScreenState extends State<HomeScreen> {
  /// Keeps track of the selected bottom navigation index
  int _currentIndex = 0;

  /// Holds the currently logged-in Firebase user
  User? user;

  /// Fake names for story UI (for demo purposes only)
  final List<String> storyNames = [
    "Abel",
    "Sara",
    "Dawit",
    "Hana",
    "Miki",
    "Yohana",
    "Kaleb",
  ];

  /// Called once when the screen is created
  /// Fetches the current Firebase user
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar is shown ONLY on Home tab (like real Facebook)
      appBar: _currentIndex == 0 ? _appBar() : null,

      /// Navigation logic for bottom tabs
      /// 0 → Home Feed
      /// 1 → Watch
      /// 2 → Marketplace (not implemented)
      /// 3 → Notifications
      /// 4 → Menu
      body: _currentIndex == 0
          ? _homeBody()
          : _currentIndex == 1
          ? const WatchScreen()
          : _currentIndex == 3
          ? const NotificationsScreen()
          : _currentIndex == 4
          ? const MenuScreen()
          : _placeholder(),

      /// Facebook-style bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        /// Update UI when a tab is tapped
        onTap: (index) {
          setState(() => _currentIndex = index);
        },

        /// Navigation icons
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.ondemand_video), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
        ],
      ),
    );
  }

  /// Facebook top AppBar (logo, search, messages, logout)
  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        "facebook",
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.message, color: Colors.black),
          onPressed: () {},
        ),

        /// Logs the user out of Firebase
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }

  /// Main Home feed body
  Widget _homeBody() {
    return ListView(
      children: [
        _postInput(), // "What's on your mind?"
        _postActions(), // Live / Photo / Room
        const SizedBox(height: 8),
        _stories(), // Stories row
        const Divider(thickness: 8),
        _postCard(), // Sample post
      ],
    );
  }

  /// Post input section
  Widget _postInput() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          /// User avatar (first letter of name)
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              user?.displayName != null
                  ? user!.displayName![0].toUpperCase()
                  : "U",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),

          /// Input placeholder
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.centerLeft,
              child: const Text("What's on your mind?"),
            ),
          ),
        ],
      ),
    );
  }

  /// Live / Photo / Room buttons
  Widget _postActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _ActionButton(icon: Icons.videocam, color: Colors.red, text: "Live"),
        _ActionButton(icon: Icons.photo, color: Colors.green, text: "Photo"),
        _ActionButton(
          icon: Icons.video_call,
          color: Colors.purple,
          text: "Room",
        ),
      ],
    );
  }

  /// Stories section
  Widget _stories() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _createStory(), // Create story card
          ...List.generate(5, (index) => _storyItem(index)),
        ],
      ),
    );
  }

  /// Create Story card
  Widget _createStory() {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: -12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Create Story",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// Individual story card
  Widget _storyItem(int index) {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 16),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Text(
              storyNames[index % storyNames.length],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sample Facebook-style post
  Widget _postCard() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                user?.displayName != null
                    ? user!.displayName![0].toUpperCase()
                    : "U",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              user?.displayName ?? "Anonymous",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("2h · Public"),
            trailing: const Icon(Icons.more_horiz),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text("Learning Flutter 💙"),
          ),
          const SizedBox(height: 10),
          Container(
            height: 220,
            color: Colors.grey[300],
            child: const Center(child: Text("Post Image")),
          ),
          const Divider(),

          /// Like / Comment / Share buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _ReactionButton(icon: Icons.thumb_up_alt_outlined, text: "Like"),
              _ReactionButton(icon: Icons.comment_outlined, text: "Comment"),
              _ReactionButton(icon: Icons.share_outlined, text: "Share"),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  /// Placeholder for unimplemented tabs
  Widget _placeholder() {
    return const Center(
      child: Text("Coming Soon", style: TextStyle(fontSize: 18)),
    );
  }
}

/// Reusable button for Live / Photo / Room
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }
}

/// Reusable reaction button (Like / Comment / Share)
class _ReactionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ReactionButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey),
      label: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }
}
