import 'dart:async';

import 'package:firestore_service/firestore_service.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/app_page.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_path.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase();

  final _service = FirestoreService.instance;

  Stream<AppPage> appPageStream({required String appPageId}) =>
      _service.documentStream(
        path: FirestorePath.appPage(appPageId),
        builder: (data, documentId) => AppPage.fromMap(data, documentId),
      );

  Stream<List<AppPage>> appPagesStream() => _service.collectionStream(
        path: FirestorePath.appPages(),
        builder: (data, documentId) => AppPage.fromMap(data, documentId),
      );
}
