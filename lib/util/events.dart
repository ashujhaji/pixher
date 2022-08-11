
import 'dart:io';

import 'package:event_bus/event_bus.dart';

class EventBusHelper{
  EventBusHelper._privateConstructor();

  static final EventBusHelper instance = EventBusHelper._privateConstructor();
  EventBus? eventBus;

  EventBus getEventBus(){
    eventBus ??= EventBus();
    return eventBus!;
  }

}

class GenerateHashtagEvent{
  File? file;
  GenerateHashtagEvent(this.file);
}