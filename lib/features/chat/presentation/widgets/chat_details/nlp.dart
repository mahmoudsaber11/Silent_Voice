// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:highlight_text/highlight_text.dart';
// import 'package:social_app/core/utils/app_color.dart';
// import 'package:social_app/core/utils/app_navigator.dart';
// import 'package:social_app/core/utils/app_text_style.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class SpeechScreen extends StatefulWidget {
//   const SpeechScreen({super.key});

//   @override
//   State<SpeechScreen> createState() => _SpeechScreenState();
// }

// class _SpeechScreenState extends State<SpeechScreen> {
//   final Map<String, HighlightedWord> highlights = {
//     'flutter': HighlightedWord(
//       textStyle:
//           const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//     ),
//     'voice': HighlightedWord(
//       textStyle:
//           const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//     ),
//     'subscribe': HighlightedWord(
//       textStyle:
//           const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//     ),
//     'like': HighlightedWord(
//       textStyle:
//           const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//     ),
//     'comment': HighlightedWord(
//       textStyle:
//           const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//     ),
//   };
//   late stt.SpeechToText speech;
//   String text = 'Press the button and start speaking';
//   bool isListening = false;
//   double confidence = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     speech = stt.SpeechToText();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: speechAppBar(context),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: AvatarGlow(
//           animate: isListening,
//           glowColor: Theme.of(context).primaryColor,
//           endRadius: 75.0,
//           duration: const Duration(microseconds: 2000),
//           repeatPauseDuration: const Duration(),
//           repeat: true,
//           child: FloatingActionButton(
//             onPressed: () => listen(),
//             child: Icon(isListening ? Icons.mic : Icons.mic_none),
//           )),
//       body: SingleChildScrollView(
//         reverse: true,
//         child: Container(
//           padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
//           child: TextHighlight(
//             text: text,
//             words: highlights,
//             textStyle: const TextStyle(
//               fontSize: 32.0,
//               color: Colors.black,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar speechAppBar(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       backgroundColor: AppColors.primaryColor,
//       title: Text(
//         'Confidence:${(confidence * 100.0).toStringAsFixed(1)}%',
//         style: AppTextStyles.textStyle25.copyWith(color: Colors.white),
//       ),
//       leading: IconButton(
//           onPressed: () {
//             context.getBack();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 30.sp,
//           )),
//     );
//   }

//   void listen() async {
//     if (!isListening) {
//       bool available = await speech.initialize();
//       if (available) {
//         setState(() {
//           isListening = true;
//         });
//         speech.listen(
//             onResult: (val) => setState(() {
//                   text = val.recognizedWords;
//                   if (val.hasConfidenceRating && val.confidence > 0) {
//                     confidence = val.confidence;
//                   }
//                 }));
//       } else {
//         setState(() {
//           isListening = false;
//         });
//         speech.stop();
//       }
//     }
//   }
// }
