// class ShipmentRepository {
//   final String baseUrl = 'http//localhost:3000/api';

//   late HHttpService httpService;

//   ShipmentRepository() : httpService = HttpService();

//   Future<Shipment> addShipment({required Shipment shipment}) async {
//     final respose = await httpService.request({
//       method: RequestMethod.post, url: '$baseUrl/t'
//     })
//   }
// }