import 'package:exson_bank/utils/size/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/user_card_bloc/user_card_bloc.dart';
import '../../../../bloc/user_card_bloc/user_card_event.dart';
import '../../../../bloc/user_card_bloc/user_card_state.dart';
import '../../../../data/model/card_model.dart';
import '../../../../data/model/forma_stats.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../auth_screens/widget/my_custom_buttom/my_custom_button.dart';
import '../../../auth_screens/widget/universal_text_input.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumber = TextEditingController();

  final TextEditingController expireDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Card"),
      ),
      body: BlocConsumer<UserCardsBloc, UserCardsState>(
        listener: (context, state) {
          if (state.statusMessage == "added") {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                UniversalTextField(
                  controller: cardNumber,
                  iconPath: '',
                  hintText: 'Card number',
                  type: TextInputType.number,
                  regExp: AppConstants.number,
                  errorText: "card number",
                ),

                SizedBox(
                  height: 20.h,
                ),
                UniversalTextField(
                  controller: expireDate,
                  iconPath: '',
                  hintText: "Expire Date",
                  type: TextInputType.text,
                  regExp: AppConstants.number,
                  errorText: "Expire Date",
                ),

                SizedBox(
                  height: 20.h,
                ),
                MyCustomButton(
                  onTap: () {
                    List<CardModel> db = state.userCardsDB;
                    List<CardModel> myCards = state.userCards;
                    bool isExist = false;

                    for (var element in myCards) {
                      if (element.cardNumber == cardNumber.text) {
                        isExist = true;
                        break;
                      }
                    }

                    CardModel? cardModel;

                    bool hasInDb = false;

                    for (var element in db) {
                      if (element.cardNumber == cardNumber.text) {
                        hasInDb = true;
                        cardModel = element;
                        break;
                      }
                    }

                    if (!isExist && hasInDb) {
                      context
                          .read<UserCardsBloc>()
                          .add(AddCardEvent(cardModel: cardModel!));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Karta oldin qo'shilgan yoki bazada mavjud emas")));
                    }
                  },
                  title: "Add Card",
                  isLoading: state.formStatus == FormStatus.loading,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
