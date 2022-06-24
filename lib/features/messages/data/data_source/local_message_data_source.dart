import 'dart:math';

import '../../../shared/data/data_source/app_database.dart';
import '../../domain/entity/message.dart';

class LocalMessageDataSource {
  const LocalMessageDataSource({required this.database});

  final AppDatabase database;

  Future<List<Message>> fetchMessagesFromLocalStorage() async {
    final data = await database.fetchMessages();
    return data
        .map((e) => Message(
            title: e.description,
            body: e.description,
            createdAt: DateTime.now(),
            room: e.description,
            type: e.description))
        .toList();
  }

  Future addMessageToLocalStorage(Message message) async {
    final entry = MessageEntry(id: Random().nextInt(99999999), description: message.body);
    database.addMessage(entry);
  }

  Future removeMessageFromLocalStorage(int index) async {}

  Future updateMessageInLocalStorage(int index, Message message) async {}

  Future removeAllMessagesInLocalStorage() async {}
}
