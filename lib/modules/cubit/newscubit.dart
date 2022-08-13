import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/home.dart';
import 'package:untitled2/modules/archive.dart';
import 'package:untitled2/modules/cubit/states.dart';
import '../../shared/network/end_point.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List screen = [
    News(),
    Archived(),
  ];
  List title = [
    "News",
    "Archived",
  ];
  var currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavi());
  }

  List<String> categorys = [
    "general",
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List newsArticle = [];
  List<String> countries = [
    "ae",
    "eg",
    "ar",
    "at",
    "au",
    "be",
    "bg",
    "br",
    "ca",
    "ch",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "in",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "si",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za",
  ];
  var currentCategory = 'general';
  void changeCategory(value) {
    currentCategory = value;
    emit(changeCAtegoryState());
  }

  var currentCountry = 'ae';
  void changeCountry(value) {
    currentCountry = value;
    emit(changeCountryyState());
  }

  void getNews() {
    emit(LoadingNewsState());
    DioHelper.getdata(url: 'v2/top-headlines', qure: {
      'country': currentCountry,
      'category': currentCategory,
      'apikey': APIKEY,
    }).then((value) {
      newsArticle = value.data['articles'];
      print(newsArticle);
      emit(SuccessNewsState());
    }).catchError((error) {
      print(error);
      emit(ErrorNewsState(error));
    });
  }

  void getSearch(String value) {
    emit(SearchLoadingState());
    DioHelper.getdata(url: 'v2/everything', qure: {
      'q': '$value',
      'apikey': 'c6e3d9993cb24aaebbb9d3c07aa4e4ae',
    }).then((value) {
      newsArticle = value.data['articles'];
      print(newsArticle[0]);
      emit(SearchGet());
    }).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }

  List archiveNews = [];
  Future getDataFB() async {
    archiveNews = [];
    CollectionReference archiveRef =
        FirebaseFirestore.instance.collection('archived');
    await archiveRef
        .get()
        .then((value) => value.docs.forEach((element) {
              archiveNews.add(element);
            }))
        .catchError((error) {
      print(error);
      emit(ErrorfirebaseState(error.toString()));
    });
  }

  addDataFB(item) {
    emit(LoadingfirebaseState());
    CollectionReference archiveRef =
        FirebaseFirestore.instance.collection('archived');
    archiveRef.doc("${item['title']}").set({
      'source': {
        'id': item['source']['id'],
        'name': item['source']['name'],
      },
      'author': item['author'],
      'title': item['title'],
      'description': item['description'],
      'url': item['url'],
      'urlToImage': item['urlToImage'],
      'publishedAt': item['publishedAt'],
    }).then((value) {
      archiveNews.add(item);
      emit(SuccesspushfirebaseState());
    }).catchError((error) {
      print(error);
      emit(ErrorfirebaseState(error.toString()));
    });
  }

  delete(item) {
    emit(LoadingfirebaseState());
    CollectionReference archiveRef =
        FirebaseFirestore.instance.collection('archived');
    archiveRef.doc("${item['title']}").delete().then((value) {
      archiveNews.remove(item);
      print("deleted");
      emit(SuccessdeletefirebaseState());
    }).catchError((error) {
      print("error");
      print(error.toString());
      emit(ErrorfirebaseState(error));
    });
  }

  Color colordrop = Colors.black;
  void onopen() {
    colordrop = Colors.white;
  }

  void onclose() {
    colordrop = Colors.black;
  }
}
