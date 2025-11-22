import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../widgets/skill_item.dart';
import '../widgets/hobby_item.dart';

class ProfilPage extends StatefulWidget {
  final Profile profile;
  final bool isDark;
  final VoidCallback onToggleTheme;
 
  const ProfilPage({
    super.key,
    required this.profile,
    required this.isDark,
    required this.onToggleTheme,
    
  });

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final TextEditingController _skillController = TextEditingController();
  late Profile currentProfile;

  @override
  void initState() {
    super.initState();
    currentProfile = widget.profile;
  }

  void _addSkill() {
    final s = _skillController.text.trim();
    if (s.isEmpty) return;
    setState(() {
      currentProfile = currentProfile.copyWithAddedSkill(s);
      _skillController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isWide = media.size.width > 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        actions: [
          IconButton(
            tooltip: widget.isDark ? 'Mode Terang' : 'Mode Gelap',
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDark ? Icons.wb_sunny : Icons.nights_stay),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isWide ? _buildWideLayout() : _buildNarrowLayout(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSkillDialog(context),
        tooltip: 'Tambah skill (sementara)',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: _leftCard()),
        const SizedBox(width: 12),
        Expanded(flex: 6, child: _rightPanel()),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return ListView(
      children: [
        _leftCard(),
        const SizedBox(height: 12),
        _rightPanel(),
      ],
    );
  }

  Widget _leftCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Stack dengan foto header
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.35),
                        BlendMode.darken,
                      ),
                      image: AssetImage(currentProfile.foto),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(currentProfile.foto),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Text(
              currentProfile.nama,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              currentProfile.uni,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              currentProfile.jurusan,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.15),
                  label: Text(
                    currentProfile.getStatusLabel(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Chip(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.08),
                  label: Text('NIM: ${currentProfile.nim}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tentang Saya',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Halo! Saya Yeremia Adrianto S, mahasiswa Teknik Informatika yang tertarik pada pengembangan aplikasi mobile, sistem informasi, dan game. Saat ini saya aktif belajar dan mengembangkan berbagai proyek kecil, mulai dari aplikasi sederhana hingga sistem yang lebih kompleks, sambil terus memperdalam pemahaman tentang pemrograman, basis data, dan teknologi terbaru.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hobi',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentProfile.hobi.length,
                    itemBuilder: (context, idx) =>
                        HobbyItem(title: currentProfile.hobi[idx]),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skill',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  itemCount: currentProfile.skill.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 48,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, idx) =>
                      SkillItem(name: currentProfile.skill[idx]),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Kontak Cepat'),
            subtitle:
                Text('${currentProfile.email} • ${currentProfile.telepon}'),
            trailing: IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Kirim Pesan'),
                    content: const Text(
                        'Fitur kirim pesan belum terhubung.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Skill'),
        content: TextField(
          controller: _skillController,
          decoration:
              const InputDecoration(hintText: 'Masukkan skill baru'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              _addSkill();
              Navigator.pop(context);
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}
