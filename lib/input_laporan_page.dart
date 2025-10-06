import 'package:flutter/material.dart';

class InputLaporanPage extends StatefulWidget {
  const InputLaporanPage({super.key});

  @override
  State<InputLaporanPage> createState() => _InputLaporanPageState();
}

class _InputLaporanPageState extends State<InputLaporanPage> {
  final _formKey = GlobalKey<FormState>();
  String? _jenisPerundungan;
  DateTime? _tanggalKejadian;
  final _lokasiController = TextEditingController();
  final _ceritaController = TextEditingController();

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _tanggalKejadian = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Laporan berhasil dikirim.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE9FF), Color(0xFFF9F8FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ========= TITLE =========
                    const Text(
                      "Laporkan",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ========= WARNING CARD =========
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5E5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.redAccent, width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.warning_amber_rounded,
                              color: Colors.red, size: 32),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Ceritakan kejadian yang menimpa anda! Informasi Anda bersifat rahasia dan hanya digunakan untuk penanganan kasus.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13.5,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ========= DROPDOWN Jenis Perundungan =========
                    DropdownButtonFormField<String>(
                      value: _jenisPerundungan,
                      decoration: InputDecoration(
                        labelText: "Jenis Perundungan",
                        labelStyle: const TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: const Color(0xFFFDF7F7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'verbal', child: Text('Verbal')),
                        DropdownMenuItem(
                            value: 'fisik', child: Text('Fisik')),
                        DropdownMenuItem(
                            value: 'sosial', child: Text('Sosial')),
                      ],
                      onChanged: (value) {
                        setState(() => _jenisPerundungan = value);
                      },
                      validator: (value) =>
                          value == null ? "Pilih jenis perundungan" : null,
                    ),
                    const SizedBox(height: 16),

                    // ========= DATE TIME PICKER =========
                    GestureDetector(
                      onTap: _pickDateTime,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Kapan Kejadian Terjadi?",
                            labelStyle: const TextStyle(color: Colors.black54),
                            filled: true,
                            fillColor: const Color(0xFFFDF7F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: const Icon(Icons.calendar_today),
                            hintText: _tanggalKejadian == null
                                ? "Pilih waktu perundungan"
                                : "${_tanggalKejadian!.day}/${_tanggalKejadian!.month}/${_tanggalKejadian!.year} "
                                  "${_tanggalKejadian!.hour}:${_tanggalKejadian!.minute.toString().padLeft(2, '0')}",
                          ),
                          validator: (_) => _tanggalKejadian == null
                              ? "Pilih waktu kejadian"
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ========= TEXTFIELD Lokasi =========
                    TextFormField(
                      controller: _lokasiController,
                      decoration: InputDecoration(
                        labelText: "Di Mana Kejadian Terjadi?",
                        labelStyle: const TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: const Color(0xFFFDF7F7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Kantin, Kelas 8A...",
                      ),
                      validator: (value) => value!.isEmpty
                          ? "Isi lokasi kejadian"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // ========= TEXTFIELD Cerita =========
                    TextFormField(
                      controller: _ceritaController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Ceritakan Kejadian",
                        labelStyle: const TextStyle(color: Colors.black54),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: const Color(0xFFFDF7F7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Jelaskan detail kejadian yang terjadi...",
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Ceritakan kejadian" : null,
                    ),
                    const SizedBox(height: 24),

                    // ========= TOMBOL DARURAT =========
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _submitForm,
                        child: const Text(
                          "🚨  Darurat — Butuh bantuan segera",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // ========= NAVIGATION BAR =========
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.black45,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
