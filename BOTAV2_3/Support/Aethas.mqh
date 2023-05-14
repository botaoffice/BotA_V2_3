//+------------------------------------------------------------------+
//|                                                       Aethas.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Heisl"
#property link      "https://www.google.com"
#property strict

class Aethas{

   private:
      
      string Name;
      
      string ID;
         
      datetime TIME;
      double ASK;
      double BID;
      
      bool Use_M1;
      bool Use_M5;
      bool Use_M15;
      bool Use_M30;
      bool Use_H1;
      bool Use_H4;
      bool Use_D1;
      bool Use_W1;
      bool Use_MN1;
      
      int Current_Candle_M1;
      int Current_Candle_M5;
      int Current_Candle_M15;
      int Current_Candle_M30;
      int Current_Candle_H1;
      int Current_Candle_H4;
      int Current_Candle_D1;
      int Current_Candle_W1;
      int Current_Candle_MN1;
      
      datetime Current_Time_M1;
      datetime Current_Time_M5;
      datetime Current_Time_M15;
      datetime Current_Time_M30;
      datetime Current_Time_H1;
      datetime Current_Time_H4;
      datetime Current_Time_D1;
      datetime Current_Time_W1;
      datetime Current_Time_MN1;
      
      
      datetime Time_M1[];
      datetime Time_M5[];
      datetime Time_M15[];
      datetime Time_M30[];
      datetime Time_H1[];
      datetime Time_H4[];
      datetime Time_D1[];
      datetime Time_W1[];
      datetime Time_MN1[];
      
      double Open_M1[];
      double Open_M5[];
      double Open_M15[];
      double Open_M30[];
      double Open_H1[];
      double Open_H4[];
      double Open_D1[];
      double Open_W1[];
      double Open_MN1[];
      
      double Close_M1[];
      double Close_M5[];
      double Close_M15[];
      double Close_M30[];
      double Close_H1[];
      double Close_H4[];
      double Close_D1[];
      double Close_W1[];
      double Close_MN1[];
      
      double High_M1[];
      double High_M5[];
      double High_M15[];
      double High_M30[];
      double High_H1[];
      double High_H4[];
      double High_D1[];
      double High_W1[];
      double High_MN1[];
      
      double Low_M1[];
      double Low_M5[];
      double Low_M15[];
      double Low_M30[];
      double Low_H1[];
      double Low_H4[];
      double Low_D1[];
      double Low_W1[];
      double Low_MN1[];
      
      datetime last_time;
      
      int array_size;
   public:
         
      Aethas(void);
      Aethas(int size,string id);
      ~Aethas(void);
      
      int tick(datetime time,double ask,double bid);
      void inc_pointer(ENUM_TIMEFRAMES p);
      void resize(int size);
      void my_init(int size,string id);
      
      datetime getTime(ENUM_TIMEFRAMES p,int pos);
      double getOpen(ENUM_TIMEFRAMES p,int pos);
      double getClose(ENUM_TIMEFRAMES p,int pos);
      double getHigh(ENUM_TIMEFRAMES p,int pos);
      double getLow(ENUM_TIMEFRAMES p,int pos);
      int getCurrentCandle(ENUM_TIMEFRAMES p);
      
      int check_pos(int cc,int pos);
      
      int get_Current_Candle_M1();
      int get_Current_Candle_M5();
      int get_Current_Candle_M15();
      int get_Current_Candle_M30();
      int get_Current_Candle_H1();
      int get_Current_Candle_H4();
      int get_Current_Candle_D1();
      int get_Current_Candle_W1();
      int get_Current_Candle_MN1();
};      

void Aethas::Aethas(){
   my_init(30,"110000000");
   //array_size=30;
   //resize(array_size);
   //Print("??wrong init aethas");
}
void Aethas::Aethas(int size, string id){
   my_init(size,id);
   
   //Print("good init aethas");
}
void Aethas::~Aethas(){
   ArrayFree(Time_M1);
   ArrayFree(Time_M5);
   ArrayFree(Time_M15);
   ArrayFree(Time_M30);
   ArrayFree(Time_H1);
   ArrayFree(Time_H4);
   ArrayFree(Time_D1);
   ArrayFree(Time_W1);
   ArrayFree(Time_MN1);
   
   ArrayFree(Open_M1);
   ArrayFree(Open_M5);
   ArrayFree(Open_M15);
   ArrayFree(Open_M30);
   ArrayFree(Open_H1);
   ArrayFree(Open_H4);
   ArrayFree(Open_D1);
   ArrayFree(Open_W1);
   ArrayFree(Open_MN1);
   
   ArrayFree(Close_M1);
   ArrayFree(Close_M5);
   ArrayFree(Close_M15);
   ArrayFree(Close_M30);
   ArrayFree(Close_H1);
   ArrayFree(Close_H4);
   ArrayFree(Close_D1);
   ArrayFree(Close_W1);
   ArrayFree(Close_MN1);
   
   ArrayFree(High_M1);
   ArrayFree(High_M5);
   ArrayFree(High_M15);
   ArrayFree(High_M30);
   ArrayFree(High_H1);
   ArrayFree(High_H4);
   ArrayFree(High_D1);
   ArrayFree(High_W1);
   ArrayFree(High_MN1);
   
   ArrayFree(Low_M1);
   ArrayFree(Low_M5);
   ArrayFree(Low_M15);
   ArrayFree(Low_M30);
   ArrayFree(Low_H1);
   ArrayFree(Low_H4);
   ArrayFree(Low_D1);
   ArrayFree(Low_W1);
   ArrayFree(Low_MN1);
}

