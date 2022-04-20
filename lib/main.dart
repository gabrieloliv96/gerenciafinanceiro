// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciafin/calculos.dart';
import 'package:gerenciafin/conta_controller.dart';
import 'package:gerenciafin/conta_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nome = TextEditingController();
  TextEditingController valor = TextEditingController();
  List<String> tipoConta = [
    'Pagamento',
    'Credito',
    'Dinheiro',
    'Pix',
    'Outros'
  ];
  String? selecionado = 'Pagamento';

  List<ContaModel> registros = [];

  String valorTotal = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nome,
                    decoration: InputDecoration(
                      label: Text('Nome'),
                      hoverColor: Colors.black,
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownButtonFormField<String>(
                      value: tipoConta[0],
                      items: tipoConta.map((tipo) {
                        return DropdownMenuItem(
                          child: Text(tipo),
                          value: tipo,
                        );
                      }).toList(),
                      onChanged: (String? tipo) {
                        setState(
                          () {
                            selecionado = tipo;
                          },
                        );
                        print(selecionado);
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: valor,
                    decoration: InputDecoration(
                      label: Text('Valor'),
                      hoverColor: Colors.black,
                      // labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(valorTotal),
                      hoverColor: Colors.black,
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: registros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(registros[index].nome),
                  subtitle: Text(registros[index].valor),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: ,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Calculos.resultado(registros).then((double value) {
              //   if (value > 0) {}
              // });
              setState(() {
                valorTotal = '${Calculos.resultado(registros)}';
              });
              print('teste');
              AlertDialog(
                content: Text('0'),
              );
            },
            child: const Icon(Icons.attach_money_outlined),
          ),
          FloatingActionButton(
            onPressed: () {
              ContaModel conta = ContaModel(
                  nome: nome.text, tipo: selecionado!, valor: valor.text);

              if (nome.text.isNotEmpty) {
                setState(() {
                  registros.add(conta);

                  nome.clear();
                  selecionado = tipoConta[0];
                  valor.clear();
                });
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   // color: Colors.blue.sha,
      //   alignment: Alignment.bottomLeft,
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
