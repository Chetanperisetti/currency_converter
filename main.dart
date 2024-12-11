
import 'package:currency_convertor/currency_coverter_page.dart';
import 'package:flutter/material.dart';
//import 'model/currency_model.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.instance.initDB();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConvertorPagee(),
    );
  }
}