import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/app.dart';
import 'package:manuk_pos/observer.dart';
import 'package:manuk_pos/service_locator.dart';

void main() async {
  Bloc.observer = MyObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // init get_it
  runApp(ManukPosApp());
}
