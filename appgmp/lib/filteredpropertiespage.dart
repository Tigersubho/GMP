import 'package:appgmp/product_detail_page.dart';
import 'package:appgmp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_styles.dart';

class FilteredPropertiesPage extends StatelessWidget {
  final List<Map<String, dynamic>> filteredProperties;

  const FilteredPropertiesPage({Key? key, required this.filteredProperties})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kPadding20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // SizedBox(
                  //   height: SizeConfig.blockSizeVertical! * 1.5,
                  // ),
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
              
            ],
          ),
        ),
      ),
      body:Padding(
        padding: EdgeInsets.only(top:30),
        child: SizedBox(
          height: 260,

          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16),
            scrollDirection: Axis.horizontal,
            itemCount: filteredProperties.length, // Replace '5' with 'properties.length'
            itemBuilder: (context, index) {
              final property = filteredProperties[index];
              // if (property['Type'] == selectedType) {
                return GestureDetector(
                  onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(property: property),
                    ),
                  )),
                  child: Container(
                    // height: 200,
                    width: 222,
                    margin: EdgeInsets.only(
                      left: kPadding20,
                      right: index ==filteredProperties.length - 1 ? kPadding20 : 0,
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
                            height: 300,
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
        
            },
          ),
        ),
      ),
    );
  }
}
