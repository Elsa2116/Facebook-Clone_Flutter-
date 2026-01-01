import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'friends_screen.dart';
import 'post_screen.dart';
import 'menu_screen.dart';

class FacebookNavigation extends StatefulWidget {
  const FacebookNavigation({super.key});

  @override
  State<FacebookNavigation> createState() => _FacebookNavigationState();
}

class _FacebookNavigationState extends State<FacebookNavigation> {
  int _index = 0;

  // ✅ 5 tabs like Facebook
  final List<Widget> _pages = const [
    HomeScreen(), // 0 Home
    FriendsScreen(), // 1 Friends
    PostScreen(), // 2 Create Post
    NotificationsPage(), // 3 Notifications (simple)
    MenuScreen(), // 4 Menu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // show FB appbar only on Home (optional)
      appBar: _index == 0 ? _appBar() : null,

      // keep states (facebook feel)
      body: IndexedStack(index: _index, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF1877F2),
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.group, size: 28), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu, size: 28), label: ''),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        "facebook",
        style: TextStyle(
          color: Color(0xFF1877F2),
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
      ],
    );
  }
}

/// ✅ Simple Notifications page (so you have 2+ working navs)
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      "Sara liked your post",
      "Dawit commented on your photo",
      "Hana sent you a friend request",
      "Miki shared your post",
      "Kaleb mentioned you",
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, i) => ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF1877F2),
          child: Icon(Icons.notifications, color: Colors.white),
        ),
        title: Text(items[i]),
        subtitle: const Text("Just now"),
        trailing: const Icon(Icons.more_horiz),
      ),
    );
  }
}
