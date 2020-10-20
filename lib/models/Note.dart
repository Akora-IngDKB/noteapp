class Note {
  String title;
  String text;

  Note({
    this.title = '',
    this.text = '',
  });

  factory Note.fromJSON(Map<String, dynamic> json) {
    return new Note(
      title: json["title"],
      text: json["text"],
    );
  }

  static List<Note> fromJSONList(List<Map<String, dynamic>> json) {
    final list = List<Note>();
    json.forEach((note) => list.add(Note.fromJSON(note)));
    return list;
  }

  Map<String, dynamic> toJSON() {
    return {
      "title": title,
      "content": text,
    };
  }

  static List<Map<String, dynamic>> toJSONList(List<Note> notes) {
    final list = List<Map<String, dynamic>>();
    notes.forEach((note) => list.add(note.toJSON()));
    return list;
  }
}
