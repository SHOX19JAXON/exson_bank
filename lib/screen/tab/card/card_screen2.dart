import 'package:exson_bank/screen/tab/card/widgets/card_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/card_bloc/card2_bloc.dart';

import '../../../bloc/card_bloc/card2_event.dart';
import '../../../bloc/card_bloc/card2_state.dart';
import '../../../bloc/user_profile/user_profile_bloc.dart';
import '../../../data/model/card_model.dart';
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
    context.read<UserCardsBloc>().add(GetCardsByUserId(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cards",
          style: AppTextStyle.interSemiBold.copyWith(color: Colors.blue),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addCardRoute);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return ListView(
            children: List.generate(state.userCards.length, (index) {
              CardModel cardModel = state.userCards[index];
              return CardItemView(cardModel: cardModel);
            }),
          );
        },
      ),
    );
  }
}
