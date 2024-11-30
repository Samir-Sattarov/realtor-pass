import '../datasources/house_dto.dart';
import '../entity/house_entity.dart';


class HouseMapper {
  static HouseEntity fromDTO(HouseDTO dto) {
    return HouseEntity(
      beds: dto.beds,
      guests: dto.guests,
      houseTitle: dto.houseTitle,
      id: dto.id,
      houseLocation: dto.houseLocation,
      isFavorite: dto.isFavorite,
      houseType: dto.houseType,
      category: dto.category,
      categoryId: dto.categoryId,
      description: dto.description,
      images: dto.images,
      lon: dto.lon,
      lat: dto.lat,
      price: dto.price,
      bedrooms: dto.bedrooms,
      bathrooms: dto.bathrooms,
      rooms: dto.rooms,
    );
  }

  static HouseDTO toDTO(HouseEntity entity) {
    return HouseDTO(
      beds: entity.beds,
      guests: entity.guests,
      houseTitle: entity.houseTitle,
      id: entity.id,
      houseLocation: entity.houseLocation,
      isFavorite: entity.isFavorite,
      houseType: entity.houseType,
      category: entity.category,
      categoryId: entity.categoryId,
      description: entity.description,
      images: entity.images,
      lon: entity.lon,
      lat: entity.lat,
      price: entity.price,
      bedrooms: entity.bedrooms,
      bathrooms: entity.bathrooms,
      rooms: entity.rooms,
    );
  }
}
