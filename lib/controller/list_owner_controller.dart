import '../Duenno/repository.dart';
import '../Duenno/owner_model.dart';

class ListOwnerController{
  final Repository _repository;

  ListOwnerController(this._repository);

  Future<List<ListOwner>> fetchListOwner() async {
    return _repository.getListOwnerList();
  }

  Future<String> deleteListOwner(ListOwner owner) async {
    return _repository.deleteListOwnerList(owner);
  }
}