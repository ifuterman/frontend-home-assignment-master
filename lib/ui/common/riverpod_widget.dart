import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class RiverpodWidget<C extends RiverpodController>
    extends ConsumerWidget {
  RiverpodWidget({required this.builder, super.key}) {
    controller = builder();
    controller.widget = this;
  }

  late final C controller;
  final C Function() builder;
  @override
  Widget build(BuildContext context, WidgetRef ref);
}

abstract class RiverpodController<W extends ConsumerWidget> {
  late final W widget;
}

abstract class RiverpodStatefulWidget<C extends RiverpodStatefulController>
    extends ConsumerStatefulWidget {
  const RiverpodStatefulWidget(this.controller, {super.key});
  final C controller;
}

abstract class RiverpodState<C extends RiverpodStatefulWidget>
    extends ConsumerState<C> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.onDispose();
  }
}

abstract class RiverpodStatefulController {
  final subscriptions = <StreamSubscription>[];
  void subscribeIt(StreamSubscription ss) {
    subscriptions.add(ss);
  }

  @mustCallSuper
  FutureOr onDispose() {
    debugPrint('SubscriptionController.onDispose');
    for (final ss in subscriptions) {
      ss.cancel();
    }
  }
}
