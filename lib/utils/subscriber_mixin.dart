import 'dart:async';

mixin SubscriberMixin {
  final subscriptions = <StreamSubscription>[];
  void subscribeIt(StreamSubscription ss) {
    subscriptions.add(ss);
  }

  FutureOr unsubscribeAll() {
    // TODO Iosif: is this function really the opposite of subscribeIt?
    for (final ss in subscriptions) {
      ss.cancel();
    }
  }
}
