class Note {
  int? id;
  String? title;
  String? body;
  DateTime? created;
  DateTime? modified;

  //Add extra metadata (Date created, Date modified, Length of body?, etc)
  Note({this.id, this.title, this.body, this.created, this.modified});

  void setId(int id_)
  {
    id = id_;
  }

  Map<String, Object?> toMap() {
    return 
    {'title': title, 'body': body, 'created': created.toString(), 'modified': modified.toString()};
  }

  factory Note.fromMap(Map<String, Object?> map)
  {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      created: DateTime.parse(map['created'] as String),
      modified: DateTime.parse(map['modified'] as String)
    );
  }
}