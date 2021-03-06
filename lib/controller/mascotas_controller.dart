

import 'package:prueba_api_rest/Mascotas/Model/mascota_model.dart';
import 'package:prueba_api_rest/Mascotas/Repository/mascota_repository.dart';

class MascotaController{
  final MascotaRepository _repository;

  MascotaController(this._repository);

  Future<List<MascotaModel>> fetchListMascota() async {
    return _repository.getMascotaModelList();
  }
  Future<String> deleteMascota(MascotaModel mascota) async {
    return _repository.deleteMascotaModelList(mascota);
  }
  Future<List<MascotaModel>> addMascota(MascotaModel mascota) async {
    return _repository.addMascota(mascota);
  }
  Future<String> editMascota(MascotaModel mascota) async {
    return _repository.editMascota(mascota);
  }
}