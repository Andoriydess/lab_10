import 'package:flutter/material.dart';
import 'preview_screen.dart';

const _robotUrl ='https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _textController = TextEditingController();
  double _fontSize = 16;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _openPreview() async {

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (!mounted) return;

    String message = "Don't know what to say";
    if (result == true) message = 'Cool!';
    if (result == false) message = 'Let’s try something else';

    _showDialog(message);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: Image.network(
          _robotUrl,
          width: 48,
          height: 48,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
        content: Center(
          heightFactor: 1,
          child: Text(message, textAlign: TextAlign.center),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Text previewer'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Font size: ${_fontSize.round()}'),
                  Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 1,
                      max: 100,
                      onChanged: (value) =>
                          setState(() => _fontSize = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _openPreview,
                child: const Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}