int Aethas::get_Current_Candle_M1(){return(Current_Candle_M1);}
int Aethas::get_Current_Candle_M5(){return(Current_Candle_M5);}
int Aethas::get_Current_Candle_M15(){return(Current_Candle_M15);}
int Aethas::get_Current_Candle_M30(){return(Current_Candle_M30);}
int Aethas::get_Current_Candle_H1(){return(Current_Candle_H1);}
int Aethas::get_Current_Candle_H4(){return(Current_Candle_H4);}
int Aethas::get_Current_Candle_D1(){return(Current_Candle_D1);}
int Aethas::get_Current_Candle_W1(){return(Current_Candle_W1);}
int Aethas::get_Current_Candle_MN1(){return(Current_Candle_MN1);}


int Aethas::tick(datetime time,double ask,double bid){
   TIME = time;
   ASK = ask;
   BID = bid;
   
   //Print("AETHASTICK");
   
   int ret_val = 0;
   if(last_time!=0){
      MqlDateTime str_time,str_lasttime,str_delta; 
      
      TimeToStruct(time,str_time); 
      TimeToStruct(last_time,str_lasttime); 
   
      
   
      int delta_min = str_time.min - str_lasttime.min;
      int delta_hour = str_time.hour - str_lasttime.hour;
      int delta_yearday = str_time.day_of_year - str_lasttime.day_of_year;
      int delta_weekday = str_time.day_of_week - str_lasttime.day_of_week;
      int delta_day = str_time.day - str_lasttime.day;
      
      int delta = int(time)-int(last_time);
      if(delta_yearday<0 || delta > (3600*24*365)){
         //Print("Year Change ",time);
         if(Use_M1){inc_pointer(PERIOD_M1);}
         if(Use_M5){inc_pointer(PERIOD_M5);}
         if(Use_M15){inc_pointer(PERIOD_M15);}
         if(Use_M30){inc_pointer(PERIOD_M30);}
         if(Use_H1){inc_pointer(PERIOD_H1);}
         if(Use_H4){inc_pointer(PERIOD_H4);}
         if(Use_D1){inc_pointer(PERIOD_D1);}
         if(Use_W1){inc_pointer(PERIOD_W1);}
         if(Use_MN1){inc_pointer(PERIOD_MN1);}
         
         ret_val = (60*24*365);
      }
      else{
         if(delta_yearday>0 || delta > (3600*24)){
            Print("Day Change ",time);
            if(Use_M1){inc_pointer(PERIOD_M1);}
            if(Use_M5){inc_pointer(PERIOD_M5);}
            if(Use_M15){inc_pointer(PERIOD_M15);}
            if(Use_M30){inc_pointer(PERIOD_M30);}
            if(Use_H1){inc_pointer(PERIOD_H1);}
            if(Use_H4){inc_pointer(PERIOD_H4);}
            if(Use_D1){inc_pointer(PERIOD_D1);}
            
            ret_val = (60*24);
            
            if(delta_weekday <0 || delta > (3600*24*7)){
               //Print("Week Change ",time);
               if(Use_W1){inc_pointer(PERIOD_W1);}
               
               ret_val = (60*24*7);
            }
            else{
               if(delta_day < 0 || delta > (3600*24*30)){
                  //Print("Month Change ",time);
                  if(Use_MN1){inc_pointer(PERIOD_MN1);}
                  
                  ret_val = (60*24*30);
               }
            }
         }
         else{
            if(delta_hour>0 || delta > 3600){
               //Print("Hour Change");
               if(Use_M1){inc_pointer(PERIOD_M1);}
               if(Use_M5){inc_pointer(PERIOD_M5);}
               if(Use_M15){inc_pointer(PERIOD_M15);}
               if(Use_M30){inc_pointer(PERIOD_M30);}
               if(Use_H1){inc_pointer(PERIOD_H1);}
               
               ret_val = 60;
               if(Use_H4){
                  int rest = (str_time.hour-1) % 4;
                  
                  datetime last_h4_time = Time_H4[Current_Candle_H4]; 
                  MqlDateTime str_4h_time; 
                  TimeToStruct(last_h4_time,str_4h_time); 
                  if((rest == 0) || ((str_time.hour-str_4h_time.hour)>3) || (delta > 3600*4) ){
   
                     //Print("H4 Change1 ",time);
                     inc_pointer(PERIOD_H4);
                     
                     ret_val = (60*4);
                     
                  }
               }
            }
            else{
               if(delta_min>0 || delta > 60){
                  //Print("Min Change");  
                  int rest=0; 
                  if(Use_M1){inc_pointer(PERIOD_M1);}
                  
                  ret_val = (1);
                  if(Use_M5){
                     rest = str_time.min % 5;
                     datetime last_m5_time = Time_M5[Current_Candle_M5]; 
                     MqlDateTime str_m5_time; 
                     TimeToStruct(last_m5_time,str_m5_time); 
                     if(rest == 0 || (str_time.min-str_m5_time.min)>4 || delta > 60*5){
                        //Print("M5 Change");
                        inc_pointer(PERIOD_M5);
                        
                        ret_val = 5;
                     }
                  }
                  if(Use_M15){
                     rest = str_time.min % 15;
                     datetime last_m15_time = Time_M15[Current_Candle_M15]; 
                     MqlDateTime str_m15_time; 
                     TimeToStruct(last_m15_time,str_m15_time); 
                     if(rest == 0 || (str_time.min-str_m15_time.min)>14 || delta > 60*15){
                        //Print("M15 Change");
                        inc_pointer(PERIOD_M15);
                        
                        ret_val = 15;
                     }
                  }
                  if(Use_M30){
                     rest = str_time.min % 30;
                     datetime last_m30_time = Time_M30[Current_Candle_M30]; 
                     MqlDateTime str_m30_time; 
                     TimeToStruct(last_m30_time,str_m30_time); 
                     if(rest == 0 || (str_time.min-str_m30_time.min)>29 || delta > 60*30){
                        //Print("M30 Change");
                        inc_pointer(PERIOD_M30);
                        
                        ret_val = 30;
                     }
                  }
               }
            }
         }
      }
   }
   else{
      if(Use_M1){inc_pointer(PERIOD_M1);}
      if(Use_M5){inc_pointer(PERIOD_M5);}
      if(Use_M15){inc_pointer(PERIOD_M15);}
      if(Use_M30){inc_pointer(PERIOD_M30);}
      if(Use_H1){inc_pointer(PERIOD_H1);}
      if(Use_H4){inc_pointer(PERIOD_H4);}
      if(Use_D1){inc_pointer(PERIOD_D1);}
      if(Use_W1){inc_pointer(PERIOD_W1);}
      if(Use_MN1){inc_pointer(PERIOD_MN1);}
   } 
   last_time=time;
   
   if(Use_M1){Close_M1[Current_Candle_M1] = BID;}
   if(Use_M5){Close_M5[Current_Candle_M5] = BID;}
   if(Use_M15){Close_M15[Current_Candle_M15] = BID;}
   if(Use_M30){Close_M30[Current_Candle_M30] = BID;}
   if(Use_H1){Close_H1[Current_Candle_H1] = BID;}
   if(Use_H4){Close_H4[Current_Candle_H4] = BID;}
   if(Use_D1){Close_D1[Current_Candle_D1] = BID;}
   if(Use_W1){Close_W1[Current_Candle_W1] = BID;}
   if(Use_MN1){Close_MN1[Current_Candle_MN1] = BID;}
   
   if(Use_M1 && High_M1[Current_Candle_M1]<BID){
      High_M1[Current_Candle_M1]=BID;
   }
   if(Use_M5 && High_M5[Current_Candle_M5]<BID){
      High_M5[Current_Candle_M5]=BID;
   }
   if(Use_M15 && High_M15[Current_Candle_M15]<BID){
      //Print("M15 new high:",BID);
      High_M15[Current_Candle_M15]=BID;
   }
   if(Use_M30 && High_M30[Current_Candle_M30]<BID){
      High_M30[Current_Candle_M30]=BID;
   }
   if(Use_H1 && High_H1[Current_Candle_H1]<BID){
      High_H1[Current_Candle_H1]=BID;
   }
   if(Use_H4 && High_H4[Current_Candle_H4]<BID){
      High_H4[Current_Candle_H4]=BID;
   }
   if(Use_D1 && High_D1[Current_Candle_D1]<BID){
      High_D1[Current_Candle_D1]=BID;
   }
   if(Use_W1 && High_W1[Current_Candle_W1]<BID){
      High_W1[Current_Candle_W1]=BID;
   }
   if(Use_MN1 && High_MN1[Current_Candle_MN1]<BID){
      High_MN1[Current_Candle_MN1]=BID;
   }
   
   if(Use_M1 && Low_M1[Current_Candle_M1]>BID){
      Low_M1[Current_Candle_M1]=BID;
   }
   if(Use_M5 && Low_M5[Current_Candle_M5]>BID){
      Low_M5[Current_Candle_M5]=BID;
   }
   if(Use_M15 && Low_M15[Current_Candle_M15]>BID){
      //Print("M15 new low:",BID);
      Low_M15[Current_Candle_M15]=BID;
   }
   if(Use_M30 && Low_M30[Current_Candle_M30]>BID){
      Low_M30[Current_Candle_M30]=BID;
   }
   if(Use_H1 && Low_H1[Current_Candle_H1]>BID){
      Low_H1[Current_Candle_H1]=BID;
   }
   if(Use_H4 && Low_H4[Current_Candle_H4]>BID){
      Low_H4[Current_Candle_H4]=BID;
   }
   if(Use_D1 && Low_D1[Current_Candle_D1]>BID){
      Low_D1[Current_Candle_D1]=BID;
   }
   if(Use_W1 && Low_W1[Current_Candle_W1]>BID){
      Low_W1[Current_Candle_W1]=BID;
   }
   if(Use_MN1 && Low_MN1[Current_Candle_MN1]>BID){
      Low_MN1[Current_Candle_MN1]=BID;
   }
   
   return(ret_val);
}

