import 'package:flutter/material.dart';

/// NotificationsScreen
/// This screen shows a list of notifications
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Fake notifications data
    /// You can later replace this with Firestore data
    final notifications = [
      "Sara liked your post ❤️",
      "Dawit commented: Nice!",
      "Hana sent you a friend request 👤",
      "Miki shared your post 🔁",
      "Kaleb mentioned you in a comment 💬",
    ];

    /// ListView with separators between items
    return ListView.separated(
      padding: const EdgeInsets.all(12),

      /// Number of notifications
      itemCount: notifications.length,

      /// Divider between each notification
      separatorBuilder: (_, __) => const Divider(),

      /// Build each notification item
      itemBuilder: (context, i) {
        return ListTile(
          /// Notification icon/avatar
          leading: const CircleAvatar(
            backgroundColor: Color(0xFF1877F2),
            child: Icon(Icons.notifications, color: Colors.white),
          ),

          /// Notification message
          title: Text(notifications[i]),

          /// Time label
          subtitle: const Text("Just now"),

          /// More options icon
          trailing: const Icon(Icons.more_horiz),
        );
      },
    );
  }
}
