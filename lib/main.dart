import 'package:avaliacao_flutter/ui/transacao/viewmodel/transacao_viewmodel.dart';
import 'package:avaliacao_flutter/ui/transacao/widgets/transacao_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.lightBlue)),
      home: TransacaoView(viewModel: TransacoesViewModel()),
    );
  }
}
