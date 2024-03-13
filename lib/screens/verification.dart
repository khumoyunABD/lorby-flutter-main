import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String? errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Text(thisText,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Container(
              alignment: Alignment.center,
              //height: 200.0,
              child: GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                              "Paste clipboard stuff into the pinbox?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () async {
                                  var copiedText =
                                      await Clipboard.getData("text/plain");
                                  if (copiedText!.text!.isNotEmpty) {
                                    controller.text = copiedText.text!;
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text("YES")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No"))
                          ],
                        );
                      });
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    const Text('Введи 4-значный код,'),
                    const Text('высланный на'),
                    const Text(
                      'randomemail@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      //height: 300,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 20,
                        //bottom: 30,
                      ),
                      child: PinCodeTextField(
                        autofocus: true,
                        controller: controller,
                        //hideCharacter: true,
                        highlight: true,
                        //highlightColor: Colors.blue,
                        defaultBorderColor: Colors.black,
                        hasTextBorderColor: Colors.green,
                        highlightPinBoxColor: Colors.orange,
                        maxLength: 4,
                        hasError: hasError,
                        //maskCharacter: "😎",
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        // onDone: (text) {
                        //   print("DONE $text");
                        //   print("DONE CONTROLLER ${controller.text}");
                        // },
                        pinBoxWidth: 60,
                        pinBoxHeight: 64,
                        hasUnderline: true,
                        //wrapAlignment: WrapAlignment.spaceEvenly,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: const TextStyle(fontSize: 22.0),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        //                    pinBoxColor: Colors.green[100],
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
                        //                    highlightAnimation: true,
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: Colors.black,
                            //foregroundColor: Colors.green,
                            //disabledBackgroundColor: Colors.black54,
                            padding: const EdgeInsets.only(
                              right: 80,
                              left: 80,
                              top: 20,
                              bottom: 20,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        child: const Text(
                          'Подтвердить',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            // Visibility(
            //   child: Text(
            //     "Wrong PIN!",
            //   ),
            //   visible: hasError,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 32.0),
            //   child: Wrap(
            //     alignment: WrapAlignment.spaceEvenly,
            //     children: <Widget>[
            //       if (!kIsWeb)
            //         MaterialButton(
            //           color: Colors.blue,
            //           textColor: Colors.white,
            //           child: Text("Copy 1234 to Clipboard"),
            //           onPressed: () {
            //             setState(() {
            //               Clipboard.setData(ClipboardData(text: "1111"));
            //             });
            //           },
            //         ),
            //       MaterialButton(
            //         color: Colors.blue,
            //         textColor: Colors.white,
            //         child: Text("+"),
            //         onPressed: () {
            //           setState(() {
            //             this.pinLength++;
            //           });
            //         },
            //       ),
            //       MaterialButton(
            //         color: Colors.blue,
            //         textColor: Colors.white,
            //         child: Text("-"),
            //         onPressed: () {
            //           setState(() {
            //             this.pinLength--;
            //           });
            //         },
            //       ),
            //       MaterialButton(
            //         color: Colors.blue,
            //         textColor: Colors.white,
            //         child: Text("SUBMIT"),
            //         onPressed: () {
            //           setState(() {
            //             this.thisText = controller.text;
            //           });
            //         },
            //       ),
            //       MaterialButton(
            //         color: Colors.red,
            //         textColor: Colors.white,
            //         child: Text("SUBMIT Error"),
            //         onPressed: () {
            //           setState(() {
            //             this.hasError = true;
            //           });
            //         },
            //       ),
            //       MaterialButton(
            //         color: Colors.pink,
            //         textColor: Colors.white,
            //         child: Text("CLEAR PIN"),
            //         onPressed: () {
            //           controller.clear();
            //         },
            //       ),
            //       MaterialButton(
            //         color: Colors.lime,
            //         textColor: Colors.black,
            //         child: Text("SET TO 456"),
            //         onPressed: () {
            //           controller.text = "456";
            //         },
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
