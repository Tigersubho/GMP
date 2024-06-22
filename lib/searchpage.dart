import 'package:appgmp/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:appgmp/app_styles.dart';
import 'package:appgmp/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatelessWidget {
  final List<Map<String, dynamic>> properties;

  const SearchPage({Key? key, required this.properties}) : super(key: key);

  get kPadding10 => 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kPadding24,
              ),
              SizedBox(
                height: 242,
                child: ListView.builder(
                  scrollDirection: Axis.vertical, // Change to vertical scrolling
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(property: property),
                        ),
                      ),
                      child: Container(
                        height: 272,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: kPadding20,
                          vertical: kPadding10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kBorderRadius20),
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
                            image: NetworkImage(property['image']),
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
                                          property['Location'] +
                                              '\n' +
                                              property['Area'].toString() +
                                              ' Sq ft',
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
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  '${property['BedRoom']} Bed',
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
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.blockSizeHorizontal! * 0.5,
                                                ),
                                                Text(
                                                  '${property['BathRoom']} Bath',
                                                  style: kRalewayRegular.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
