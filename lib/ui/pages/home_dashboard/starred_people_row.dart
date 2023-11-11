import 'package:flutter/material.dart';

import '../../../model/user_model_supabase.dart';
import '../../widget/colab_catched_image_widget.dart';

class StarredPeopleRow extends StatefulWidget {
  final UserModelSupabase starredPeople;

  const StarredPeopleRow({super.key, required this.starredPeople});

  @override
  State<StarredPeopleRow> createState() => _StarredPeopleRowState();
}

class _StarredPeopleRowState extends State<StarredPeopleRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          color: Colors.black,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: ColabCatchedImageWidget(
                imageUrl: widget.starredPeople.profilePictureUrl,
                height: 54,
                width: 54,
              )),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