void Aethas::my_init(int size,string id){
   Current_Candle_M1=0;
   Current_Candle_M5=0;
   Current_Candle_M15=0;
   Current_Candle_M30=0;
   Current_Candle_H1=0;
   Current_Candle_H4=0;
   Current_Candle_D1=0;
   Current_Candle_W1=0;
   Current_Candle_MN1=0;
   
   Current_Time_M1=0;
   Current_Time_M5=0;
   Current_Time_M15=0;
   Current_Time_M30=0;
   Current_Time_H1=0;
   Current_Time_H4=0;
   Current_Time_D1=0;
   Current_Time_W1=0;
   Current_Time_MN1=0;
   
   last_time=0;
   
   array_size=size;
   
   
   
   Use_M1=false;
   Use_M5=false;
   Use_M15=false;
   Use_M30=false;
   Use_H1=false;
   Use_H4=false;
   Use_D1=false;
   Use_W1=false;
   Use_MN1=false;
   
   ID = id;
   uchar char_id[];
   StringToCharArray(id,char_id);
   if(CharToString(char_id[0]) == "1"){Use_M1=true;}
   if(CharToString(char_id[1]) == "1"){Use_M5=true;}
   if(CharToString(char_id[2]) == "1"){Use_M15=true;}
   if(CharToString(char_id[3]) == "1"){Use_M30=true;}
   if(CharToString(char_id[4]) == "1"){Use_H1=true;}
   if(CharToString(char_id[5]) == "1"){Use_H4=true;}
   if(CharToString(char_id[6]) == "1"){Use_D1=true;}
   if(CharToString(char_id[7]) == "1"){Use_W1=true;}
   if(CharToString(char_id[8]) == "1"){Use_MN1=true;}
   
   resize(size);
   
}
void Aethas::resize(int size){
   
   if(Use_M1){
      ArrayResize(Open_M1,size);
      ArrayResize(Close_M1,size);
      ArrayResize(High_M1,size);
      ArrayResize(Low_M1,size);
      ArrayResize(Time_M1,size);
   }
   if(Use_M5){
      ArrayResize(Open_M5,size);
      ArrayResize(Close_M5,size);
      ArrayResize(High_M5,size);
      ArrayResize(Low_M5,size);
      ArrayResize(Time_M5,size);
   }
   if(Use_M15){
      ArrayResize(Open_M15,size);
      ArrayResize(Close_M15,size);
      ArrayResize(High_M15,size);
      ArrayResize(Low_M15,size);
      ArrayResize(Time_M15,size);
   }
   if(Use_M30){
      ArrayResize(Open_M30,size);
      ArrayResize(Close_M30,size);
      ArrayResize(High_M30,size);
      ArrayResize(Low_M30,size);
      ArrayResize(Time_M30,size);
   }
   if(Use_H1){
      ArrayResize(Open_H1,size);
      ArrayResize(Close_H1,size);
      ArrayResize(High_H1,size);
      ArrayResize(Low_H1,size);
      ArrayResize(Time_H1,size);
   }
   if(Use_H4){
      ArrayResize(Open_H4,size);
      ArrayResize(Close_H4,size);
      ArrayResize(High_H4,size);
      ArrayResize(Low_H4,size);
      ArrayResize(Time_H4,size);
   }
   if(Use_D1){
      ArrayResize(Open_D1,size);
      ArrayResize(Close_D1,size);
      ArrayResize(High_D1,size);
      ArrayResize(Low_D1,size);
      ArrayResize(Time_D1,size);
   }
   if(Use_W1){
      ArrayResize(Open_W1,size);
      ArrayResize(Close_W1,size);
      ArrayResize(High_W1,size);
      ArrayResize(Low_W1,size);
      ArrayResize(Time_W1,size);
   }
   if(Use_MN1){
      ArrayResize(Open_MN1,size);
      ArrayResize(Close_MN1,size);
      ArrayResize(High_MN1,size);
      ArrayResize(Low_MN1,size);
      ArrayResize(Time_MN1,size);
   }
}


