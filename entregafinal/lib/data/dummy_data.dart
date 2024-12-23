const dummyUsers = [
  {
    "id": 0,
    "name": "Admi Nistrator",
    "email": "admin@this.company.com",
    "role": "admin",
  },
  {
    "id": 1,
    "name": "Chofi Lopez",
    "email": "admin@this.company.com",
    "role": "driver",
  },
  {
    "id": 100,
    "name": "Amazon",
    "email": "our.contact@amazon.com",
    "role": "provider",
  },
  {
    "id": 1000,
    "name": "Emily Johnson",
    "email": "emily.johnson@x.dummyjson.com",
    "role": "customer",
    "address": {
      "street": "626 Main Street",
      "city": "Cincinnati",
      "state": "Ohio",
      "zipCode": "45202",
      "country": "United States",
      "lat": 39.10372864744755, 
	    "lng": -84.50986257300929,
    },
  },
  {
    "id": 1001,
    "name": "Michael Williams",
    "email": "michael.williams@x.dummyjson.com",
    "role": "customer",
    "address": {
      "street": "385 Fifth Street",
      "city": "Brooklyn",
      "state": "New York",
      "zipCode": "11215",
      "lat": 40.67101484314447,
      "lng": -73.98245122883488,
      "country": "United States",
    },
  },
];

List<Map<String, Object>> dummyShipments = [
  {
    "trackingNumber": 1000000001,
    "sender": dummyUsers[2],
    "recipient": dummyUsers[3],
    "driver": dummyUsers[1],
    "packageInfo": "Dimensiones: 20x20x10",
    "status": "En Reparto",
  },
  {
    "trackingNumber": 1000000001,
    "sender": dummyUsers[2],
    "recipient": dummyUsers[3],
    "driver": dummyUsers[1],
    "packageInfo": "Dimensiones: 10x10x10",
    "status": "En Reparto",
  },
  {
    "trackingNumber": 1000000002,
    "sender": dummyUsers[2],
    "recipient": dummyUsers[3],
    "driver": dummyUsers[1],
    "packageInfo": "Dimensiones: 20x20x10",
    "status": "En Reparto",
  },
  {
    "trackingNumber": 1000000003,
    "sender": dummyUsers[2],
    "recipient": dummyUsers[4],
    "driver": dummyUsers[1],
    "packageInfo": "Dimensiones: 10x20x10",
    "status": "En Reparto",
  },
  {
    "trackingNumber": 1000000004,
    "sender": dummyUsers[2],
    "recipient": dummyUsers[4],
    "driver": dummyUsers[1],
    "packageInfo": "Dimensiones: 20x20x20",
    "status": "En Reparto",
  },
];