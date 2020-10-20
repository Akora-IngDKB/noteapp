import 'package:note/models/Note.dart';
import 'package:note/providers/BaseProvider.dart';
// import 'package:note/services/sl.dart';

class NotesProvider extends BaseProvider {
  // final _storage = sl.getInstance();
  List<Note> _notesList = [];

  List<Note> get notes => _notesList;

  Note note = Note();

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

  Future<bool> saveToStorage() async {
    return false;
  }

  Future<bool> readFromStorage() async {
    return false;
  }
}
