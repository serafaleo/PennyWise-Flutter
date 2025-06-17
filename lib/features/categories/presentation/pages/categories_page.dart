import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pennywise/core/widgets/drawer.dart';
import 'package:pennywise/core/widgets/loader_indicator.dart';
import 'package:pennywise/features/categories/domain/entities/category_entity.dart';
import 'package:pennywise/features/categories/presentation/bloc/categories_bloc.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<CategoryEntity> _categories = <CategoryEntity>[];
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 10;

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    _callGetAllEvent();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final bool isBottom = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
        if (isBottom && !_isLoading && _hasMore) {
          _callGetAllEvent();
        }
      }
    });
    super.initState();
  }

  void _callGetAllEvent() {
    context.read<CategoriesBloc>().add(CategoriesGetAllEvent(page: _page, pageSize: _pageSize));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias'), centerTitle: true),
      drawer: const PennyWiseDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: (BuildContext context, CategoriesState state) {
          if (state is CategoriesGetAllSuccessState) {
            setState(() {
              _categories.addAll(state.entities);
              _isLoading = false;
              _hasMore = state.entities.length == _pageSize;
              if (_hasMore) _page++;
            });
          } else if (state is CategoriesLoadingState) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is CategoriesFailureState) {
            state.failure.show(context);
          }
        },
        builder: (BuildContext context, CategoriesState state) {
          if (_page == 1 && _isLoading) {
            return const LoaderIndicator();
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: _categories.length,
            itemBuilder: (BuildContext context, int index) {
              final CategoryEntity category = _categories[index];
              if (index < _categories.length) {
                return _buildItem(category);
              } else {
                return const LoaderIndicator();
              }
            },
          );
        },
      ),
    );
  }

  Padding _buildItem(CategoryEntity category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(category.name),
        subtitle: Text(category.description ?? ''),
      ),
    );
  }
}
