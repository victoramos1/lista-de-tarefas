import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  TextEditingController controllerInserirDado = TextEditingController();
  TextEditingController controllerEditarDado = TextEditingController();

  List<String> itens = [];

  void inserirDado(){
    if(controllerInserirDado.text == ""){
    } else{
      setState(() {
        itens.add(controllerInserirDado.text);
      });
    }
  }

  editarDado(indice){
    showDialog(
      context: context,
      builder: (builder){
        return AlertDialog(
          title: Text("Editar"),
          content: TextField(
            controller: controllerEditarDado,
            decoration: InputDecoration(
              hintText: "Digite aqui"
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Salvar"),
              onPressed: () {
                setState(() {
                  itens[indice] = controllerEditarDado.text;
                  controllerEditarDado.clear();
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  apagarDado(indice){
    setState(() {
      itens.removeAt(indice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text("Insira suas anotações abaixo")
            ),
            Container(
              width: 400,
              child: TextField(
                controller: controllerInserirDado,
                decoration: InputDecoration(
                  labelText: "Digite aqui"
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 30),
              child: ElevatedButton(
                onPressed: inserirDado,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 40),
                  backgroundColor: Colors.blue
                ),
                child: Text("Inserir",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              )
            ),
            Text("Inserções",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itens.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(itens[index]),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  editarDado(index);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: (){
                                  apagarDado(index);
                                },
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
