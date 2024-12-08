import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/entity/house_entity.dart';
import '../../../core/usecases/houses_usecase.dart';
part 'houses_state.dart';

class HousesCubit extends Cubit<HousesState> {
  final GetHousesUsecase housesUsecase;
  HousesCubit(this.housesUsecase) : super(HousesInitial());
  static List<HouseEntity> houses = [];
  int page = 1;

  load({
    required String locale,
    String search = "",
    int? sellingType,
    int? houseType,
    int? square,
    int? rooms,
    int? bathroom,
    int? fromYear,
    int? toYear,
    int? maxPrice,
    int? minPrice,
    double? north,
    double? west,
    double? south,
    double? east,
  }) async {
    page = 1;
    houses.clear();
    emit(HousesLoading());


   print("Location north $north ");
   print("Location west $west ");
   print("Location south $south ");
   print("Location east $east ");
    final response = await housesUsecase.call(
      GetHousesUsecaseParams(
        locale: locale,
        page: page,
        search: search,
        houseType: sellingType,
        category: houseType,
        square: square,
        rooms: rooms,
        bathroom: bathroom,
        fromYear: fromYear,
        toYear: toYear,
        maxPrice: maxPrice,
        minPrice: minPrice,
        west: west,
        north: north,
        east: east,
        south: south,
      ),
    );
    response.fold((l) => HousesError(l.errorMessage), (r) {
      houses = r.houses;
      emit(HousesLoaded(houses));
    });
  }

  loadMore({required String locale}) async {
    page++;
    print("Page $page");
    final response = await housesUsecase.call(
      GetHousesUsecaseParams(page: page, search: '', locale: locale),
    );

    response.fold(
      (l) => emit(HousesError(l.errorMessage)),
      (r) {
        houses += r.houses;
        print("More houses ${houses.length}");

        emit(HousesLoaded(houses));
      },
    );
  }
}
