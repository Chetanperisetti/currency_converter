import 'package:currency_convertor/database/database_helper.dart';
import 'package:flutter/material.dart';


class CurrencyConvertorPagee extends StatefulWidget {
  const CurrencyConvertorPagee({super.key});

  @override
  State createState() => _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState extends State<CurrencyConvertorPagee> {
  final DBhelper _database=DBhelper.instance;
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  List<Map<String,dynamic>> _history = [];

  void coverting() async{
    
    double input = double.parse(textEditingController.text);
    setState(() {
      result = input * 84.67;
    });
    await DBhelper.instance.insert(input.toString(), result.toDouble());
    _loadHistory();
    
    
    //history.add('USD $input = INR $result' as Map<String, dynamic>);
  }
  @override
  void initState(){
    super.initState();
    _loadHistory();
  }
  void _loadHistory() async{
    final data= await DBhelper.instance.getHistory();
    setState(() {
      _history=data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 0, 140, 255),
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 131, 175, 249),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 131, 175, 249),
        elevation: 0,
        title: Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () async{
              await _database.clearHistory();
              _loadHistory();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('History cleared!')),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'INR $result',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  prefixIcon: Icon(Icons.monetization_on),
                  prefixIconColor: Colors.blueAccent,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                    coverting();
                  },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Convert'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final item=_history[index];
                  return ListTile(
                    title: Text(
                      'USD ${item['input']} = INR ${item['result']}',
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
