import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  final String connectionString =
      'mongodb+srv://sp:EyJqonVw4f9ghAUA@gmp.hjsqsex.mongodb.net/Orig';

  Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await Db.create(connectionString);
    await db.open();

    final collection = db.collection('GMPADMIN_newpropertyentry');
    final cursor = await collection.find();

    final List<Map<String, dynamic>> data = await cursor.toList();

    await db.close();

    return data;
  }
}

