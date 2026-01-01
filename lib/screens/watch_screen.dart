import 'package:flutter/material.dart';

/// WatchScreen
/// Facebook-style Watch tab
/// Displays a scrollable list of video cards
class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy video titles (mock data)
    final videos = [
      "Funny cats compilation 😹",
      "Flutter tutorial part 1",
      "Football highlights ⚽",
      "Top 10 coding tips",
      "Amazing nature video 🌍",
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: videos.length,
      itemBuilder: (context, i) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Video header (avatar + title)
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.play_arrow)),
                title: Text(videos[i]),
                subtitle: const Text("Video · 2h"),
                trailing: const Icon(Icons.more_horiz),
              ),

              /// Video preview placeholder
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text("Video Preview")),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
