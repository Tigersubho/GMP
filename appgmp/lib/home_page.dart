import 'dart:math';

import 'package:appgmp/post_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appgmp/app_styles.dart';
import 'package:appgmp/size_config.dart';
import 'package:appgmp/product_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'dart:math' as math;

import 'filter.dart';
import 'filteredpropertiespage.dart';
import 'mongo.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  // ... existing code ...
  RxList<Map<String, dynamic>> filteredProperties = <Map<String, dynamic>>[].obs;

  // Dropdown options
  final List<String> minPriceOptions = ['5000', '10000', '20000','30000', '40000' , '50000' , '60000']; // Replace with your actual options
  final List<String> maxPriceOptions = ['20000', '30000', '40000', '50000', '60000', '80000']; // Replace with your actual options
  final List<String> locationOptions = ['North Kolkata', 'South Kolkata', 'Central Kolkata']; // Replace with your actual options
  final List<String> bedroomsOptions = ['1', '2', '3' , '4+']; // Replace with your actual options
  final List<String> bathroomsOptions = ['1', '2', '3' , '4+']; // Replace with your actual options
  final List<String> squareFeetOptions = ['5000', '10000', '20000','30000', '40000' , '50000' , '60000']; // Replace with your actual options

  // Selected values
  RxString selectedMinPrice = '5000'.obs;
  RxString selectedMaxPrice = '20000'.obs;
  RxString selectedLocation = 'North Kolkata'.obs;
  RxString selectedBedrooms = '1'.obs;
  RxString selectedBathrooms = '1'.obs;
  RxString selectedMinSquareFeet = '5000'.obs;
  RxString selectedMaxSquareFeet = '5000'.obs;

  // Amenities
  RxBool hasLift = false.obs;
  RxBool hasWaterAvailability = false.obs;
  RxBool isPetFriendly = false.obs;
  RxBool hasLaundryServices = false.obs;
  RxBool hasDishwasher = false.obs;
  RxBool hasWashingMachine = false.obs;
  RxBool hasChimney = false.obs;
  RxBool hasWaterFilter = false.obs;
  RxBool hasMicrowave = false.obs;
  RxBool hasFridge = false.obs;
  RxBool hasTV = false.obs;
  RxBool hasAC = false.obs;
  RxBool hasBalcony = false.obs;
  RxBool hasGym = false.obs;
  RxBool hasSwimmingPool = false.obs;
  RxBool hasClubHouse = false.obs;
  RxBool hasSecurity = false.obs;
  // Add more amenities as needed...

  // ... existing code ...

  // Function to reset filters
  void resetFilters() {
    selectedMinPrice.value = '';
    selectedMaxPrice.value = '';
    selectedLocation.value = '';
    selectedBedrooms.value = '';
    selectedBathrooms.value = '';
    selectedMinSquareFeet.value = '';
    selectedMaxSquareFeet.value = '';

    hasLift.value = false;
    hasWaterAvailability.value = false;
    isPetFriendly.value = false;
    hasLaundryServices.value = false;
    hasDishwasher.value = false;
    hasWashingMachine.value = false;
    hasChimney.value = false;
    hasWaterFilter.value = false;
    hasMicrowave.value = false;
    hasFridge.value = false;
    hasTV.value = false;
    hasAC.value = false;
    hasBalcony.value = false;
    hasGym.value = false;
    hasSwimmingPool.value = false;
    hasClubHouse.value = false;
    hasSecurity.value = false;    // Reset other amenities as needed...
  }
  List<Map<String, dynamic>> properties = [];



  Future<void> applyFilters() async {
    // Perform filtering logic here

    final mongoDBService = MongoDBService();
    final List<Map<String, dynamic>> data = await mongoDBService.fetchData();

    filteredProperties.value = data
        .where((property) =>
    isLocationMatch(property) &&
        isBathroomsMatch(property))
        .toList();

    print(properties.length);
    // Update the main 'properties' list with the filtered properties
    // properties  = filteredProperties.toList();

  }
  // Functions to check if property matches selected options
  bool isPriceMatch(Map<String, dynamic> property) {
    int minPrice = int.parse(selectedMinPrice.value);
    int maxPrice = int.parse(selectedMaxPrice.value);
    int propertyPrice = property['Rent']; // Replace with actual property price key
    return propertyPrice >= minPrice && propertyPrice <= maxPrice;
  }

  bool isLocationMatch(Map<String, dynamic> property) {
    print(selectedLocation.value);
    // double latitude = property['location']['coordinates'][1];
    // double longitude = property['location']['coordinates'][0];
    //
    // print(latitude);
    return property['Zone'] == selectedLocation.value;
  }

  bool isBedroomsMatch(Map<String, dynamic> property) {
    return property['BedRoom'] == selectedBedrooms.value;
  }

  bool isBathroomsMatch(Map<String, dynamic> property) {
    return property['BathRoom'] == int.parse(selectedBathrooms.value);
  }

  bool isSquareFeetMatch(Map<String, dynamic> property) {
    int minSquareFeet = int.parse(selectedMinSquareFeet.value);
    int maxSquareFeet = int.parse(selectedMaxSquareFeet.value);
    int propertySquareFeet = property['Area']; // Replace with actual property square feet key
    return propertySquareFeet >= minSquareFeet && propertySquareFeet <= maxSquareFeet;
  }

  bool areAmenitiesMatch(Map<String, dynamic> property) {
    // Add logic to check if amenities match
    return true;
  }


