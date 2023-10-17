import 'dart:async';

class DisposableWidget {

  List<StreamSubscription> _subscriptions = [];

  Future<void> cancelSubscriptions() async {
    _subscriptions.forEach((subscription) {
      subscription.cancel();
    });
  }

  Future<void> addSubscription(StreamSubscription subscription) async {
    _subscriptions.add(subscription);
  }
}

extension DisposableStreamSubscriton on StreamSubscription {
  void canceledBy(DisposableWidget widget) {
    widget.addSubscription(this);
  }
}