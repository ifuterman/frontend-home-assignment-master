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
  /// TODO Iosif: Use of late is prown to errors. You allow a developer to
  /// extend RiverpodController but you expect him to remember to initialize
  /// "widget" himself. Also, it's not clear at all what's the purpose of this
  /// field as it's not used anywhere.
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
