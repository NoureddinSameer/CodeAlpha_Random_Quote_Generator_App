import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

class QuoteGeneratorPage extends StatefulWidget {
  const QuoteGeneratorPage({super.key});

  @override
  State<QuoteGeneratorPage> createState() => _QuoteGeneratorPageState();
}

class _QuoteGeneratorPageState extends State<QuoteGeneratorPage> {
  final String quoteURL = "https://api.adviceslip.com/advice";
  String quote = '';
  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  generateQuote() async {
    var res = await http.get(Uri.parse(quoteURL));
    var result = jsonDecode(res.body);
    setState(() {
      quote = result["slip"]["advice"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote Generator'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150.0),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Card(
                      elevation: 4,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Center(
                              child: Text(
                                quote,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      generateQuote();
                    },
                    icon: const Icon(
                      Icons.group_work_outlined,
                      semanticLabel: 'Generate',
                    ),
                    label: const Text('Generate'),
                  ),
                  
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (quote != '') {
                        Share.share(quote);
                      } else {
                        var snackBar = const SnackBar(content: Text('No Data'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: const Icon(
                      Icons.share,
                      semanticLabel: 'Share',
                    ),
                    label: const Text('Share'),
                  ),
                  
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
