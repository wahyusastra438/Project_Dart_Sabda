import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Pengguna Aplikasi SABDA"),
          ],
        ),
      ),
    );
  }
}