void Aethas::inc_pointer(ENUM_TIMEFRAMES p){
   if(p == PERIOD_M1){
      Current_Candle_M1+=1;
      if(Current_Candle_M1>=array_size){
         Current_Candle_M1=0;
      }
      //Print(array_size,"|",Current_Candle_M1,"|",ArraySize(Time_M1));
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      Current_Time_M1 = StructToTime(str_time);
      
      Time_M1[Current_Candle_M1] = Current_Time_M1;
      Open_M1[Current_Candle_M1] = BID;
      Close_M1[Current_Candle_M1] = BID;
      High_M1[Current_Candle_M1] = BID;
      Low_M1[Current_Candle_M1] = BID;
   }
   if(p == PERIOD_M5){
      Current_Candle_M5+=1;
      if(Current_Candle_M5>=array_size){
         Current_Candle_M5=0;
      }
      
      //Print(array_size,"|",Current_Candle_M5,"|",ArraySize(Time_M5));
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = int(floor(str_time.min / 5)) * 5;
      Current_Time_M5 = StructToTime(str_time);
      
      Time_M5[Current_Candle_M5] = Current_Time_M5;
      Open_M5[Current_Candle_M5] = BID;
      Close_M5[Current_Candle_M5] = BID;
      High_M5[Current_Candle_M5] = BID;
      Low_M5[Current_Candle_M5] = BID;
   }
   if(p == PERIOD_M15){
      Current_Candle_M15+=1;
      if(Current_Candle_M15>=array_size){
         Current_Candle_M15=0;
      }
    /*  if(Current_Candle_M15!=0){
         Print("LastM15:",Time_M15[Current_Candle_M15-1],
                   "|O: ",Open_M15[Current_Candle_M15-1],
                   "|C: ",Close_M15[Current_Candle_M15-1],
                   "|H: ",High_M15[Current_Candle_M15-1],
                   "|L: ",Low_M15[Current_Candle_M15-1]);
      }*/
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = int(floor(str_time.min / 15)) * 15;
      Current_Time_M15 = StructToTime(str_time);
      
      Time_M15[Current_Candle_M15] = Current_Time_M15;
      Open_M15[Current_Candle_M15] = BID;
      Close_M15[Current_Candle_M15] = BID;
      High_M15[Current_Candle_M15] = BID;
      Low_M15[Current_Candle_M15] = BID;
   }   
   if(p == PERIOD_M30){
      Current_Candle_M30+=1;
      if(Current_Candle_M30>=array_size){
         Current_Candle_M30=0;
      }
      
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = int(floor(str_time.min / 30)) * 30;
      Current_Time_M30 = StructToTime(str_time);
      
      Time_M30[Current_Candle_M30] = Current_Time_M30;
      Open_M30[Current_Candle_M30] = BID;
      Close_M30[Current_Candle_M30] = BID;
      High_M30[Current_Candle_M30] = BID;
      Low_M30[Current_Candle_M30] = BID;
   }
   if(p == PERIOD_H1){
      Current_Candle_H1+=1;
      if(Current_Candle_H1>=array_size){
         Current_Candle_H1=0;
      }
      
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = 0;
      
      Current_Time_H1 = StructToTime(str_time);
      
      Time_H1[Current_Candle_H1] = Current_Time_H1;
      Open_H1[Current_Candle_H1] = BID;
      Close_H1[Current_Candle_H1] = BID;
      High_H1[Current_Candle_H1] = BID;
      Low_H1[Current_Candle_H1] = BID;
   }
   if(p == PERIOD_H4){
      Current_Candle_H4+=1;
      if(Current_Candle_H4>=array_size){
         Current_Candle_H4=0;
      }
      
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = 0;
      str_time.hour = (int(floor(str_time.hour / 4)) * 4) +1;
      Current_Time_H4 = StructToTime(str_time);
      
      Time_H4[Current_Candle_H4] = Current_Time_H4;
      Open_H4[Current_Candle_H4] = BID;
      Close_H4[Current_Candle_H4] = BID;
      High_H4[Current_Candle_H4] = BID;
      Low_H4[Current_Candle_H4] = BID;
   }
   if(p == PERIOD_D1){
      Current_Candle_D1+=1;
      if(Current_Candle_D1>=array_size){
         Current_Candle_D1=0;
      }
      
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = 0;
      str_time.hour = 0;
      Current_Time_D1 = StructToTime(str_time);
      
      Time_D1[Current_Candle_D1] = Current_Time_D1;
      Open_D1[Current_Candle_D1] = BID;
      Close_D1[Current_Candle_D1] = BID;
      High_D1[Current_Candle_D1] = BID;
      Low_D1[Current_Candle_D1] = BID;
   }
   if(p == PERIOD_W1){
      Current_Candle_W1+=1;
      if(Current_Candle_W1>=array_size){
         Current_Candle_W1=0;
      }
      
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = 0;
      str_time.hour = 0;
      str_time.day = str_time.day - str_time.day_of_week;
      Current_Time_W1 = StructToTime(str_time);
      
      Time_W1[Current_Candle_W1] = Current_Time_W1;
      Open_W1[Current_Candle_W1] = BID;
      Close_W1[Current_Candle_W1] = BID;
      High_W1[Current_Candle_W1] = BID;
      Low_W1[Current_Candle_W1] = BID;
   }
   if(p == PERIOD_MN1){
      Current_Candle_MN1+=1;
      if(Current_Candle_MN1>=array_size){
         Current_Candle_MN1=0;
      }
      
      MqlDateTime str_time; 
      
      TimeToStruct(TIME,str_time); 
      str_time.sec = 0;
      str_time.min = 0;
      str_time.hour = 0;
      str_time.day = 1;
      Current_Time_MN1 = StructToTime(str_time);
      
      Time_MN1[Current_Candle_MN1] = Current_Time_MN1;
      Open_MN1[Current_Candle_MN1] = BID;
      Close_MN1[Current_Candle_MN1] = BID;
      High_MN1[Current_Candle_MN1] = BID;
      Low_MN1[Current_Candle_MN1] = BID;
   }
}

