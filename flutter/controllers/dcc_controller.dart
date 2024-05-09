// dcc_controller.dart
//
// maintains ble mac address, loco1 address, loco2 address, loco3 address
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DCCController {

var bleMac = 'goto setting '.obs;
var loco1 = ' '.obs;
var loco2 = ' '.obs;
var loco3 = ' '.obs;
  
void setBleMac(val){ bleMac.value = val; }

void setLoco1(val){ loco1.value = val; }

void setLoco2(val){ loco2.value = val; }

void setLoco3(val){ loco3.value = val; }

}
