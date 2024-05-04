// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// //
// // import '../../../bloc/auth/auth_bloc.dart';
// // import '../../../data/locol/storage_reposirory.dart';
// // import '../../../service/biyometrik_servis.dart';
// // import '../../../utils/styles/app_text_style.dart';
// // import '../../routs.dart';
// //
// // class EntryPinScreen extends StatefulWidget {
// //   const EntryPinScreen({super.key}) ;
// //
// //   @override
// //   State<EntryPinScreen> createState() => EntryPinScreenState();
// // }
// //
// // class EntryPinScreenState extends State<EntryPinScreen> {
// //   final TextEditingController pinPutController = TextEditingController();
// //   final FocusNode focusNode = FocusNode();
// //   bool isError = false;
// //   String currentPin = "";
// //   bool biometricsEnabled = false;
// //   int attemptCount = 0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     biometricsEnabled = StorageRepository.getBool(key: "biometrics_enabled") ?? false;
// //     currentPin = StorageRepository.getString(key: "pin_code") ?? "";
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.of(context).size.height;
// //     final width = MediaQuery.of(context).size.width;
// //
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           SizedBox(
// //             height: height / 10,
// //             child: Text(
// //               "Pin Kodni kiriting!",
// //               style: AppTextStyle.interSemiBold.copyWith(fontSize: 20),
// //             ),
// //           ),
// //           SizedBox(height: 32),
// //           SizedBox(
// //             width: width / 2,
// //             child: PinPutTextView(
// //               isError: isError,
// //               pinPutFocusNode: focusNode,
// //               pinPutController: pinPutController,
// //             ),
// //           ),
// //           SizedBox(height: 32),
// //           Text(
// //             isError ? "Pin kod noto'g'ri!" : "",
// //             style: AppTextStyle.interMedium.copyWith(color: Colors.red),
// //           ),
// //           if (height > 700) SizedBox(height: 32),
// //           CustomKeyboardView(
// //             onFingerPrintTap: checkBiometrics,
// //             number: (number) {
// //               if (pinPutController.text.length < 4) {
// //                 setState(() {
// //                   isError = false;
// //                 });
// //               }
// //               pinPutController.text = "${pinPutController.text}$number";
// //               if (pinPutController.text.length == 4) {
// //                 if (currentPin == pinPutController.text) {
// //                   Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
// //                 } else {
// //                   attemptCount++;
// //                   if (attemptCount == 3) {
// //                     context.read<AuthBloc>().add(LogOutUserEvent());
// //                     setState(() {
// //                       isError = true;
// //                     });
// //                   }
// //                   pinPutController.clear();
// //                 }
// //                 pinPutController.text = "";
// //               }
// //             },
// //             isBiometricsEnabled: biometricsEnabled,
// //             onClearButtonTap: () {
// //               if (pinPutController.text.length > 0) {
// //                 setState(() {
// //                   pinPutController.text = pinPutController.text.substring(0, pinPutController.text.length - 1);
// //                 });
// //               }
// //             },
// //           ),
// //           BlocListener<AuthBloc, AuthState>(
// //             listener: (context, state) {
// //               if (state.status == FormsStatus.unauthenticated) {
// //                 Navigator.pushNamedAndRemoveUntil(context, RouteNames.authRoute, (route) => false);
// //               }
// //             },
// //             child: const SizedBox(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Future<void> checkBiometrics() async {
// //     bool authenticated = await BiometricAuthService.authenticate();
// //     if (authenticated && mounted) {
// //       if(!context.mounted){
// //        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
// //       }
// //     }
// //   }
// // }
//
//
// import 'package:exson_bank/utils/size/size.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'cubit/check_cubit.dart';
//
// class EnterScreen extends StatefulWidget {
//   const EnterScreen({super.key});
//
//   @override
//   State<EnterScreen> createState() => _EnterScreenState();
// }
//
// class _EnterScreenState extends State<EnterScreen> {
//   String pinCode = "";
//
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     height = MediaQuery.of(context).size.height;
//
//     Widget buttonItems({required String title}) {
//       return TextButton(
//         style: TextButton.styleFrom(
//           padding: EdgeInsets.symmetric(
//             horizontal: 33.w,
//             vertical: 25.h,
//           ),
//           backgroundColor: Colors.white10,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//         ),
//         onPressed: () {
//           pinCode += title;
//           if (pinCode.length == 4) {
//             context.read<CheckCubit>().toCheckPinCode(pinCode, context);
//             pinCode = "";
//           }
//           setState(() {});
//         },
//         child: Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24.w,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
//     }
//
//     return BlocBuilder<CheckCubit, String>(
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Colors.black,
//           body: Stack(
//             children: [
//               Positioned(
//                 top: 100,
//                 left: -50,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.yellow.withOpacity(0.4),
//                           spreadRadius: 40,
//                           blurRadius: 100)
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 100,
//                 left: -50,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.purple.withOpacity(0.4),
//                           spreadRadius: 60,
//                           blurRadius: 100)
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 150,
//                 right: -50,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.green.withOpacity(0.4),
//                           spreadRadius: 40,
//                           blurRadius: 100)
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Column(
//                     children: [
//                       70.getH(),
//                       Center(
//                         child: Text(
//                           "Security screen",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24.w,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       50.getH(),
//                       Center(
//                         child: Text(
//                           "Enter your passcode",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.w,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       25.getH(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ...List.generate(
//                             4,
//                                 (index) => Container(
//                               margin: EdgeInsets.symmetric(horizontal: 12.w),
//                               width: 15.w,
//                               height: 15.h,
//                               decoration: BoxDecoration(
//                                 color: index < pinCode.length
//                                     ? Colors.green
//                                     : Colors.grey,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       80.getH(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           buttonItems(title: "1"),
//                           buttonItems(title: "2"),
//                           buttonItems(title: "3"),
//                         ],
//                       ),
//                       15.getH(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           buttonItems(title: "4"),
//                           buttonItems(title: "5"),
//                           buttonItems(title: "6"),
//                         ],
//                       ),
//                       15.getH(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           buttonItems(title: "7"),
//                           buttonItems(title: "8"),
//                           buttonItems(title: "9"),
//                         ],
//                       ),
//                       15.getH(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           TextButton(
//                             style: TextButton.styleFrom(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 42.w,
//                                 vertical: 27.h,
//                               ),
//                               backgroundColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                             ),
//                             onPressed: () {},
//                             child: Text(
//                               "",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24.w,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           buttonItems(title: "0"),
//                           TextButton(
//                             style: TextButton.styleFrom(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 22.w,
//                                 vertical: 22.h,
//                               ),
//                               backgroundColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (pinCode.isEmpty) {
//                                 pinCode = "";
//                               } else {
//                                 pinCode =
//                                     pinCode.substring(0, pinCode.length - 1);
//                               }
//                               setState(() {});
//                             },
//                             child: const Icon(
//                               Icons.backspace,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       Center(
//                         child: Text(
//                           "Forgot password?",
//                           style: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 16.w,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       50.getH(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }