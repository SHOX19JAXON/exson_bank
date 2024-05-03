import 'package:exson_bank/data/model/user_model.dart';
import 'package:exson_bank/screen/auth_screens/widget/my_custom_buttom/my_custom_button.dart';
import 'package:exson_bank/screen/auth_screens/widget/password_text_input.dart';
import 'package:exson_bank/screen/auth_screens/widget/simple_global_button.dart';
import 'package:exson_bank/screen/auth_screens/widget/snacbar.dart';
import 'package:exson_bank/screen/auth_screens/widget/universal_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../data/model/forma_stats.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/size.dart';
import '../../utils/styles/app_text_style.dart';
import '../tab/tab_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  // final ChatServices chatServices = ChatServices();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  UserModel userModel = UserModel.initial();
  bool passwordVisibility = false;

  bool isValidLoginCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
      AppConstants.textRegExp.hasMatch(emailController.text) &&
      AppConstants.phoneRegExp.hasMatch(phoneController.text) &&
      AppConstants.textRegExp.hasMatch(lastNameController.text);

  // AppConstants.passwordRegExp.hasMatch(confirmPasswordController.text)
  bool isValidLoginCredentionls() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
      AppConstants.textRegExp.hasMatch(emailController.text);

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final picker = ImagePicker();
  String storagePath = "";

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 50.h),
                            child: Image.asset(AppImages.exson_bank),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          const Text(
                              textAlign: TextAlign.center,
                              "Create your account!",
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColors.c_2C2C73,
                              )),
                          SizedBox(height: 24.h),
                          UniversalTextField(
                            labelText: "Your name",
                            errorText: "Ismni to'g'ri  kiriting!",
                            regExp: AppConstants.textRegExp,
                            controller: usernameController,
                            iconPath: AppImages.person35,
                            hintText: "Your Name",
                            type: TextInputType.text,
                          ),
                          SizedBox(height: 8.h),
                          UniversalTextField(
                            errorText: "Emailni to'g'ri  kiriting!",
                            regExp: AppConstants.emailRegExp,
                            controller: emailController,
                            iconPath: AppImages.sms,
                            hintText: "Email",
                            type: TextInputType.emailAddress,
                          ),
                          PasswordTextField(
                            controller: passwordController,
                            iconPath: AppImages.log,
                            isVisible: passwordVisibility,
                            suffix: IconButton(
                              onPressed: () {
                                passwordVisibility = !passwordVisibility;
                                setState(() {});
                              },
                              icon: Icon(
                                passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              splashRadius: 20,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          // SimpleGlobalButton(
                          //   // onTap: () {
                          //   //   // if (emailController.text
                          //   //   //     .contains('@gmail.com')) {
                          //   //   //   context.read<AuthBloc>().add(
                          //   //   //         AuthRegisterEvent(
                          //   //   //           name: usernameController.text,
                          //   //   //           email: emailController.text,
                          //   //   //           password: passwordController.text,
                          //   //   //         ),
                          //   //   //       );
                          //   //   // }
                          //   //
                          //   //
                          //   //   // if (usernameController.text.isEmpty &&
                          //   //   //     emailController.text.isEmpty &&
                          //   //   //     passwordController.text.isEmpty) {
                          //   //   //   showCustomSnackbar(
                          //   //   //       context, 'Malumotlarni toildir');
                          //   //   // } else if (emailController.text
                          //   //   //     .contains('@gmail.com')) {
                          //   //   //   context.read<AuthBloc>().add(
                          //   //   //         AuthRegisterEvent(
                          //   //   //           name: usernameController.text,
                          //   //   //           email: emailController.text,
                          //   //   //           password: passwordController.text,
                          //   //   //         ),
                          //   //   //       );
                          //   //   // } else {
                          //   //   //   showCustomSnackbar(context, 'Email is error');
                          //   //   // }
                          //   // },
                          //   onTap: () {
                          //     context.read<AuthBloc>().add(
                          //           RegisterUserEvent(
                          //             userModel: UserModel(
                          //               password: passwordController.text,
                          //               email:
                          //                   "${emailController.text}@gmail.com"
                          //                       .trim(),
                          //               imageUrl: "",
                          //               phoneNumber: phoneController.text,
                          //               userId: "",
                          //               userName: emailController.text,
                          //               lastName: lastNameController.text,
                          //             ),
                          //           ),
                          //         );
                          //   },
                          //   title: "REGISTER",
                          //   horizontalPadding: 0,
                          //   verticalPadding: 0,
                          // ),
                          MyCustomButton(
                            onTap: () {
                              // context.read<AuthBloc>().add(
                              //       RegisterUserEvent(
                              //         userModel: UserModel(
                              //             password: passwordController.text,
                              //             email:
                              //                 "${emailController.text}@gmail.com"
                              //                     .trim(),
                              //             imageUrl: "",
                              //             phoneNumber: phoneController.text,
                              //             userId: "",
                              //             userName: emailController.text,
                              //             lastName: lastNameController.text,
                              //             fcm: '',
                              //             authUid: ''),
                              //       ),
                              //     );
                              context.read<AuthBloc>().add(
                                RegisterUserEvent(
                                  userModel: UserModel(
                                    imageUrl: "",
                                    email:
                                    "${firstNameController.text.toLowerCase()}@gmail.com",
                                    lastName: lastNameController.text,
                                    password: passwordController.text,
                                    phoneNumber: phoneController.text,
                                    userId: "",
                                    userName: firstNameController.text,
                                    fcm: "",
                                    authUid: "", 
                                  ),
                                ),
                              );
                            },
                            readyToSubmit: isValidLoginCredentionls(),
                            isLoading: state.formStatus == FormStatus.loading,
                            title: 'REGISTER',
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(SignInWithGoogleEvent(userModel: UserModel.initial()));
                                },
                                icon: SvgPicture.asset(AppImages.google),
                              ),
                              const Text("Register with Google"),
                              const Spacer()

                              // const Spacer(),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: SvgPicture.asset(AppImages.fasebook),
                              // ),
                              // const Spacer(),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: SvgPicture.asset(AppImages.iphone),
                              // ),
                              // const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                          color: AppColors.c_29BB89.withOpacity(0.45),
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          "Already have an account? Login",
                          style: AppTextStyle.rubikSemiBold.copyWith(
                              fontSize: 14, color: AppColors.c_2C2C73),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state.formStatus == FormStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TabScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}

List<String> kod = ["@gmail.com", "@gmail.ru"];

String a = "@gmail.com";

//creat images

//
//   Future<void> _getImageFromCamera() async {
//     XFile? image = await picker.pickImage(
//       source: ImageSource.camera,
//       maxHeight: 1024,
//       maxWidth: 1024,
//     );
//     if (image != null && context.mounted) {
//       debugPrint("IMAGE PATH:${image.path}");
//       storagePath = "files/images/${image.name}";
//       imageUrl = await
//
//       // context.read<ImageViewModel>().uploadImage(
//       //       pickedFile: image,
//       //       storagePath: storagePath,
//       //     );
//
//       chatServices.uploadImage(pickedFile: image, storagePath: storagePath);
//
//       debugPrint("DOWNLOAD URL:$imageUrl");
//     }
//   }
//
//   Future<void> _getImageFromGallery() async {
//     XFile? image = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxHeight: 1024,
//       maxWidth: 1024,
//     );
//     if (image != null && context.mounted) {
//       debugPrint("IMAGE PATH:${image.path}");
//       storagePath = "files/images/${image.name}";
//       imageUrl = await
//
//       // await context.read<ImageViewModel>().uploadImage(
//       //       pickedFile: image,
//       //       storagePath: storagePath,
//       //     );
//       chatServices.uploadImage(pickedFile: image, storagePath: storagePath);
//
//       debugPrint("DOWNLOAD URL:$imageUrl");
//     }
//   }
//
//   takeAnImage() {
//     showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         )),
//         context: context,
//         builder: (context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 12.h),
//               ListTile(
//                 onTap: () async {
//                   _getImageFromGallery();
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.photo_album_outlined),
//                 title: const Text("Gallereyadan olish"),
//               ),
//               ListTile(
//                 onTap: () async {
//                   _getImageFromCamera();
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text("Kameradan olish"),
//               ),
//               SizedBox(height: 24.h),
//             ],
//           );
//         });
//   }
//
//   _showSnackBar({String title = "Empty input"}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 1),
//         content: Text(
//           title,
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
//         ),
//       ),
//     );
//   }
// }
