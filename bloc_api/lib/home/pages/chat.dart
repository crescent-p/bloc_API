import 'dart:convert';

import 'package:bloc_api/methods/chat/chatmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late final TextEditingController promptController;
  String responseTxt = 'This is a Sample Response';
  late ResponseModel _responseModel;

  @override
  void initState() {
    super.initState();
    dotenv.load();
    promptController = TextEditingController();
  }

  @override
  dispose() {
    promptController.dispose();
    super.dispose();
  }

  completionFun() async {
    setState(() => responseTxt = 'This is a Sample Response');

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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'
      },
      body: jsonEncode(
        {
          "model": "davinci",
          "prompt": promptController.text,
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        },
      ),
    );

    setState(() {
      _responseModel = ResponseModel.fromJson(response);
      responseTxt = _responseModel.response.body;
      print(responseTxt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PromptBldr(
              responseTxt: responseTxt,
            ),
            TextFormFieldBldr(
                promptController: promptController, btnFun: completionFun),
          ],
        ),
      ),
    );
  }
}

class PromptBldr extends StatelessWidget {
  final String responseTxt;
  const PromptBldr({super.key, required this.responseTxt});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.69,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xff343541),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          responseTxt,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class TextFormFieldBldr extends StatelessWidget {
  final TextEditingController promptController;
  final Function btnFun;
  const TextFormFieldBldr(
      {super.key, required this.promptController, required this.btnFun});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 9, 116, 32),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.09,
            child: Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: promptController,
                style: const TextStyle(color: Color.fromARGB(255, 2, 76, 1)),
                decoration: const InputDecoration(
                  hintText: 'Enter your prompt here',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 168, 26, 26)),
                  border: InputBorder.none,
                ),
                maxLines: 10,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 22, 101, 2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ElevatedButton(
            onPressed: () => btnFun(),
            child: const Icon(
              Icons.send,
              color: Colors.green,
            ),
          ),
        ),
      ]),
    );
  }
}
