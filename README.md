# DESIGN AND DEVELOPMENT OF AN EMBEDDED SYSTEM FOR REMOTE ACCESS CONTROL

The purpose of this thesis is to develop an embedded system for the detection of entrances and exits from a public place such as, for example, 
in the chosen case, a supermarket. Two PIR (Passive InfraRed) sensors were used to acquire the data. A development board with ESP32 microcontroller 
and integrated WiFi module was used to process the measurements. An LCD display was connected to the board for on-site viewing of the number of people in the shop.
The collected data is then sent to the cloud using the APIs provided by the Measurify framework. Subsequently an application was  
developed using a cross-platform framework called Flutter that uses the Dart language. Visual Studio Code was used as development environment by installing 
the extensions for the Dart language support and for the Flutter framework. Through the application it is possible to remotely control the number of people 
in the shop both at the moment when the search is being carried out, both at a time of our choosing by entering date and time with the commands 
provided.

## EDGE
First you need to install Edge Engine (follow the instructions in the dedicated repository). Then you need to enter your Wi-Fi network data and the Measurify login data. Make the connections described in chapter 3.1.1 of the thesis between board and sensors.Finally load the sketch on the microcontroller through "Arduino IDE".