int Aethas::check_pos(int cc,int pos){
   if(pos>cc){
      int delta = pos - cc;
      return(array_size - delta);
   }
   else{
      return(cc-pos);
   }
}

datetime Aethas::getTime(ENUM_TIMEFRAMES p,int pos){
   int currentcandle;
   datetime val = 0;
   if(p==PERIOD_M1){
      if(!Use_M1){Print("AETHAS Error|M1 not used 0");}
      else{
         currentcandle = Current_Candle_M1;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_M1[currentcandle];
      }
   }
   if(p==PERIOD_M5){
      if(!Use_M5){Print("AETHAS Error|M5 not used 0");}
      else{
         currentcandle = Current_Candle_M5;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_M5[currentcandle];
      }
   }
   if(p==PERIOD_M15){
      if(!Use_M15){Print("AETHAS Error|M15 not used 0");}
      else{
         currentcandle = Current_Candle_M15;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_M15[currentcandle];
      }
   }
   if(p==PERIOD_M30){
      if(!Use_M30){Print("AETHAS Error|M30 not used 0");}
      else{
         currentcandle = Current_Candle_M30;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_M30[currentcandle];
      }
   }
   if(p==PERIOD_H1){
      if(!Use_H1){Print("AETHAS Error|H1 not used 0");}
      else{
         currentcandle = Current_Candle_H1;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_H1[currentcandle];
      }
   }
   if(p==PERIOD_H4){
      if(!Use_H4){Print("AETHAS Error|H4 not used 0");}
      else{
         currentcandle = Current_Candle_H4;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_H4[currentcandle];
      }
   }
   if(p==PERIOD_D1){
      if(!Use_D1){Print("AETHAS Error|D1 not used 0");}
      else{
         currentcandle = Current_Candle_D1;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_D1[currentcandle];
      }
   }
   if(p==PERIOD_W1){
      if(!Use_W1){Print("AETHAS Error|W1 not used 0");}
      else{
         currentcandle = Current_Candle_W1;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_W1[currentcandle];
      }
   }
   if(p==PERIOD_MN1){
      if(!Use_MN1){Print("AETHAS Error|MN1 not used 0");}
      else{
         currentcandle = Current_Candle_MN1;
         currentcandle = check_pos(currentcandle,pos);
         val = Time_MN1[currentcandle];
      }
   }
   return(val);
}


