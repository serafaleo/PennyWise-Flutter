import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pennywise/core/constants/routes.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/presentation/bloc/auth_bloc.dart';

class PennyWiseDrawer extends StatelessWidget {
  const PennyWiseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Olá, ${sl<AuthManager>().userName}!',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
                BlocProvider<AuthBloc>(
                  create: (_) => AuthBloc(),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (BuildContext context, Object? state) {
                      if (state is AuthFailureState) {
                        Navigator.of(context).pop();
                        state.failure.show(context);
                      } else if (state is LogoutSuccessState) {
                        context.go(Routes.login);
                      }
                    },
                    builder: (BuildContext context, Object? state) {
                      return IconButton(
                        onPressed: () async {
                          if ((await _showLogoutDialog(context) ?? false) && context.mounted) {
                            context.read<AuthBloc>().add(AuthLogoutEvent());
                          }
                        },
                        icon: state is AuthLoadingState
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Icon(Icons.logout, color: Theme.of(context).colorScheme.onPrimary),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {
            context.go(Routes.home);
          }),
          _buildDrawerItem(Icons.category, 'Categorias', () {
            context.go(Routes.categories);
          }),
          _buildDrawerItem(Icons.receipt_long, 'Transações', () {
            context.go(Routes.transactions);
          }),
          _buildDrawerItem(Icons.settings, 'Configurações', () {
            context.go(Routes.settings);
          }),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String text, void Function()? onTap) {
    return ListTile(
      title: Row(children: <Widget>[Icon(icon), const SizedBox(width: 10), Text(text)]),
      onTap: onTap,
    );
  }

  Future<bool?> _showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair'),
          content: const Text('Deseja sair da sessão atual?'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sim')),
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Não')),
          ],
        );
      },
    );
  }
}
