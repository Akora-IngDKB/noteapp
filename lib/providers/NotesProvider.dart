import 'package:note/models/Note.dart';
import 'package:note/providers/BaseProvider.dart';

class NotesProvider extends BaseProvider {
  List<Note> _notesList = [];

  List<Note> get notes => _notesList;
  Note note = Note();

  // set notes(value) {
  //   _notesList = value;
  // }

  // void search(String value) {
  //   notes = notes.where((notes) {
  //     var notetitle = note.title.toLowerCase();
  //     print(notetitle);
  //     return notetitle.contains(value);
  //   }).toList();
  //   notifyListeners();
  // }

  void addNote(Note n) {
    _notesList.add(n);
    notifyListeners();
  }

  void deleteNote(Note n) {
    _notesList.remove(n);
    notifyListeners();
  }

  void update(Note newNote, Note oldNote) {
    final index = _notesList.indexWhere((o) => o == oldNote);
    _notesList[index] = newNote;
    notifyListeners();
  }
}
