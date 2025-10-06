import 'package:flutter/material.dart';
import 'profile_page.dart';

class DashboardPage extends StatelessWidget {
  final String username;
  const DashboardPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hallo,",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Selamat datang di SABDA!",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/profile.jpg'), // contoh
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Banner info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDEBFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Jangan Takut bercerita, karena SABDA ruang amanmu untuk berbagi cerita.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),

              // Card section
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildFeatureCard(Icons.chat_bubble_outline, "New Chat", Colors.blue[100]!),
                    _buildFeatureCard(Icons.report, "Laporkan", Colors.red[100]!),
                    _buildFeatureCard(Icons.book, "Edukasi", Colors.green[100]!),
                    _buildFeatureCard(Icons.lightbulb, "Tips Harian", Colors.amber[100]!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(username: username),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black54),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text("Lorem ipsum...", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
