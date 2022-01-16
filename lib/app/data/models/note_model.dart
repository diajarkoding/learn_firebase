import 'package:equatable/equatable.dart';

class NotesModel extends Equatable {
  final String id;
  final String title;
  final String description;

  const NotesModel({
    required this.id,
    this.title = '',
    this.description = '',
  });

  factory NotesModel.fromJson(String id, Map<String, dynamic> json) =>
      NotesModel(
        id: id,
        title: json['title'],
        description: json['description'],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
      ];
}
