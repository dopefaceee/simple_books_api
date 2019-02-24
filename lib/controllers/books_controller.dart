import 'package:aqueduct/aqueduct.dart';
import 'package:books_api/books_api.dart';
import 'package:books_api/models/book.dart';

class BooksController extends ResourceController {
  ManagedContext context;
  BooksController(this.context);

  @Operation.get('id')
  Future<Response> getBook(@Bind.path('id') int id) async {
    final bookQuery = Query<Book>(context)
      ..where((book) => book.id).equalTo(id);

    final book = await bookQuery.fetchOne();

    if (book == null) {
      return Response.notFound(body: 'Item not found.');
    }
    return Response.ok(book);
  }

  @Operation.get()
  Future<Response> getAllBooks() async {
    final bookQuery = Query<Book>(context);
    return Response.ok(await bookQuery.fetch());
  }

  @Operation.post()
  Future<Response> createNewBook(@Bind.body() Book body) async {
    final bookQuery = Query<Book>(context)..values = body;

    final insertedBook = await bookQuery.insert();

    return Response.ok(insertedBook);
  }

  @Operation.put('id')
  Future<Response> updateBook(
      @Bind.path('id') int id, @Bind.body() Book body) async {
    final bookQuery = Query<Book>(context)
      ..values = body
      ..where((read) => read.id).equalTo(id);

    final updatedBook = await bookQuery.update();

    if (updatedBook == null) {
      return Response.notFound(body: 'Item not found.');
    }

    return Response.ok(updatedBook);
  }

  @Operation.delete('id')
  Future<Response> deleteBook(@Bind.path('id') int id) async {
    final bookQuery = Query<Book>(context)
      ..where((read) => read.id).equalTo(id);

    final int deletedBook = await bookQuery.delete();

    if (deletedBook == 0) {
      return Response.notFound(body: 'Item not found.');
    }
    return Response.ok("Deleted $deletedBook items.");
  }
}
