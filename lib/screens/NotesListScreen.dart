import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/note_form_cubit/note_form_cubit.dart';
import '../blocs/notes_list_bloc/notes_list_bloc.dart';
import 'NotesFormScreen.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trego Notepad')),
      body: BlocBuilder<NotesListBloc, NotesListState>(
        builder: (context, state) {
          if (state is NotesListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesListLoaded) {
            final notes = state.notes;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => NoteFormCubit()..setNote(note),
                          child: const NoteFormScreen(),
                        ),
                      ),
                    );
                  },

                );
              },
            );
          } else {
            return const Center(child: Text('Terjadi kesalahan'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman buat catatan baru
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => NoteFormCubit(),
                child: const NoteFormScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
