import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/messages/presentation/bloc/message_bloc.dart';


class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print("Powrót aplikacji");
      }
      context.read<MessageBloc>().add(MessageInit());
    }
    if (state == AppLifecycleState.paused) {
      if (kDebugMode) {
        print("Pause aplikacji");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<MessageBloc>()..add(MessageInit()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageInitial) {
                  return const Text("Ladowanie danych...");
                } else if (state is MessageData) {
                  return Text("Załadowano ${state.messages.length} wiadomości");
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          body: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              if (state is MessageInitial) {
                return const Text("Ladowanie danych...");
              } else if (state is MessageData) {
                return Text("Załadowano ${state.messages.length} wiadomości");
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Test snackbar"),
              ));
            },
          ),
        ),
      ),
    );
  }
}
