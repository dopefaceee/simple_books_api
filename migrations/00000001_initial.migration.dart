import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Book", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("title", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),SchemaColumn("author", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("year", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
    final List<Map> books = [
    {
        "title": "Best Seller: Hunger Wolf",
        "author": "J.J Thompson",
        "year": 2009
      },
     {
        "title": "The Art of Grow Fine",
        "author": "Mathias Eleagor",
        "year": 2017
      },
     {
        "title": "Inside of a Tech Cube",
        "author": "Aliana Jeanne",
        "year": 2019
      },
    ];

    for (final book in books) {
      await database.store.execute("INSERT INTO _Book (title, author, year) VALUES (@title, @author, @year)",
      substitutionValues:  {
        'title': book['title'],
        'author': book['author'],
        'year': book['year'],
      });

    }
  }
}
    