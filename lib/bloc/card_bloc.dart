import 'package:kanban/api/api_client.dart';
import 'package:kanban/model/card_response.dart';
import 'package:rxdart/rxdart.dart';
// @dart=2.9
class CardBloc {
  final ApiClient cardData = ApiClient();
  final BehaviorSubject<CardResponse> _cards = BehaviorSubject<CardResponse>();
  // late final int num_row;

  getCards() async {
    var response = await cardData.apiCardsGet();
    _cards.sink.add(response);
  }

  dispose() {
    _cards.close();
  }

  BehaviorSubject<CardResponse> get cards => _cards;

}

final bloc = CardBloc();