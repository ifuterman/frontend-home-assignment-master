import 'dart:async';

mixin SubscriberMixin {
  final subscriptions = <StreamSubscription>[];
  void subscribeIt(StreamSubscription ss) {
    subscriptions.add(ss);
  }

  FutureOr unsubscribeAll() {
    for (final ss in subscriptions) {
      ss.cancel();
    }
  }
}
