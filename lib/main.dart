import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/profil_page.dart';
import 'models/profile.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatefulWidget {
  const StudentProfileApp({super.key});

  @override
  State<StudentProfileApp> createState() => _StudentProfileAppState();
}

class _StudentProfileAppState extends State<StudentProfileApp> {
  bool _isDark = false; // bonus: toggle theme

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  final Profile sampleProfile = Profile(
    nama: 'Yeremia Adrianto S',
    nim: '23552011227',
    uni: 'Universitas Teknologi Bandung',
    jurusan: 'Teknik Informatika',
    email: 'matajerry951@gmail.com',
    telepon: '+62 812-2000-3000',
    hobi: ['Membaca', 'Main game', 'Hiking', 'Fotografi'],
    skill: [
      'Network',
      'Computer',
      'Programming',
      'Troubleshooting',
      ],
    status: Status.AKTIF,
    foto: 'assets/images/jerry.jpg',
  );

  @override
  Widget build(BuildContext context) {
    // Tema ungu–biru
    final primary = _isDark ? const Color(0xFF5B3FFF) : const Color(0xFF4C3BCF);
    final secondary =
        _isDark ? const Color(0xFF1F1B2E) : const Color(0xFF7F5AF0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa',
      theme: ThemeData(
        brightness: _isDark ? Brightness.dark : Brightness.light,
        primaryColor: primary,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          brightness: _isDark ? Brightness.dark : Brightness.light,
        ).copyWith(
          secondary: secondary,
        ),
        scaffoldBackgroundColor:
            _isDark ? const Color(0xFF0F1020) : const Color(0xFFF3F1FF),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondary,
        ),
      ),
      home: ProfilPage(
        profile: sampleProfile,
        isDark: _isDark,
        onToggleTheme: _toggleTheme,  
      ),
    );
  }
}
