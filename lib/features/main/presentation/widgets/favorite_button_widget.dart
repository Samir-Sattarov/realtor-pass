import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../auth/presentation/cubit/session/session_cubit.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../cubit/favorite/favorite_cubit.dart';

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
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Инициализация состояния избранного
    final favoriteCubit = BlocProvider.of<FavoriteHousesCubit>(context);
    isFavorite = favoriteCubit.isFavorite(widget.entity.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (BlocProvider.of<SessionCubit>(context).state is SessionDisabled) {
          // Если пользователь не авторизован, перенаправляем на экран входа
          AnimatedNavigation.push(context: context, page: const SignInScreen());
        } else {
          setState(() => isFavorite = !isFavorite);
          if (isFavorite) {
            // Добавление в избранное
            BlocProvider.of<FavoriteHousesCubit>(context)
                .addFavorite(widget.entity);
          } else {
            // Удаление из избранного
            BlocProvider.of<FavoriteHousesCubit>(context)
                .removeFavorite(widget.entity.id);
          }
        }
      },
      child: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        color: isFavorite ? Colors.red : Colors.grey.shade700,
        size: 30.0,
      ),
    );
  }
}
