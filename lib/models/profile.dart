// Model untuk data profil mahasiswa

enum Status { AKTIF, TIDAK_AKTIF, ALUMNI }

class Profile {
  final String nama;
  final String nim;
  final String uni;
  final String jurusan;
  final String email;
  final String telepon;
  final List<String> hobi;
  final List<String> skill;
  final Status status;
  final String foto;

  Profile({
    required this.nama,
    required this.nim,
    required this.uni,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.hobi,
    required this.skill,
    required this.status,
    required this.foto,
  });

  String getStatusLabel() {
    switch (status) {
      case Status.AKTIF:
        return 'Aktif';
      case Status.TIDAK_AKTIF:
        return 'Tidak Aktif';
      case Status.ALUMNI:
        return 'Alumni';
    }
  }

  // contoh fungsi manipulasi: tambahkan skill
  Profile copyWithAddedSkill(String newSkill) {
    return Profile(
      nama: nama,
      nim: nim,
      uni: uni,
      jurusan: jurusan,
      email: email,
      telepon: telepon,
      hobi: List.of(hobi),
      skill: List.of(skill)..add(newSkill),
      status: status,
      foto: foto,
    );
  }
}