double Aethas::getOpen(ENUM_TIMEFRAMES p,int pos){
   int currentcandle;
   double val = 0;
   if(p==PERIOD_M1){
      if(!Use_M1){Print("AETHAS Error|M1 not used 1");}
      else{
         currentcandle = Current_Candle_M1;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_M1[currentcandle];
      }
   }
   if(p==PERIOD_M5){
      if(!Use_M5){Print("AETHAS Error|M5 not used 1");}
      else{
         currentcandle = Current_Candle_M5;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_M5[currentcandle];
      }
   }
   if(p==PERIOD_M15){
      if(!Use_M15){Print("AETHAS Error|M15 not used 1");}
      else{
         currentcandle = Current_Candle_M15;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_M15[currentcandle];
      }
   }
   if(p==PERIOD_M30){
      if(!Use_M30){Print("AETHAS Error|M30 not used 1");}
      else{
         currentcandle = Current_Candle_M30;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_M30[currentcandle];
      }
   }
   if(p==PERIOD_H1){
      if(!Use_H1){Print("AETHAS Error|H1 not used 1");}
      else{
         currentcandle = Current_Candle_H1;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_H1[currentcandle];
      }
   }
   if(p==PERIOD_H4){
      if(!Use_H4){Print("AETHAS Error|H4 not used 1");}
      else{
         currentcandle = Current_Candle_H4;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_H4[currentcandle];
      }
   }
   if(p==PERIOD_D1){
      if(!Use_D1){Print("AETHAS Error|D1 not used 1");}
      else{
         currentcandle = Current_Candle_D1;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_D1[currentcandle];
      }
   }
   if(p==PERIOD_W1){
      if(!Use_W1){Print("AETHAS Error|W1 not used 1");}
      else{
         currentcandle = Current_Candle_W1;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_W1[currentcandle];
      }
   }
   if(p==PERIOD_MN1){
      if(!Use_MN1){Print("AETHAS Error|MN1 not used 1");}
      else{
         currentcandle = Current_Candle_MN1;
         currentcandle = check_pos(currentcandle,pos);
         val = Open_MN1[currentcandle];
      }
   }
   return(val);
}

