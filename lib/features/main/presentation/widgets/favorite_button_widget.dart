import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../auth/presentation/cubit/session/session_cubit.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final HouseEntity entity;

  const FavoriteButtonWidget({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    // BlocProvider.of<FavoriteCarsJsonCubit>(context).load();
    // BlocProvider.of<FavoriteCarsJsonCubit>(context).stream.listen((state) {
    //   if (state is FavoriteCarsJsonLoaded) {
    //     if (mounted) {
    //       Future.delayed(
    //         Duration.zero,
    //         () {
    //           isFavorite =
    //               state.entity.favoriteCarsId.containsKey(widget.entity.id);
    //
    //           setState(() {});
    //         },
    //       );
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (BlocProvider.of<SessionCubit>(context).state is SessionDisabled) {
          AnimatedNavigation.push(context: context, page: const SignInScreen());
        } else {
          // setState(() => isFavorite = !isFavorite);
          // if (isFavorite) {
          //   BlocProvider.of<FavoriteCarsCubit>(context).save(widget.entity.id);
          // } else {
          //   BlocProvider.of<FavoriteCarsCubit>(context)
          //       .remove(widget.entity.id);
          // }
        }
      },
      child: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_rounded,
        color: isFavorite ? Colors.red : Colors.grey.shade700,
      ),
    );
  }
}
