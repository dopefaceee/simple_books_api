import 'package:books_api/books_api.dart';

class Book extends ManagedObject<_Book> implements _Book {
  String get detail => '$title by $author';
}


class _Book {
  @primaryKey
  int id;

  @Column(unique: true)
  String title;

  @Column()
  String author;

  @Column()
  int year;
}
