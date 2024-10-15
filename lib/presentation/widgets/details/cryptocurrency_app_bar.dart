import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_state.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/icon_action_button_widget.dart';

class CryptocurrencyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final CryptocurrencyUiModel cryptocurrency;

  const CryptocurrencyAppBar({
    super.key,
    required this.cryptocurrency,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(cryptocurrency.name),
      actions: [
        BlocBuilder<ManageFavoriteBloc, ManageFavoriteState>(
          builder: (context, state) {
            print("ManageFavoriteBloc state : $state");
            if (state is LoadedFavoriteStatus) {
              final isFavorite = state.isFavorite;
              return IconButtonAction(
                iconData: isFavorite ? Icons.favorite : Icons.favorite_border,
                tintColor: isFavorite ? Colors.red : Colors.black,
                onAction: () {
                  try {
                    final favoriteBloc =
                        BlocProvider.of<ManageFavoriteBloc>(context);
                    if (isFavorite) {
                      favoriteBloc.add(RemoveFavoriteEvent(cryptocurrency));
                    } else {
                      favoriteBloc.add(AddFavoriteEvent(cryptocurrency));
                    }
                  } catch (error) {
                    print("Error while updating favorite: $error");
                  }
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
