import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/core/dependency_injection.dart';
import 'package:quiz_app/features/init/bloc/init_bloc.dart';
import 'package:quiz_app/features/init/pages/init_page.dart';
import 'package:quiz_app/features/messages/presentation/pages/message_page.dart';
import 'package:quiz_app/features/shared/data/data_source/app_database.dart';
import 'package:path/path.dart' as p;

import 'features/messages/domain/use_case/add_message_use_case.dart';
import 'firebase_options.dart';
import 'features/messages/domain/entity/message.dart';
import 'features/messages/presentation/bloc/message_bloc.dart';
import 'package:drift/isolate.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // await DiContainer().init();

  if (kDebugMode) {
    print("Handling a background message: ${message.data}");
  }

  if (message.data.isNotEmpty) {
    final messageFromFCM = Message.fromJson(message.data);
    if (kDebugMode) {
      print(messageFromFCM);
    }
    DriftIsolate isolate = await _createDriftIsolate();

    // we can now create a database connection that will use the isolate internally. This is NOT what's
    // returned from _backgroundConnection, drift uses an internal proxy class for isolate communication.
    DatabaseConnection connection = await isolate.connect();

    final db = AppDatabase.connect(connection);
    db.addMessage(MessageEntry(id: Random().nextInt(99999), description: 'asdsadasdasd'));
    // di.get<AddMessageUseCase>().call(AddMessageUseCaseParams(message: messageFromFCM));
  }
}

Future<DriftIsolate> _createDriftIsolate() async {
  // this method is called from the main isolate. Since we can't use
  // getApplicationDocumentsDirectory on a background isolate, we calculate
  // the database path in the foreground isolate and then inform the
  // background isolate about the path.
  final dir = await getApplicationDocumentsDirectory();
  final path = p.join(dir.path, 'db.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  // _startBackground will send the DriftIsolate to this ReceivePort
  return await receivePort.first as DriftIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  // this is the entry point from the background isolate! Let's create
  // the database from the path we received
  final executor = NativeDatabase(File(request.targetPath));
  // we're using DriftIsolate.inCurrent here as this method already runs on a
  // background isolate. If we used DriftIsolate.spawn, a third isolate would be
  // started which is not what we want!
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  // inform the starting isolate about this, so that it can call .connect()
  request.sendDriftIsolate.send(driftIsolate);
}

// used to bundle the SendPort and the target path, since isolate entry point
// functions can only take one parameter.
class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

void main() async {
  await DiContainer().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messageBloc = di.get<MessageBloc>();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
    }

    if (message.notification != null) {
      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
    }

    if (message.data.isNotEmpty) {
      final messageFromFCM = Message.fromJson(message.data);
      if (kDebugMode) {
        print(messageFromFCM);
      }
      messageBloc.add(MessageAdd(message: messageFromFCM));
    }
  });

  FirebaseMessaging.instance.getToken().then((token) {
    if (kDebugMode) {
      print("token $token");
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiBlocProvider(
      providers: [BlocProvider<MessageBloc>(create: (context) => messageBloc)],
      child: const MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitBloc()..add(InitApp()),
      child: Builder(
          builder: (context) => BlocBuilder<InitBloc, InitState>(
                builder: (context, state) {
                  if (state is InitInitial) {
                    return MaterialApp(title: 'Quiz App', theme: ThemeData.light(), home: const InitPage());
                  } else if (state is InitSuccess) {
                    return MaterialApp(title: 'Quiz App', theme: ThemeData.light(), home: const MessagePage());
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )),
    );
    // return MaterialApp(
    //     title: 'Quiz App',
    //     theme: ThemeData.light(),
    //     home: const QuizPage());
  }
}
