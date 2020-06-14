import 'package:note/models/Note.dart';
import 'package:note/providers/BaseProvider.dart';

class NotesProvider extends BaseProvider {
  List<Note> _notesList = [];
  
  List<Note> get notes => _notesList;

  void addNote(Note n) {
    _notesList.add(n);
    notifyListeners();
  }
 


}
