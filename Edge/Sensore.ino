using std::vector;
using std::string;
#include <time.h>
#include <Wire.h>
#include <EdgeEngine_library.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 20, 4);
int count=0; // contatore per il numero di persone
int count2=0;
uint8_t pirPin_entrance = 35;   //pin per i 2 sensori PIR
uint8_t pirPin_eXit = 34;

clock_t pirCounter_entrance;  // variabili per la gestione dei delay dei sensori pir
clock_t pirCounter_eXit; 
clock_t cycleCounter;
clock_t sleepTime;

float periodo = 3;

sample* entrance=NULL;
sample* eXit=NULL;

const char* ssidWifi = "TIM-18183892";  
const char* passWifi = "vNq6X2LoGjeFL2NvCIoA1EtG";
//const char* ssidWifi = "VodafoneMobileWiFi-5F2E99";
//const char* passWifi = "5180566732";

edgine* Edge;
connection* Connection;     //Wrapper for the wifi connection
vector<sample*> samples;

 
void setup() {
  lcd.init();                           // inizializzo lcd
  lcd.backlight();                     // illuminazione attiva
  lcd.setCursor(0,0);
  lcd.print("Benvenuti!");
  lcd.setCursor(0,1);
  lcd.print("Persone dentro:");
  lcd.setCursor(0,2);
  lcd.print(count);
  
 //setup connection
 Connection = connection::getInstance();
 Connection->setupConnection(ssidWifi, passWifi);

options opts;
  //login
  opts.username = "market-username";
  opts.password =  "market-password";
  //route
  opts.url = "https://students.atmosphere.tools";
  opts.ver = "v1";
  opts.login = "login";
  opts.devs = "devices";
  opts.scps = "scripts";
  opts.measurements = "measurements";
  opts.info= "info";
  opts.issues="issues";
  //Edgine identifiers
  opts.thing = "market";
  opts.device = "entrance-exit-detector";
  opts.id = "entrance-exit-detector";

  //initialize Edge engine
  Edge=edgine::getInstance();
  Edge->init(opts);

  pinMode(pirPin_entrance, INPUT);
  pinMode(pirPin_eXit, INPUT);
  attachInterrupt(digitalPinToInterrupt(pirPin_entrance), detectedEntrance, RISING);
  attachInterrupt(digitalPinToInterrupt(pirPin_eXit), detectedExit, RISING);
}

void loop() {
  
  if(count2 != count){
  lcd.setCursor(0,2);
  lcd.print(count);
  count2=count;
  }
 
  cycleCounter=clock();
  
  Edge->evaluate(samples);
  samples.clear();
  
  if( ((float)clock()-pirCounter_entrance)>=3000){// pir sensor needs 3 seconds to be ready to give another measurement
    if(!entrance){
      delete entrance;
      entrance=NULL;
    }
    attachInterrupt(digitalPinToInterrupt(pirPin_entrance), detectedEntrance, RISING);
  }
  if( ((float)clock()-pirCounter_eXit)>=3000){
    if(!eXit){
      delete eXit;
      eXit=NULL;
    }
    attachInterrupt(digitalPinToInterrupt(pirPin_eXit), detectedExit, RISING);
  }
  
   cycleCounter=clock()-cycleCounter;

   // subtract the execution time to the Sleep period if result is not negative
  ((float)cycleCounter/CLOCKS_PER_SEC) < periodo ? sleepTime=(periodo-(float)cycleCounter/CLOCKS_PER_SEC)*1000 : sleepTime=0;//delay in milliseconds
 
  delay(sleepTime);
}

void detectedEntrance(){
  count++;
  detachInterrupt(digitalPinToInterrupt(pirPin_entrance)); 
  pirCounter_entrance=clock();
  entrance = new sample("entrance");
  entrance->startDate=Edge->Api->getActualDate();
  entrance->endDate=entrance->startDate;
  entrance->value=1;
  samples.push_back(entrance);
}
void detectedExit(){
  count--;
  detachInterrupt(digitalPinToInterrupt(pirPin_eXit)); 
  pirCounter_eXit=clock();
  eXit = new sample("exit");
  eXit->startDate=Edge->Api->getActualDate();
  eXit->endDate=eXit->startDate;
  eXit->value=1;
  samples.push_back(eXit);
}
