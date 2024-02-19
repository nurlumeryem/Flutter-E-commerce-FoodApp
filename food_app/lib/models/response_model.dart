class ResponseModel{
  late bool _isSucces;
  late String _message;
  ResponseModel(this._isSucces, this._message);
  String get message => _message;
  bool get isSuccess => _isSucces;
   ResponseModel.fromJson(Map json){
    _isSucces=json["success"];
    _message=json["message"];
  }
}