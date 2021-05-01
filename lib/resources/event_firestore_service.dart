import 'package:family/models/eventmodel.dart';
import 'package:firebase_helpers/firebase_helpers.dart';


DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("events",fromDS: (id,data) => EventModel.fromDS(id, data), toMap:(event) => event.toMap());