double Aethas::getClose(ENUM_TIMEFRAMES p,int pos){
   int currentcandle;
   double val = 0;
   if(p==PERIOD_M1){
      if(!Use_M1){Print("AETHAS Error|M1 not used 2");}
      else{
         currentcandle = Current_Candle_M1;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_M1[currentcandle];
      }
   }
   if(p==PERIOD_M5){
      if(!Use_M5){Print("AETHAS Error|M5 not used 2");}
      else{
         currentcandle = Current_Candle_M5;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_M5[currentcandle];
      }
   }
   if(p==PERIOD_M15){
      if(!Use_M15){Print("AETHAS Error|M15 not used 2");}
      else{
         currentcandle = Current_Candle_M15;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_M15[currentcandle];
      }
   }
   if(p==PERIOD_M30){
      if(!Use_M30){Print("AETHAS Error|M30 not used 2");}
      else{
         currentcandle = Current_Candle_M30;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_M30[currentcandle];
      }
   }
   if(p==PERIOD_H1){
      if(!Use_H1){Print("AETHAS Error|H1 not used 2");}
      else{
         currentcandle = Current_Candle_H1;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_H1[currentcandle];
      }
   }
   if(p==PERIOD_H4){
      if(!Use_H4){Print("AETHAS Error|H4 not used 2");}
      else{
         currentcandle = Current_Candle_H4;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_H4[currentcandle];
      }
   }
   if(p==PERIOD_D1){
      if(!Use_D1){Print("AETHAS Error|D1 not used 2");}
      else{
         currentcandle = Current_Candle_D1;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_D1[currentcandle];
      }
   }
   if(p==PERIOD_W1){
      if(!Use_W1){Print("AETHAS Error|W1 not used 2");}
      else{
         currentcandle = Current_Candle_W1;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_W1[currentcandle];
      }
   }
   if(p==PERIOD_MN1){
      if(!Use_MN1){Print("AETHAS Error|MN1 not used 2");}
      else{
         currentcandle = Current_Candle_MN1;
         currentcandle = check_pos(currentcandle,pos);
         val = Close_MN1[currentcandle];
      }
   }
   return(val);
}
double Aethas::getHigh(ENUM_TIMEFRAMES p,int pos){
   int currentcandle;
   double val=0;
   if(p==PERIOD_M1){
      if(!Use_M1){Print("AETHAS Error|M1 not used 3");}
      else{
         currentcandle = Current_Candle_M1;
         currentcandle = check_pos(currentcandle,pos);
         val = High_M1[currentcandle];
      }
   }
   if(p==PERIOD_M5){
      if(!Use_M5){Print("AETHAS Error|M5 not used 3");}
      else{
         currentcandle = Current_Candle_M5;
         currentcandle = check_pos(currentcandle,pos);
         val = High_M5[currentcandle];
      }
   }
   if(p==PERIOD_M15){
      if(!Use_M15){Print("AETHAS Error|M15 not used 3");}
      else{
         currentcandle = Current_Candle_M15;
         currentcandle = check_pos(currentcandle,pos);
         val = High_M15[currentcandle];
      }
   }
   if(p==PERIOD_M30){
      if(!Use_M30){Print("AETHAS Error|M30 not used 3");}
      else{
         currentcandle = Current_Candle_M30;
         currentcandle = check_pos(currentcandle,pos);
         val = High_M30[currentcandle];
      }
   }
   if(p==PERIOD_H1){
      if(!Use_H1){Print("AETHAS Error|H1 not used 3");}
      else{
         currentcandle = Current_Candle_H1;
         currentcandle = check_pos(currentcandle,pos);
         val = High_H1[currentcandle];
      }
   }
   if(p==PERIOD_H4){
      if(!Use_H4){Print("AETHAS Error|H4 not used 3");}
      else{
         currentcandle = Current_Candle_H4;
         currentcandle = check_pos(currentcandle,pos);
         val = High_H4[currentcandle];
      }
   }
   if(p==PERIOD_D1){
      if(!Use_D1){Print("AETHAS Error|D1 not used 3");}
      else{
         currentcandle = Current_Candle_D1;
         currentcandle = check_pos(currentcandle,pos);
         val = High_D1[currentcandle];
      }
   }
   if(p==PERIOD_W1){
      if(!Use_W1){Print("AETHAS Error|W1 not used 3");}
      else{
         currentcandle = Current_Candle_W1;
         currentcandle = check_pos(currentcandle,pos);
         val = High_W1[currentcandle];
      }
   }
   if(p==PERIOD_MN1){
      if(!Use_MN1){Print("AETHAS Error|MN1 not used 3");}
      else{
         currentcandle = Current_Candle_MN1;
         currentcandle = check_pos(currentcandle,pos);
         val = High_MN1[currentcandle];
      }
   }
   return(val);
}

