class AssignmentResponse {
  int? id;
  int? deliverPerson;
  int? receiverPerson;
  int? instrument;
  int? pieces;
  String? picture;
  String? date;
  String? deliverPersonName;
  String? receiverPersonName;

  AssignmentResponse(
      {this.id,
        this.deliverPerson,
        this.receiverPerson,
        this.instrument,
        this.pieces,
        this.picture,
        this.date,
        this.deliverPersonName,
        this.receiverPersonName});

  AssignmentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliverPerson = json['deliver_person'];
    receiverPerson = json['receiver_person'];
    instrument = json['instrument'];
    pieces = json['pieces'];
    picture = json['picture'];
    date = json['date'];
    deliverPersonName = json['deliver_person_name'];
    receiverPersonName = json['receiver_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deliver_person'] = deliverPerson;
    data['receiver_person'] = receiverPerson;
    data['instrument'] = instrument;
    data['pieces'] = pieces;
    data['picture'] = picture;
    data['date'] = date;
    data['deliver_person_name'] = deliverPersonName;
    data['receiver_person_name'] = receiverPersonName;
    return data;
  }
}