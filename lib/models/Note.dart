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

  Map<String, dynamic> toJSON() {
    return {
      "title": title,
      "content": text,
    };
  }
}
