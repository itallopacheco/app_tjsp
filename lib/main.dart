import 'package:app_tjsp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/views/app_widget.dart';

/// Função principal que inicia a execução do aplicativo.
/// Ela chama a função runApp() passando como parâmetro o widget AppWidget.
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AppWidget());
}
