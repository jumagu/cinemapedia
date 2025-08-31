import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  static const messages = <String>[
    "Preparing virtual popcorn...",
    "Rewinding the movie...",
    "Loading faster than Fast & Furious 47",
    "Pretending this takes longer to build suspense",
    "Loading spoilers... just kidding!",
  ];

  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (
      computationCount,
    ) {
      return messages[computationCount];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Text('Loading...'),
          const CircularProgressIndicator(),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
