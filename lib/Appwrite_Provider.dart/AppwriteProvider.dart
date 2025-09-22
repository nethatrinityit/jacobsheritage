import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:jacobsheritage/appwrite_constants.dart';

class Appwriteprovider {
  Client client = Client();
  Databases? databases;
  Storage? storage;

  Appwriteprovider() {
    client
        .setEndpoint(AppWriteConstants.endPoint)
        .setProject(AppWriteConstants.projectId)
        .setSelfSigned(status: true);

    storage = Storage(client);
    databases = Databases(client);
  }

  Future<models.DocumentList> fetchAllProd() async {
    try {
      models.DocumentList documents = await databases!.listDocuments(
        databaseId: AppWriteConstants.dbId,
        collectionId: AppWriteConstants.collectionId,
      );
      return documents;
    } catch (e) {
      rethrow;
    }
  }
}
