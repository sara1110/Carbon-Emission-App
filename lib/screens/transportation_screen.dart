import 'package:carbon_emission_app/config/theme.dart';

// Providers
import 'package:carbon_emission_app/providers/request/transportation/transportation_request_provider.dart';
import 'package:carbon_emission_app/providers/response/transportation/transportation_response_provider.dart';

// Widgets
import 'package:carbon_emission_app/widgets/calculate_button.dart';
import 'package:carbon_emission_app/widgets/custom_dropdown.dart';
import 'package:carbon_emission_app/widgets/emission_card.dart';
import 'package:carbon_emission_app/widgets/emission_card_skeleton.dart';
import 'package:carbon_emission_app/widgets/expanded_text_field.dart';

// Data Models
import 'package:carbon_emission_app/data/transportation/distance_unit.dart';
import 'package:carbon_emission_app/data/transportation/fuel_type.dart';
import 'package:carbon_emission_app/data/transportation/vehicle_type.dart';

// Requests & Responses
import 'package:carbon_emission_app/models/request/transportation_request.dart';
import 'package:carbon_emission_app/models/response/carbon_emission_response.dart';

// Services
import 'package:carbon_emission_app/services/api_service.dart';

// Flutter Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carbon_emission_app/providers/response/transportation/transportation_response_provider.dart';



class TransportationScreen extends ConsumerStatefulWidget {
  const TransportationScreen({super.key});

  @override
  ConsumerState<TransportationScreen> createState() =>
      _TransportationScreenState();
}

class _TransportationScreenState extends ConsumerState<TransportationScreen> {
  late TextEditingController distanceValueController;

  @override
  void initState() {
    super.initState();
    distanceValueController = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    distanceValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final transportationRequestState =
    ref.watch(transportationRequestStateProvider);
    final transportationRequestNotifier =
    ref.read(transportationRequestStateProvider.notifier);
    final transportationResponseState =
    ref.watch(transportationResponseStateProvider);
    final transportationResponseNotifier =
    ref.read(transportationResponseStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transportation Emissions"),
        backgroundColor: primaryBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height * 0.5 - kToolbarHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  transportationResponseState.when(
                    data: (response) => emissionCard(
                      icon: CupertinoIcons.car,
                      iconColor: secondaryBlue,
                      height: height,
                      width: width,
                      co2eGm: response?.co2eGm ?? 0,
                      co2eKg: response?.co2eKg ?? 0,
                      co2eLb: response?.co2eLb ?? 0,
                      co2eMt: response?.co2eMt ?? 0,
                    ),
                    error: (error, stack) => Text(
                      'Error: ${error.toString()}',
                      style: normal(color: Colors.red),
                    ),
                    loading: () =>
                        emissionCardSkeleton(height: height, width: width),
                  ),
                  const SizedBox(height: 16),
                  const Text("Please enter your data:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: expandedTextField(
                            height: height,
                            labelText: "Distance Traveled",
                            textController: distanceValueController,
                            onChanged: (value) {
                              final parsedValue = double.tryParse(value) ?? 0.0;
                              transportationRequestNotifier.updateDistanceValue(
                                  parsedValue);
                            }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: customDropdown(
                          labelText: "Distance Unit",
                          items: DistanceUnit.values,
                          value: transportationRequestState.distanceUnit,
                          onChanged: (value) => transportationRequestNotifier
                              .updateDistanceUnit(value as DistanceUnit),
                          width: width,
                          height: height,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  customDropdown(
                    labelText: "Vehicle Type",
                    items: VehicleType.values,
                    value: transportationRequestState.vehicleType,
                    onChanged: (value) => transportationRequestNotifier
                        .updateVehicleType(value as VehicleType),
                    width: width,
                    height: height,
                  ),
                  const SizedBox(height: 16),
                  customDropdown(
                    labelText: "Fuel Type",
                    items: FuelType.values,
                    value: transportationRequestState.fuelType,
                    onChanged: (value) => transportationRequestNotifier
                        .updateFuelType(value as FuelType),
                    width: width,
                    height: height,
                  ),
                  const SizedBox(height: 16),
                  calculateButton(
                    width: width,
                    height: height,
                    btnColor: secondaryBlue,
                    onTap: () => transportationResponseNotifier
                        .calculateTransportationEmission(
                        transportationRequestState),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}