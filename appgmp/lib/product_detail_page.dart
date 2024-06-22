import 'package:flutter/material.dart';
import 'package:appgmp/app_styles.dart';
import 'package:appgmp/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> property;

  const ProductDetailPage({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding8,
        ),
        height: 59,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: kPadding20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Handle contact agent action
                debugPrint('Contact Agent Tapped');
              },
              child: Container(
                height: 45,
                width: 145, // Adjust width as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: kLinearGradientBlue,
                ),
                child: Center(
                  child: Text(
                    'Contact Agent',
                    style: kRalewaySemibold.copyWith(
                      color: kWhite,
                      fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 9,
            ),
            GestureDetector(
              onTap: () {
                // Handle request tour action
                debugPrint('Request Tour Tapped');
              },
              child: Container(
                height: 45,
                width: 145, // Adjust width as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: kLinearGradientBlue,
                ),
                child: Center(
                  child: Text(
                    'Request Tour',
                    style: kRalewaySemibold.copyWith(
                      color: kWhite,
                      fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: kPadding20,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Container(
                  height: 259,
                  width: double.infinity,
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
                        image: NetworkImage(property['image_files']),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(kBorderRadius20),
                              bottomRight: Radius.circular(kBorderRadius20),
                            ),
                            gradient: kLinearGradientBlack,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kPadding20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: kBlack.withOpacity(0.24),
                                  child: SvgPicture.asset(
                                    'assets/icon_arrow_back.svg',
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: kBlack.withOpacity(0.24),
                                  child: SvgPicture.asset(
                                    'assets/icon_bookmark.svg',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property['Location'], // Use the 'Location' property from the passed property
                                  style: kRalewaySemibold.copyWith(
                                    color: kWhite,
                                    fontSize:
                                    SizeConfig.blockSizeHorizontal! * 5.5,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical! * 0.5,
                                ),
                                Text(
                                  property['Zone'] + ' , ' + property['PIN'].toString()
                                  , // Use the 'Zone' property from the passed property
                                  style: kRalewayRegular.copyWith(
                                    color: kWhite,
                                    fontSize: SizeConfig.blockSizeHorizontal! * 3,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical! * 1.5,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [

                                        Container(
                                          height:
                                              SizeConfig.blockSizeHorizontal! * 7,
                                          width:
                                              SizeConfig.blockSizeHorizontal! * 7,
                                          decoration: BoxDecoration(
                                            color: kWhite.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              kBorderRadius5,
                                            ),
                                          ),
                                          padding:
                                              const EdgeInsets.all(kPadding4),
                                          child: SvgPicture.asset(
                                            'assets/icon_bedroom_white.svg',
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.blockSizeHorizontal! *
                                              2.5,
                                        ),
                                        Text(
                                          '${property['BedRoom']} Bedroom',
                                          style: kRalewayRegular.copyWith(
                                            color: kWhite,
                                            fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal! * 7.5,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height:
                                              SizeConfig.blockSizeHorizontal! * 7,
                                          width:
                                              SizeConfig.blockSizeHorizontal! * 7,
                                          decoration: BoxDecoration(
                                            color: kWhite.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              kBorderRadius5,
                                            ),
                                          ),
                                          padding:
                                              const EdgeInsets.all(kPadding4),
                                          child: SvgPicture.asset(
                                            'assets/icon_bathroom_white.svg',
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.blockSizeHorizontal! *
                                              2.5,
                                        ),
                                        Text(
                                          '${property['BathRoom']} Bathroom',
                                          style: kRalewayRegular.copyWith(
                                            color: kWhite,
                                            fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                2.5,
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
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
              Row(
                children: [
                  Text(
                    '₹ ${property['Rent']}/month',
                    style: kRalewayMedium.copyWith(
                      color: kBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal! * 7,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: kPadding24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow("Type", property['Type']),
                  buildDetailRow("Area", "${property['Area']} sq ft"),
                  buildDetailRow("Rent", "₹ ${property['Rent']}/month"),
                  buildDetailRow("Bedroom", "${property['BedRoom']}"),
                  buildDetailRow("Bathroom", "${property['BathRoom']}"),
                  buildDetailRow("Servant Quarter", property['ServantQuarter']),
                  buildDetailRow("Security Deposit", "₹ ${property['Securitydeposit']}"),


                  ExpansionTile(
                    title: Text("Show More Details"),
                    children: [
                      buildDetailRow("Brokerage", "₹ ${property['Brokerage']}"),
                      buildDetailRow("Floor", "${property['FLOOR']}"),
                      buildDetailRow("Bedroom", "${property['BedRoom']}"),
                      buildDetailRow("Bathroom", "${property['BathRoom']}"),
                      buildDetailRow("Furnishing", property['Furnishing']),
                      buildDetailRow("Flooring", property['Flooring']),
                      buildDetailRow("Car Parking", property['CarParking']),
                      buildDetailRow("Bike Parking", property['BikeParking']),
                      buildDetailRow("Cycle Parking", property['CycleParking']),
                      buildDetailRow("Facing", property['Facing']),
                      buildDetailRow("Flat View", property['FlatView'].toString()),
                      buildDetailRow("Age", "${property['Age']} years"),
                      buildDetailRow("Nature", property['Nature'].toString()),
                      buildDetailRow("Lift", property['Lift'].toString()),
                      buildDetailRow("Water Availability", property['WaterAvailability'].toString()),
                      buildDetailRow("Pet Friendly", property['PetFriendly'].toString()),
                      buildDetailRow("Laundry", property['Laundry'].toString()),
                      buildDetailRow("Dishwasher", property['Dishwasher'].toString()),
                      buildDetailRow("Washing Machine", property['WashingMachine'].toString()),
                      buildDetailRow("Chimney Provision", property['ChimneyProvision'].toString()),
                      buildDetailRow("Water Filter Provision", property['WaterFilterProvision'].toString()),
                      buildDetailRow("Hob Provision", property['HobProvision'].toString()),
                      buildDetailRow("Microwave Provision", property['MicrowaveProvision'].toString()),
                      buildDetailRow("Fridge", property['Fridge'].toString()),
                      buildDetailRow("TV", property['TV'].toString()),
                      buildDetailRow("AC", property['AC'].toString()),
                      buildDetailRow("Balcony", property['Balcony'].toString()),
                      buildDetailRow("Gym", property['Gym'].toString()),
                      buildDetailRow("Swimming Pool", property['SwimmingPool'].toString()),
                      buildDetailRow("Club House", property['ClubHouse'].toString()),
                      buildDetailRow("Security", property['Security'].toString()),
                      buildDetailRow("Metro Station", property['MetroStation'].toString()),
                      buildDetailRow("Bus Station", property['BusStation'].toString()),
                      buildDetailRow("Auto Stand", property['AutoStand'].toString()),
                      buildDetailRow("Railway Station", property['RailwayStation'].toString()),
                      buildDetailRow("School", property['School'].toString()),
                      buildDetailRow("Hospital", property['Hospital'].toString()),
                      buildDetailRow("Children Park", property['ChildrenPark'].toString()),
                      buildDetailRow("Restaurants/Cafes", property['RestaurantsCafes'].toString()),
                      buildDetailRow("Shopping Mall", property['ShoppingMall'].toString()),
                      buildDetailRow("Cinema Hall", property['CinemaHall'].toString()),
                    ],
                      ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://blogger.googleusercontent.com/img/a/AVvXsEiRB_dB-wXqJdvt26dkR-vqOXUjacfxAQIgFNMHl_czjMNDOh6VZVc-muCczDKZh-VU0JqUYV1M9h25ZooLGqhVfwexQO6zNY1jxeMDu0-SpfEPe8xkF7re1eldAkKld9Ct1YzesFmHpQK9wlPK330AXA85gsmDBURTQm3i7r08g6vO7KNtAPyDgeUIaQ=s740',
                        ),
                        backgroundColor: kBlue,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get My Properties',
                            style: kRalewayMedium.copyWith(
                              color: kBlack,
                              fontSize: SizeConfig.blockSizeHorizontal! * 4,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 0.2,
                          ),
                          Text(
                            'Owner',
                            style: kRalewayMedium.copyWith(
                              color: kGrey85,
                              fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kBorderRadius5),
                          color: kBlue.withOpacity(0.5),
                        ),
                        child: SvgPicture.asset(
                          'assets/icon_phone.svg',
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 4,
                      ),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kBorderRadius5),
                          color: kBlue.withOpacity(0.5),
                        ),
                        child: SvgPicture.asset(
                          'assets/icon_message.svg',
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: kPadding24,
              ),


              Container(
                height: 161,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadius20),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/map_sample.png',
                    ),
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
                          gradient: kLinearGradientWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kPadding24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: kRalewayRegular.copyWith(
            color: kGrey85,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.blockSizeHorizontal! * 4,
          ),
        ),
        Text(
          textAlign: TextAlign.left,
          value.toString(),
          style: kRalewayRegular.copyWith(
            color: kBlack,
            fontSize: SizeConfig.blockSizeHorizontal! * 4,
          ),
        ),
      ],
    ),
  );
}