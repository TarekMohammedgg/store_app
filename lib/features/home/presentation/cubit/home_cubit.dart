import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/data/repo/home_repo.dart';
import 'package:store_app/features/home/presentation/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  Future<void> getAllProducts() async {
    try {
      emit(HomeLoading());
      final products = await _homeRepo.getAllProducts();
      emit(HomeSuccess(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
