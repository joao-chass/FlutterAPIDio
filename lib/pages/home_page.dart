import 'package:desafio_api/model/BuscaCepModel.dart';
import 'package:desafio_api/repository/busca_cep_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuscaCepRepository buscaCepRepository = BuscaCepRepository();
  var _dadosBuscaCep = BuscaCepModel();
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  var carregando = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
        child: carregando
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Tooltip(
                      triggerMode: TooltipTriggerMode.manual,
                      key: tooltipkey,
                      showDuration: const Duration(seconds: 3),
                      message: 'Cep invalido'),
                  TextField(
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Digite seu CEP'),
                    onChanged: (text) async {
                      if (text.length == 8) {
                        setState(() {
                          carregando = true;
                        });
                        _dadosBuscaCep =
                            await buscaCepRepository.obeterCep(text);

                        setState(() {
                          carregando = false;
                        });
                        if (_dadosBuscaCep.cep == null) {
                          tooltipkey.currentState?.ensureTooltipVisible();
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext bc) {
                                return AlertDialog(
                                  title: const Text("Endereco encotrado"),
                                  content: Column(
                                    children: [
                                      Text(_dadosBuscaCep.cep.toString()),
                                      Text(
                                          _dadosBuscaCep.logradouro.toString()),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancelar")),
                                    TextButton(
                                        onPressed: () async {
                                          // await tarefaRepository.criar(TarefaBack4App.criar(
                                          //     descricaoContoller.text, false));
                                          Navigator.pop(context);
                                          // obterTarefas();
                                          // setState(() {});
                                        },
                                        child: const Text("Salvar"))
                                  ],
                                );
                              });
                        }
                      }
                    },
                  ),
                  const Text(
                    "CEPs Cadastrados",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w400),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text("02132051"),
                      trailing: Icon(Icons.edit),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext bc) {
                              return AlertDialog(
                                title: const Text("Editar"),
                                content: Column(
                                  children: const [
                                    TextField(
                                      maxLength: 8,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Digite o novo CEP'),
                                    ),
                                    Text("02132050"),
                                    Text("Rua das esmeraldas Nº 123"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancelar")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Deletar")),
                                  TextButton(
                                      onPressed: () async {
                                        // await tarefaRepository.criar(TarefaBack4App.criar(
                                        //     descricaoContoller.text, false));
                                        Navigator.pop(context);
                                        // obterTarefas();
                                        // setState(() {});
                                      },
                                      child: const Text("Salvar"))
                                ],
                              );
                            });
                      },
                    ),
                  )
                ],
              ),
      ),
    ));
  }
}
