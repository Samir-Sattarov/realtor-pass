import 'package:dartz/dartz.dart';

import '../../features/main/core/entity/chip_entity.dart';
import '../../features/main/core/entity/house_entity.dart';
import '../../features/main/core/entity/porters_entity.dart';
import '../../features/main/core/entity/questions_entity.dart';

class TestDates {
  static const PostersEntity posters = PostersEntity(images: [
    "https://th.wallhaven.cc/small/l8/l8vp7y.jpg",
    "https://th.wallhaven.cc/small/72/72yzje.jpg",
    "https://th.wallhaven.cc/small/85/856dlk.jpg",
  ]);

  static const List<ChipEntity> carCategory = [
    ChipEntity(id: 0, title: "Внедорожник"),
    ChipEntity(id: 1, title: "Кабриолеты"),
    ChipEntity(id: 2, title: "Хэтчбэки"),
    ChipEntity(id: 3, title: "Внедорожник"),
    ChipEntity(id: 4, title: "Внедорожник"),
    ChipEntity(id: 5, title: "Внедорожник"),
  ];

  static const List<ChipEntity> sorting = [
    ChipEntity(id: 1, title: "beginChip"),
    ChipEntity(id: 2, title: "beginExpensive"),
    ChipEntity(id: 3, title: "tigr"),
    ChipEntity(id: 4, title: "tigr"),
    ChipEntity(id: 5, title: "beginExpensive"),

  ];
  static List<HouseEntity> houses = [
    HouseEntity(
      id: 1,
      houseType: "Квартира",
      category: "Hetchback",
      description: "Chevrolet Aveo - это бюджетный легковой автомобиль В-класса, который выпускается с 2002 года. Он представлен в трех вариантах кузова: седан, хэтчбек 3-дверный и хэтчбек 5-дверный. ",
      isFavorite: false,
      images: const <String>[

        "https://i.pinimg.com/564x/3e/9d/ea/3e9dea20adf1857eb98cb04e5be43db3.jpg",
        "https://i.pinimg.com/474x/5f/61/c4/5f61c42c564b8d32ec2831269d133962.jpg",
        "https://i.pinimg.com/474x/bf/e8/cb/bfe8cbf910ae9a09c3925911a8f934d0.jpg",
        "https://i.pinimg.com/474x/7d/dc/7d/7ddc7de86c811cc8dc8531304db14da6.jpg",
        "https://i.pinimg.com/474x/d0/03/60/d00360827ba994c2325d653847a388c0.jpg",
        "https://i.pinimg.com/474x/37/bc/e1/37bce12b431ab839ba9577c76934c12f.jpg",
      ],
      houseTitle: 'Квартира в центре города',
      houseLocation: 'location',
      categoryId: 0,
      lon: 2,
      lat: 2,
      square: 140,
      bathroom: 2,
      rooms: 5,
      price: 200,
    ),
    HouseEntity(
      id: 1,
      houseType: "M5 Competition",
      category: "Hetchback",
      description: "The best car ever see!",
      images: const <String>[
        "https://i.pinimg.com/474x/dc/c1/f9/dcc1f95f35dedd78a9652fdddb0fe4c5.jpg",
        "https://i.pinimg.com/474x/53/e8/23/53e82395d1839367630e2168ba73a906.jpg",
        "https://i.pinimg.com/474x/dc/ed/da/dceddaf58a7eae51903ba513be5e037f.jpg",
        "https://i.pinimg.com/474x/02/79/9f/02799f3d3440306b58b70219dcc5cf05.jpg",
        "https://i.pinimg.com/474x/f5/7f/9d/f57f9d3b3f7935074387f189a9e744b6.jpg",
        "https://i.pinimg.com/564x/d4/f4/4b/d4f44b8ccf31e8343adebca4183c4865.jpg",
      ],
      houseTitle: 'title',
      houseLocation: 'location',
      categoryId: 0,
      lon: 0,
      lat: 0,
      square: 0,
      bathroom: 0,
      rooms: 0,
      price: 0,
      isFavorite: false,
    ),
  ];
  static const List<QuestionsEntity> questions = [
    QuestionsEntity(
        name: "Кому принадлежат арендуемые машины",
        description:
            "Все машины первое время абсолютно новые c салона, а также есть автомобили которые предлагают, некоторые пользователи"),
    QuestionsEntity(
        name: "Кому принадлежат арендуемые машины",
        description:
            "Все машины первое время абсолютно новые c салона, а также есть автомобили которые предлагают, некоторые пользователи"),
    QuestionsEntity(
        name: "Кому принадлежат арендуемые машины",
        description:
            "Все машины первое время абсолютно новые c салона, а также есть автомобили которые предлагают, некоторые пользователи"),
    QuestionsEntity(
        name: "Кому принадлежат арендуемые машины",
        description:
            "Все машины первое время абсолютно новые c салона, а также есть автомобили которые предлагают, некоторые пользователи"),
  ];
}