// ... existing code ...
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  List<String> categories = [
    "Residential",
    "Commercial",
  ];
  List<Map<String, dynamic>> properties = [];

  int current = 0;
  String selectedType = "Residential"; // Default type

  Future<void> fetchData() async {
    try {
      final mongoDBService = MongoDBService();
      final List<Map<String, dynamic>> data = await mongoDBService.fetchData();

      setState(() {
        properties = data;
        // print(properties.length);
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }



  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth radius in kilometers

    double degToRad(double deg) {
      return deg * ( pi / 180);
    }

    double dLat = degToRad(lat2 - lat1);
    double dLon = degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(lat1)) * cos(degToRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c; // Distance in kilometers

    return distance;
  }

  List<Map<String, dynamic>> filterPropertiesByDistance(
      List<Map<String, dynamic>> allProperties,
      double searchLat,
      double searchLon,
      double maxDistance,
      ) {
    List<Map<String, dynamic>> filteredProperties1 = [];

    for (var property in allProperties) {
      double propertyLat = property['location']['coordinates'][1];
      double propertyLon = property['location']['coordinates'][0];

      double distance = calculateDistance(searchLat, searchLon, propertyLat, propertyLon);

      if (distance <= maxDistance) {
        filteredProperties1.add(property);
      }
    }

    return filteredProperties1;
  }

  Future<void> handleSearch(String searchQuery, BuildContext context) async {
    try {
      print("aa gaya");
      // Get coordinates of the searched place
      Map<String, dynamic> coordinates = await getCoordinates(searchQuery);
      // print(coordinates);
      // Assuming max distance is 15 km
      double maxDistance = 5.0;
      double latitude = coordinates['lat'];
      double longitude = coordinates['lng'];
      print("lart $latitude");
      print("long $longitude");

      // Call the function to filter properties
      List<Map<String, dynamic>> filteredProperties1 = filterPropertiesByDistance(
          properties, latitude, longitude, maxDistance);
      // Navigate to the FilteredPropertiesPage with the filtered properties
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilteredPropertiesPage(filteredProperties: filteredProperties1),
        ),
      );
      fetchData();

    } catch (error) {
      // Handle errors, such as no results from the geocoding service
      print("Error: $error");
      // You may want to show an error message to the user
    }
  }

  Future<Map<String, dynamic>> getCoordinates(String address) async {
    final apiKey = 'AIzaSyDO2-7H9ev2P1kl8oWaqnseU0u0x6wjNGc';
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        return location;
      } else {
        throw Exception('Failed to retrieve coordinates');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }



  Future<void> applyFilters() async {
    await homeController.applyFilters();
    fetchData();
    print(homeController.filteredProperties.length);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredPropertiesPage(
          filteredProperties: homeController.filteredProperties,
        ),
      ),
    );
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // super.dispose();
  }

  void updateSelectedType(String type) {
    setState(() {
      selectedType = type;
    });
  }

  // Future<void> _updateDistances() async {
  //   final Position currentPosition = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //   setState(() {
  //     properties.forEach((property) {
  //       final double distance = Geolocator.distanceBetween(
  //         currentPosition.latitude,
  //         currentPosition.longitude,
  //         property['lat'], // replace with the actual key for latitude from your API
  //         property['lon'], // replace with the actual key for longitude from your API
  //       );
  //       property['distance'] = (distance / 1000).toStringAsFixed(2); // in kilometers
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 1.5,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/logo1.png',
                            width: 200,
                            height: 50,

                            )
                          ],
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyPostPage(),
                        ),
                      )),
                      child: Image.asset(
                        'assets/icons8-add-50.png',
                        height: 34,
                        width: 34,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: kRalewayRegular.copyWith(
                          color: kBlack,
                          fontSize: SizeConfig.blockSizeHorizontal! * 3,
                        ),onSubmitted: (query) {
                          // print("submitted");
                          print(query);
                // Handle search submission
                            handleSearch(query, context);
                          },
                                    // controller: TextEditingController(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: kPadding16,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(
                              kPadding8,
                            ),
                            child: SvgPicture.asset(
                              'assets/icon_search.svg',
                            ),
                          ),
                          hintText: 'Search address, or near you',
                          border: kInputBorder,
                          errorBorder: kInputBorder,
                          disabledBorder: kInputBorder,
                          focusedBorder: kInputBorder,
                          enabledBorder: kInputBorder,
                          hintStyle: kRalewayRegular.copyWith(
                            color: kGrey85,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3,
                          ),
                          filled: true,
                          fillColor: kWhiteF7,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 4,
                    ),
                    Container(
                      height: 49,
                      width: 49,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius10),
                        gradient: kLinearGradientBlue,
                      ),
                      child: GestureDetector(
                        onTap: () {

                          Get.dialog(FilterDialog(
                            applyFiltersCallback: applyFilters,
                          ),);
                        },
                        child: SvgPicture.asset('assets/icon_filter.svg'),
                      ),

                    )
                  ],
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
              SizedBox(
                width: double.infinity,
                height: 34,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          updateSelectedType(categories[index]);

                          current = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? kPadding20 : 12,
                          right:
                              index == categories.length - 1 ? kPadding20 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: kPadding16,
                        ),
                        height: 34,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              offset: const Offset(0, 18),
                              blurRadius: 18,
                              color: current == index
                                  ? kBlue.withOpacity(0.1)
                                  : kBlue.withOpacity(0),
                            )
                          ],
                          gradient: current == index
                              ? kLinearGradientBlue
                              : kLinearGradientWhite,
                          borderRadius: BorderRadius.circular(
                            kBorderRadius10,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: kRalewayMedium.copyWith(
                              color: current == index ? kWhite : kGrey85,
                              fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Near from you',
                      style: kRalewayMedium.copyWith(
                        color: kBlack,
                        fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
              SizedBox(
                height: 242,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: properties.length, // Replace '5' with 'properties.length'
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    if (property['Type'] == selectedType) {
                    return GestureDetector(
                      onTap: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(property: property),
                        ),
                      )),
                      child: Container(
                        height: 272,
                        width: 222,
                        margin: EdgeInsets.only(
                          left: kPadding20,
                          right: index ==properties.length - 1 ? kPadding20 : 0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            kBorderRadius20,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              offset: const Offset(0, 18),
                              blurRadius: 18,
                              color: kBlack.withOpacity(0.1),
                            )
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(property['image_files']), // Use the 'image' property from API
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 136,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(kBorderRadius20),
                                    bottomRight: Radius.circular(kBorderRadius20),
                                  ),
                                  gradient: kLinearGradientBlack,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding16,
                                  vertical: kPadding20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              kBorderRadius20,
                                            ),
                                            color: kBlack.withOpacity(
                                              0.24,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: kPadding8,
                                            vertical: kPadding4,
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icon_pinpoint.svg',
                                              ),
                                              const SizedBox(
                                                width: kPadding4,
                                              ),
                                              Text(
                                                '${property['distance']} km',
                                                style: kRalewayRegular.copyWith(
                                                  color: kWhite,
                                                  fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          property['Location'] + '\n'   + property['Area'].toString() + ' Sq ft', // Use the 'name' property from API
                                          style: kRalewayMedium.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: kWhite,
                                            fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.blockSizeVertical! * 0.5,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icon_bedroom.svg',
                                                  color:  Colors.white,
                                                ),
                                                // SizedBox(
                                                //   width: SizeConfig.blockSizeHorizontal! * 0.5,
                                                // ),
                                                Text(
                                                  '${property['BedRoom']} Bed', // Use the 'bedrooms' property from API
                                                  style: kRalewayRegular.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: SizeConfig.blockSizeHorizontal! * 2.9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        SizedBox(
                                          width: SizeConfig.blockSizeHorizontal! * 1,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(

                                              'assets/icon_bathroom.svg',
                                              color:  Colors.white,
                                            ),
                                            SizedBox(
                                              width: SizeConfig.blockSizeHorizontal! * 0.5,
                                            ),
                                            Text(
                                              '${property['BathRoom']} Bath', // Use the 'bathrooms' property from API
                                              style: kRalewayRegular.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:  Colors.white,
                                                fontSize: SizeConfig.blockSizeHorizontal! * 2.9,
                                              ),
                                            ),
                                          ],
                                        ),

                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    );
                    } else {
                      return SizedBox.shrink(); // Hide properties with different type
                    }
                  },
                ),
              ),

              const SizedBox(
                height: kPadding24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best for you',
                      style: kRalewayMedium.copyWith(
                        color: kBlack,
                        fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      ),
                    ),
                    Text(
                      'See more',
                      style: kRalewayRegular.copyWith(
                        color: kGrey85,
                        fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding20,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: properties.length, // Replace '8' with 'properties.length'
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    if (property['Type'] == selectedType) {
                    return Container(
                      height: 70,
                      margin: const EdgeInsets.only(
                        bottom: kPadding24,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kBorderRadius10),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0,
                                  offset: const Offset(0, 18),
                                  blurRadius: 18,
                                  color: kBlack.withOpacity(0.1),
                                )
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(property['image_files']), // Use the 'image' property from API
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 4.5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  property['Location'] + '\n' + property['Zone'], // Use the 'name' property from API
                                  style: kRalewayMedium.copyWith(
                                    fontWeight: FontWeight.bold
                                    ,
                                    color: kBlack,
                                    fontSize: SizeConfig.blockSizeHorizontal! * 3.33,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical! * 0.5,
                                ),
                                Text(
                                  '₹ ${property['Rent']}/month', // Use the 'price' and 'duration' properties from API
                                  style: kRalewayRegular.copyWith(
                                    color: kBlue,
                                    fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon_bedroom.svg',
                                          ),
                                          SizedBox(
                                            width: SizeConfig.blockSizeHorizontal! * 0.5,
                                          ),
                                          Text(
                                            '${property['BedRoom']} Bedroom', // Use the 'bedrooms' property from API
                                            style: kRalewayRegular.copyWith(
                                              color: kGrey85,
                                              fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! * 1,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon_bathroom.svg',
                                          ),
                                          SizedBox(
                                            width: SizeConfig.blockSizeHorizontal! * 0.5,
                                          ),
                                          Text(
                                            '${property['BathRoom']} Bathroom', // Use the 'bathrooms' property from API
                                            style: kRalewayRegular.copyWith(
                                              color: kGrey85,
                                              fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    } else {
                      return SizedBox.shrink(); // Hide properties with different type
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
