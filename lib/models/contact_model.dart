class MyContact {
  final int? id;
  final String number;
  final String name;

  MyContact({required this.number, required this.name, this.id});

  factory MyContact.fromJson(Map<String, dynamic> json) =>
      MyContact(id: json['id'], number: json['number'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'number': number, 'name': name};


}
