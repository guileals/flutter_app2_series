import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.switchTheme,
    required this.isDark,
    required this.switchScreen
  });

  final bool isDark;
  final Function() switchTheme;
  final Function(int) switchScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Eu Amo Séries 🎬',
                    style: GoogleFonts.lobster(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: switchTheme,
                    icon: isDark
                        ? Icon(Icons.wb_sunny_rounded, size: 24)
                        : Icon(Icons.nightlight_round_sharp, size: 24),
                    label: Text('Mudar Tema'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              switchScreen(0);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar série'),
            onTap: () {
              switchScreen(1);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
