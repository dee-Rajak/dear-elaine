import 'package:elaine/feature_box.dart';
import 'package:elaine/openai_service.dart';
import 'package:elaine/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedUrl;
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      // print(lastWords);
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elaine"),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.40,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.23,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile.png'),
                      )),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.02,
                vertical: screenWidth * 0.02,
              ),
              margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.04)
                  .copyWith(top: screenHeight * 0.01),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                  width: 2,
                ),
                borderRadius:
                    BorderRadius.circular(15).copyWith(topLeft: Radius.zero),
              ),
              child: Text(
                generatedContent == null
                    ? "Ara ara, How can I help you Sweetie 😘 ?"
                    : generatedContent!,
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontFamily: 'Cera Pro',
                  fontSize: generatedContent == null
                      ? screenHeight * 0.03
                      : screenHeight * 0.02,
                ),
              ),
            ),
            if (generatedUrl != null)
              Image.network(
                generatedUrl!,
                fit: BoxFit.scaleDown,
              ),
            Visibility(
              visible: generatedContent == null && generatedUrl == null,
              child: Container(
                // color: Colors.amber,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.08,
                ).copyWith(),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Here are a few features',
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: screenHeight * 0.025,
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedUrl == null,
              child: Column(
                children: const [
                  FeatureBox(
                    headerText: "ChatGPT",
                    bodyText:
                        "A smarter way to stay organized and informed with ChatGPT.",
                    color: Pallete.firstSuggestionBoxColor,
                  ),
                  FeatureBox(
                    headerText: "Dall-E",
                    bodyText:
                        "Get inspired and stay creative with your personal assistant powered by Dall-E.",
                    color: Pallete.secondSuggestionBoxColor,
                  ),
                  FeatureBox(
                    headerText: "Smart Voice Assistant",
                    bodyText:
                        "Get the best of both worlds with a boice assistant powered by Dall-E and ChatGPT.",
                    color: Pallete.thirdSuggestionBoxColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.assistantCircleColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAIService.isArtPromptAPI(lastWords);
            if (speech.contains('https')) {
              generatedUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedUrl = null;
              generatedContent = speech;
              setState(() {});
              await systemSpeak(speech);
            }
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}
