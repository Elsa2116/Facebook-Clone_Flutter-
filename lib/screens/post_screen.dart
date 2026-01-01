import 'package:flutter/material.dart';

/// PostScreen
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  /// Controller to read text from the TextField
  final _controller = TextEditingController();

  /// Dispose controller to avoid memory leaks
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Called when user taps POST
  /// Sends the written post text back to previous screen
  void _submit() {
    final text = _controller.text.trim();

    // Do nothing if text is empty
    if (text.isEmpty) return;

    // Return the post text back to HomeScreen
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar with POST button
      appBar: AppBar(
        title: const Text("Create post"),
        actions: [TextButton(onPressed: _submit, child: const Text("POST"))],
      ),

      /// Body with text input
      body: Padding(
        padding: const EdgeInsets.all(16),

        /// Text field where user writes post
        child: TextField(
          controller: _controller,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: "What's on your mind?",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
