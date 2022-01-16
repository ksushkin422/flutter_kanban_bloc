

import 'card.dart';

class CardResponse {
  final List<CardK> results;
  final String error;

  CardResponse(this.results, this.error);

  CardResponse.fromJson(List<dynamic> json):
        results = (json).map((e) => new CardK.fromJson(e)).toList(),
        error = "";

  CardResponse.withError(String errorValue):
      results = <CardK>[],
      error = errorValue;

}