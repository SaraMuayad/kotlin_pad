import 'package:code_text_field/code_text_field.dart';

import 'package:flutter/material.dart';
import 'package:highlight/languages/kotlin.dart';
import 'package:kotlin_pad/screens/console.dart';
import '../service/compiler_process.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  String result = "";
  final APICompiler _apiCompiler = new APICompiler();

  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    var source = "fun main() {\n  println(\"Hello World!\") \n}";

    _codeController = CodeController(
      text: source,
      language: kotlin,
      patternMap: {
        r'".*"': const TextStyle(color: Color(0xff6A8759)),
        r'[[//] [a-zA-Z]]': const TextStyle(color: Color(0xff61A051)),
        r'[/**a-zA-Z-*/]': const TextStyle(color: Color(0xff61A051)),
        r'[{}]': const TextStyle(color: Color(0xffA9B8C5)),
        r'[0-9]': const TextStyle(color: Color(0xffA9B8C5)),
        r'[()]': const TextStyle(color: Color(0xffA9B8C5)),
      },
      stringMap: {
        "fun": const TextStyle(color: Color(0xffCC7832)),
        "main": const TextStyle(color: Color(0xffA9B8C5)),
        "println": const TextStyle(color: Color(0xffA9B8C5)),
        "print": const TextStyle(color: Color(0xffA9B8C5)),
        "for": const TextStyle(color: Color(0xffCC7832)),
        "while": const TextStyle(color: Color(0xffCC7832)),
        "do": const TextStyle(color: Color(0xffCC7832)),
        "int": const TextStyle(color: Color(0xffCC7832)),
        "float": const TextStyle(color: Color(0xffCC7832)),
        "double": const TextStyle(color: Color(0xffCC7832)),
        "var": const TextStyle(color: Color(0xffCC7832)),
        "val": const TextStyle(color: Color(0xffCC7832)),
        "bool": const TextStyle(color: Color(0xffCC7832)),
        "true": const TextStyle(color: Color(0xffff916d)),
        "false": const TextStyle(color: Color(0xffff916d)),
        "is": const TextStyle(color: Color(0xffff916d)),
        "null": const TextStyle(color: Color(0xffff916d)),
        "Byte": const TextStyle(color: Color(0xffff916d)),
        "Int": const TextStyle(color: Color(0xffff916d)),
        "Float": const TextStyle(color: Color(0xffff916d)),
        "Long": const TextStyle(color: Color(0xffff916d)),
        "Double": const TextStyle(color: Color(0xffff916d)),
        "Boolean": const TextStyle(color: Color(0xffff916d)),
        "Char": const TextStyle(color: Color(0xffff916d)),
        "length": const TextStyle(color: Color(0xffff916d)),
        "toUpperCase": const TextStyle(color: Color(0xffff916d)),
        "toLowerCase": const TextStyle(color: Color(0xffff916d)),
        "compareTo": const TextStyle(color: Color(0xffff916d)),
        "indexOf": const TextStyle(color: Color(0xffff916d)),
        "plus": const TextStyle(color: Color(0xffff916d)),
        "when": const TextStyle(color: Color(0xffff916d)),
        "break": const TextStyle(color: Color(0xffff916d)),
        "arrayOf": const TextStyle(color: Color(0xffff916d)),
        "get": const TextStyle(color: Color(0xffff916d)),
        "continue": const TextStyle(color: Color(0xffff916d)),
        "size": const TextStyle(color: Color(0xffff916d)),
        "class": const TextStyle(color: Color(0xffff916d)),
        "in": const TextStyle(color: Color(0xffff916d)),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff27282C),
          leading: PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Editor()),
                          ).then((value) => setState(() {}));
                        },
                        child: const Text(
                          "New Pad",
                          style: TextStyle(color: Color(0xff1C2834)),
                        ),
                      )),
                  PopupMenuItem<int>(
                    value: 1,
                    child: TextButton(
                      onPressed: () {
                        _codeController.clear();
                      },
                      child: const Text(
                        "Rest",
                        style: TextStyle(color: Color(0xff1C2834)),
                      ),
                    ),
                  ),
                ];
              }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                width: 25,
                height: 25,
                image: AssetImage('assets/images/Kotlin.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "KotlinPad",
                style: TextStyle(fontSize: 27),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 23),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      result = _codeController.text.toString();
                      _apiCompiler.getCompiler(result);

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Console(output: _apiCompiler.output)));
                      });
                    });
                  },
                  icon: const Icon(Icons.play_arrow)),
            )
          ],
        ),
        body: Column(
          children: [
            Row(children: [
              SizedBox(
                  width: 390.0,
                  height: 741.0,
                  child: CodeField(
                    background: const Color(0xff1B1B1B),
                    controller: _codeController,
                    textStyle:
                        const TextStyle(fontFamily: 'SourceCode', fontSize: 20),
                    minLines: 14,
                  )),
            ]),
          ],
        ));
  }
}
