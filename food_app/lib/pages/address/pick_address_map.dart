import 'package:flutter/material.dart';
import 'package:food_app/base/custom_button.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/widgets/search_location_dialogue.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget{
  final bool fromSingup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({super.key, required this.fromSingup, required this.fromAddress, this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initalPosition=LatLng(45.521563, -122.677433);
      _cameraPosition= CameraPosition(target: _initalPosition,zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initalPosition=LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition=CameraPosition(target: _initalPosition,zoom:17 );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return  Scaffold(
        body: SafeArea(child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(initialCameraPosition: CameraPosition(
                    target: _initalPosition,zoom: 17
                ),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition){
                    _cameraPosition=cameraPosition;
                  },
                  onCameraIdle: (){
                    Get.find<LocationController>().updatePosition(_cameraPosition, false);
                  },
                  onMapCreated: (GoogleMapController mapController){
                  _mapController = mapController;
                  if(!widget.fromAddress);
                  },
                ),
                Center(
                  child: !locationController.loading?Image.asset("assets/image/logo.png",
                    height: 50, width: 50,
                      ):CircularProgressIndicator()
                ),
                Positioned(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child:InkWell(
                    onTap: () => Get.dialog(LocationDialogue(mapController: _mapController)),
                  child: Container(padding:
                    EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,size: 25,color: AppColors.mainBlackColor,),
                        Expanded(child: Text(
                          '${locationController.pickPlacemark.name??''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16,

                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(
                          width: Dimensions.width10,),
                    Icon(Icons.search,size: 25, color: AppColors.yellowColor,)

                      ],
                    ),
                  ),
                ),),
                Positioned(
                  bottom: 90,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: !locationController.isLading?Center(child: CircularProgressIndicator(),):CustomButton(

                      buttonText:widget.fromAddress?'Pick Address':'Pick Location',
                      onPressed: locationController.loading?(){print("should be null value");}:(){
                        if(locationController.pickPosition.latitude!=0&&
                            locationController.pickPlacemark.name!=null){
                          if(widget.fromAddress){
                            if(widget.googleMapController!=null){
                              print("Now you can clicked on this");
                              widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                locationController.pickPosition.latitude,
                                locationController.pickPosition.longitude,
                              ))));
                              locationController.setAddAdressData();
                            }
                            //get.back()
                            Get.toNamed(RouteHelper.getAddressPage());
                          }
                        }
                      },
                    )
                )
                ],
            ),
          ),
        )),
      );
    });
  }
}
