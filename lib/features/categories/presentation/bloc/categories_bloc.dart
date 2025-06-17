import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/categories/domain/entities/category_entity.dart';
import 'package:pennywise/features/categories/domain/usecases/categories_get_all_usecase.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesEvent>((CategoriesEvent event, Emitter<CategoriesState> emit) => emit(CategoriesLoadingState()));
    on<CategoriesGetAllEvent>(_onCategoriesGetAll);
  }

  FutureOr<void> _onCategoriesGetAll(CategoriesGetAllEvent event, Emitter<CategoriesState> emit) async {
    final Either<Failure, List<CategoryEntity>> result = await sl<CategoriesGetAllUseCase>().call((event.page, event.pageSize));
    result.fold(
      (Failure failure) => emit(CategoriesFailureState(failure: failure)),
      (List<CategoryEntity> entities) => emit(CategoriesGetAllSuccessState(entities: entities)),
    );
  }
}
