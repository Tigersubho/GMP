import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appgmp/app_styles.dart';

import 'home_page.dart';

class FilterDialog extends StatelessWidget {
  get kPadding10 => 10.0;
  final VoidCallback applyFiltersCallback;
  FilterDialog({required this.applyFiltersCallback});


  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context, homeController),
      ),
    );
  }

  Widget contentBox(BuildContext context, HomeController homeController) {
    return Container(
      padding: EdgeInsets.all(kPadding20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter',
            style: kRalewayMedium.copyWith(
              color: kBlack,
              fontSize: 20,
            ),
          ),
          SizedBox(height: kPadding20),
          Obx(() {
            return buildDropdown('Min Price', homeController.minPriceOptions,
                homeController.selectedMinPrice);
          }),
          Obx(() {
            return buildDropdown('Max Price', homeController.maxPriceOptions,
                homeController.selectedMaxPrice);
          }),
          Obx(() {
            return buildDropdown(
                'Location', homeController.locationOptions, homeController.selectedLocation);
          }),
          Obx(() {
            return buildDropdown(
                'Bedrooms', homeController.bedroomsOptions, homeController.selectedBedrooms);
          }),
          Obx(() {
            return buildDropdown(
                'Bathrooms', homeController.bathroomsOptions, homeController.selectedBathrooms);
          }),
          Obx(() {
            return buildDropdown('Min Sq. Feet', homeController.squareFeetOptions,
                homeController.selectedMinSquareFeet);
          }),
          Obx(() {
            return buildDropdown('Max Sq. Feet', homeController.squareFeetOptions,
                homeController.selectedMaxSquareFeet);
          }),
          SizedBox(height: kPadding20),
          Text(
            'Amenities',
            style: kRalewayMedium.copyWith(
              color: kBlack,
              fontSize: 16,
            ),
          ),
          SizedBox(height: kPadding10),
          Obx(() {
            return buildCheckbox('Lift', homeController.hasLift);
          }),
          Obx(() {
            return buildCheckbox(
                'Water Availability', homeController.hasWaterAvailability);
          }),
          Obx(() {
            return buildCheckbox('Pet Friendly', homeController.isPetFriendly);
          }),
          // Add more checkboxes as needed...
          SizedBox(height: kPadding20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  homeController.resetFilters();
                  Navigator.of(context).pop();
                },
                child: Text('Reset'),
              ),
              SizedBox(width: kPadding10),
              ElevatedButton(
                onPressed: () {
                  applyFiltersCallback.call();
                  Navigator.of(context).pop();
                },
                child: Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(
      String label, List<String> options, RxString selectedOption) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kRalewayRegular.copyWith(
            color: kGrey85,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: true,
          value: selectedOption.value,
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: (value) {
            selectedOption.value = value!;
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: kPadding10),
      ],
    );
  }

  Widget buildCheckbox(String label, RxBool checkboxValue) {
    return Row(
      children: [
        Checkbox(
          value: checkboxValue.value,
          onChanged: (value) {
            checkboxValue.value = value!;
          },
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: kRalewayRegular.copyWith(
            color: kGrey85,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
