import 'package:hive/hive.dart';
import '../models/note.dart';

class NotesRepository {
  final Box notesBox;

  NotesRepository(this.notesBox);

  // Menyimpan note baru
  Future<void> saveNote(Note note) async {
    final id = await notesBox.add(note.toMap());
    // Tidak perlu put() lagi, karena add() sudah menyimpan data
    note = note.copyWith(id: id);
  }

  // Mengambil semua note
  List<Note> getAllNotes() {
    return notesBox.values
        .map((map) => Note.fromMap(Map<String, dynamic>.from(map)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Urutkan terbaru
  }

  // Menghapus note berdasarkan ID
  Future<void> deleteNote(int id) async {
    await notesBox.delete(id);
  }
}