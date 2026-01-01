import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ProfileScreen
/// Displays the user's profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current logged-in user
    final user = FirebaseAuth.instance.currentUser;

    // User display info
    final name = user?.displayName ?? "User";
    final email = user?.email ?? "";
    final initial = name.isNotEmpty ? name[0].toUpperCase() : "U";

    return Scaffold(
      /// Profile AppBar
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      /// Profile body
      body: ListView(
        children: [
          /// Cover photo + profile avatar section
          Stack(
            clipBehavior: Clip.none,
            children: [
              /// Cover photo placeholder
              Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(child: Text("Cover Photo")),
              ),

              /// Profile avatar overlapping cover photo
              Positioned(
                left: 16,
                bottom: -40,
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF1877F2),
                    child: Text(
                      initial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Space below avatar
          const SizedBox(height: 55),

          /// Name, email, and action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// User name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// User email (optional)
                if (email.isNotEmpty)
                  Text(email, style: TextStyle(color: Colors.grey[700])),

                const SizedBox(height: 12),

                /// Action buttons (Add story / Edit profile)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Add to story"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1877F2),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text("Edit profile"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(),

                /// Posts title
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Posts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          /// Sample posts on profile
          _postCard(name, "Hello! This is my first post 👋"),
          _postCard(name, "Learning Flutter + Firebase 💙"),
        ],
      ),
    );
  }

  /// Single post card widget (used in profile timeline)
  Widget _postCard(String name, String text) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Post header (avatar + name)
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFF1877F2),
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Public · 1h"),
            trailing: const Icon(Icons.more_horiz),
          ),

          /// Post text content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(text),
          ),

          const SizedBox(height: 10),

          /// Post image placeholder
          Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: Text("Post Image")),
          ),

          const Divider(),

          /// Like / Comment / Share actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _ProfileAction(icon: Icons.thumb_up_alt_outlined, text: "Like"),
              _ProfileAction(icon: Icons.comment_outlined, text: "Comment"),
              _ProfileAction(icon: Icons.share_outlined, text: "Share"),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

/// Action button used under each profile post
class _ProfileAction extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfileAction({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey),
      label: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }
}
