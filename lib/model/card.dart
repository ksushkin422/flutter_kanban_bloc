class CardK {
  final int id;
  final int row;
  final int seq_num;
  final String text;

  CardK(this.id, this.row, this.seq_num, this.text);

  CardK.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      row = int.parse(json['row']),
      seq_num = json['seq_num'],
      text = json['text'];

}