import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:yalt_app/application/providers/metric_provider.dart';
import 'package:yalt_app/application/services/log_service.dart';
import 'package:yalt_app/application/services/time_tracker_service.dart';
import 'package:yalt_app/data/local/isar_collections.dart';
import 'package:yalt_app/data/local/isar_gateway.dart';
import 'ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String dir;

  if (kIsWeb) {
    dir = ''; // Web uses empty string
  } else {
    final directory = await getApplicationDocumentsDirectory();
    dir = directory.path;
  }

  final isar = await Isar.open([MetricEntryIsarSchema], directory: dir);
  final logService = LogService(IsarGateway(isar));
  final timeTrackerService = TimeTrackerService(IsarGateway(isar));

  runApp(
    ProviderScope(
      overrides: [
        logServiceProvider.overrideWithValue(logService),
        timeTrackerServiceProvider.overrideWithValue(timeTrackerService),
      ],
      child: const MyApp(),
    ),
  );
}
