import 'package:exson_bank/bloc/user_card_bloc/user_card_state.dart';
import 'package:exson_bank/data/model/card_model.dart';
import 'package:exson_bank/utils/images/app_images.dart';
import 'package:exson_bank/utils/size/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_card_bloc/user_card_bloc.dart';


import '../../../bloc/user_card_bloc/user_card_event.dart';
import '../../../bloc/user_profile/user_profile_bloc.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../routs.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    context.read<UserCardsBloc>().add(GetCardsByUserIdEvent(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cards"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addCardScreen);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return ListView(
            children: List.generate(state.userCards.length, (index) {
              print(state.userCards.length);
              CardModel cardModel = state.userCards[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(int.parse("0xFF${cardModel.color}"))),
                child: Stack(
                  children: [
                    Positioned(
                      top: 50.h,
                      left: 50.w,
                      child: Image.asset(
                        AppImages.chip,
                        width: 70.w,
                        height: 40.h,
                      ),
                    ),
                    Positioned(
                      top: 50.h,
                      left: 200.w,
                      child: Image.asset(
                        AppImages.ipak_yoli,
                        width: 100.w,
                        height: 50.h,
                      ),
                    ),
                    Positioned(
                      left: 200.w,
                      child: Text(
                        cardModel.bank,
                        style: AppTextStyle.interBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: 30.w,
                      top: 100.h,
                      child: Text(
                        cardModel.cardNumber,
                        style: const TextStyle(
                          fontSize:  30,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Positioned(
                      left: 150.w,
                      top: 135.h,
                      child: Text(
                        cardModel.expireDate,
                        style: AppTextStyle.interBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: 30.w,
                      top: 155.h,
                      child: Text(
                        cardModel.cardHolder,
                        style: AppTextStyle.interBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
