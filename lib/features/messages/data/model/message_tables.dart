import 'dart:ui';

export 'dart:ui' show Color;

import 'package:drift/drift.dart';

@DataClassName('MessageEntry')
class MessageEntries extends Table with AutoIncrementingPrimaryKey {
  TextColumn get description => text()();
}

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}
