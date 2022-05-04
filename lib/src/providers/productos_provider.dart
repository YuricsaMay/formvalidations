import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:formvalidations/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductosProvider {
  final String _url =
      'https://flutter-varios-8efa4-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';
    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';
    final resp =
        await http.put(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    print(url);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = [];

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    print(productos);
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(Uri.parse(url));
    print(json.decode(resp.body));
    return 1;
  }
 
Future<String?> subirImagen(File imagen) async {
  final url = Uri.parse(
     'https://api.cloudinary.com/v1_1/du6xzgrti/image/upload?upload_preset=r59ycwhk');
  final mimeType = mime(imagen.path)!.split('/'); //image/jpeg

  final imageUploadRequest = http.MultipartRequest('POST', url);

  final file = await http.MultipartFile.fromPath('file', imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]));
  imageUploadRequest.files.add(file);

  final streamResponse = await imageUploadRequest.send();
  final resp = await http.Response.fromStream(streamResponse);

  if(resp.statusCode !=200 && resp.statusCode != 201){
  print("Algo salió mal");
  print(resp.body);
  return null;
  }

  //Extraer el secure url
  final respData=json.decode(resp.body);
  print(respData);
  return respData["secure_url"];
}



}