double Aethas::getLow(ENUM_TIMEFRAMES p,int pos){
   int currentcandle;
   double val=0;
   if(p==PERIOD_M1){
      if(!Use_M1){Print("AETHAS Error|M1 not used 4");}
      else{
         currentcandle = Current_Candle_M1;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_M1[currentcandle];
      }
   }
   if(p==PERIOD_M5){
      if(!Use_M5){Print("AETHAS Error|M5 not used 4");}
      else{
         currentcandle = Current_Candle_M5;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_M5[currentcandle];
      }
   }
   if(p==PERIOD_M15){
      if(!Use_M15){Print("AETHAS Error|M15 not used 4");}
      else{
         currentcandle = Current_Candle_M15;
         currentcandle = check_pos(currentcandle,pos);
   
         val = Low_M15[currentcandle];
      }
   }
   if(p==PERIOD_M30){
      if(!Use_M30){Print("AETHAS Error|M30 not used 4");}
      else{
         currentcandle = Current_Candle_M30;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_M30[currentcandle];
      }
   }
   if(p==PERIOD_H1){
      if(!Use_H1){Print("AETHAS Error|H1 not used 4");}
      else{
         currentcandle = Current_Candle_H1;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_H1[currentcandle];
      }
   }
   if(p==PERIOD_H4){
      if(!Use_H4){Print("AETHAS Error|H4 not used 4");}
      else{
         currentcandle = Current_Candle_H4;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_H4[currentcandle];
      }
   }
   if(p==PERIOD_D1){
      if(!Use_D1){Print("AETHAS Error|D1 not used 4");}
      else{
         currentcandle = Current_Candle_D1;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_D1[currentcandle];
      }
   }
   if(p==PERIOD_W1){
      if(!Use_W1){Print("AETHAS Error|W1 not used 4");}
      else{
         currentcandle = Current_Candle_W1;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_W1[currentcandle];
      }
   }
   if(p==PERIOD_MN1){
      if(!Use_MN1){Print("AETHAS Error|MN1 not used 4");}
      else{
         currentcandle = Current_Candle_MN1;
         currentcandle = check_pos(currentcandle,pos);
         val = Low_MN1[currentcandle];
      }
   }
   
   return(val);
}

int Aethas::getCurrentCandle(ENUM_TIMEFRAMES p){
   if(p==PERIOD_M1){
      if(!Use_M1){Print("AETHAS Error|M1 not used 5");}
      else{
         return(Current_Candle_M1);
      }
   }
   if(p==PERIOD_M5){
      if(!Use_M5){Print("AETHAS Error|M5 not used 5");}
      else{
         return(Current_Candle_M5);
      }
   }
   if(p==PERIOD_M15){
      if(!Use_M15){Print("AETHAS Error|M15 not used 5");}
      else{
         return(Current_Candle_M15);
      }
   }
   if(p==PERIOD_M30){
      if(!Use_M30){Print("AETHAS Error|M30 not used 5");}
      else{
         return(Current_Candle_M30);
      }
   }
   if(p==PERIOD_H1){
      if(!Use_H1){Print("AETHAS Error|H1 not used 5");}
      else{
         return(Current_Candle_H1);
      }
   }
   if(p==PERIOD_H4){
      if(!Use_H4){Print("AETHAS Error|H4 not used 5");}
      else{
         return(Current_Candle_H4);
      }
   }
   if(p==PERIOD_D1){
      if(!Use_D1){Print("AETHAS Error|D1 not used 5");}
      else{
         return(Current_Candle_D1);
      }
   }
   if(p==PERIOD_W1){
      if(!Use_W1){Print("AETHAS Error|W1 not used 5");}
      else{
         return(Current_Candle_W1);
      }
   }
   if(p==PERIOD_MN1){
      if(!Use_MN1){Print("AETHAS Error|MN1 not used 5");}
      else{
         return(Current_Candle_MN1);
      }
   }
   return(0);
}