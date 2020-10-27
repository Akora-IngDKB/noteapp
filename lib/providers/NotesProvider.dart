import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';
import 'package:note/providers/BaseProvider.dart';
import 'package:note/services/FileContract.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:note/services/sl.dart';

class NotesProvider extends BaseProvider {
  NotesProvider() {
    if (_notesList == null) readFromStorage();
  }

  final _storage = sl.get<FileContract>();

  List<Note> _notesList;

  List<Note> get notes => _notesList;

  Note note = Note();

  stt.SpeechToText _speech;

  String _recordedText;

  String get extracted => _recordedText;

  bool recording = false;

  void initStt() {
    _speech = stt.SpeechToText();
  }

  void addNote(Note n) {
    _notesList.add(n);
    notifyListeners();
    saveToStorage();
  }

  void deleteNote(Note n) {
    _notesList.remove(n);
    notifyListeners();
    saveToStorage();
  }

  void update(Note newNote, Note oldNote) {
    final index = _notesList.indexWhere((o) => o == oldNote);
    _notesList[index] = newNote;
    notifyListeners();
    saveToStorage();
  }

  Future<void> record({BuildContext context, Function error}) async {
    if (!recording) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onstatus : Success $val '),
        onError: (val) {
          print('onerror : Sorry $val');
          error();
        },
      );
      if (available) {
        recording = true;
        _speech.listen(onResult: (val) {
          _recordedText = val.recognizedWords;
          return _recordedText;
        });
      }
    } else {
      recording = false;
      _speech.stop();
    }
    // notifyListeners();
  }

  Future<bool> saveToStorage() async {
    final list = Note.toJSONList(_notesList);
    print(jsonEncode(list));
    return _storage.writeFile(jsonEncode(list));
  }

  Future<void> readFromStorage() async {
    final json = await _storage.readFile();
    final list = jsonDecode(json).cast<Map<String, dynamic>>();
    _notesList = Note.fromJSONList(list);
    print(json);
    notifyListeners();
  }
}
