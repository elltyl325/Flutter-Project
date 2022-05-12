import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

// If you're using LOCALHOST for the node server and Android emulator, ONLY CHANGE PORT #.
// Android emulator uses the 10.0.2.2 address to connect to your computer's localhost.
// IOS Emulator/Physical and Android Physical will be different.
@RestApi(baseUrl: "http://localhost:3000/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/getAll")
  Future<List<String>> getAll();

  @POST("/getData")
  Future<List<Collection>> getData(@Body() Map<String, String> collectionName);

  @POST("/insertData")
  Future<String> insertData(@Body() Map<String, dynamic> object);

  @POST("/getDocument")
  Future<String> getDocument(@Body() Map<String, dynamic> object);
}

@JsonSerializable()
class Collection {
  @JsonKey(name: '_id')
  String id;
  Map<String, dynamic> address;
  String borough;
  String cuisine;
  List<dynamic> grades;
  String name;
  String restaurant_id;

  Collection({required this.id, required this.address, required this.borough, required this.cuisine, required this.grades, required this.name, required this.restaurant_id});
  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}