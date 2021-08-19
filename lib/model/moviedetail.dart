import 'package:hive/hive.dart';

part 'moviedetail.g.dart';

@HiveType(typeId: 0)
class Moviedetail extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String director;
}
