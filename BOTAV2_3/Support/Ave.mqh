//+------------------------------------------------------------------+
//|                                                          Ave.mqh |
//|                                        Copyright 2022, HEISL INC.|
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/Support/Aethas.mqh>
#include <BOTAV2_3/MISC/CANDLE.mqh>
#include <BOTAV2_3/GUI/BotA_GUI.mqh>

class Ave{

   private:
      
      string Name;
      ENUM_TIMEFRAMES P;
      
      string ID;
      
      bool Use_M1;
      bool Use_M5;
      bool Use_M15;
      bool Use_M30;
      bool Use_H1;
      bool Use_H4;
      bool Use_D1;
      bool Use_W1;
      bool Use_MN1;
      
      int last_min;
      
      double AveSpread[][30];   
      double Spread;   
      int AveSpread_MinPointer;      
      int AveSpread_Pointer;   
      int AS_iMax;
      
      double bid_array[];
      double ask_array[];
      datetime time_array[];
      
      int pointer;
      int arraySize;
      //int timetarget[];
      double PenaltyFactor[];
      
      //bool BuyPenalty[];
      //bool SellPenalty[];
      datetime BuyPenalty_Time[];
      datetime SellPenalty_Time[];
      
      bool full_array;
      
      double AveAsk;
      double AveBid;
      double AveTime;
      
      Aethas this_Aethas;
      
      
      
      double CandleSize;
      
      Candle Candle_M1[];
      Candle Candle_M5[];
      Candle Candle_M15[];
      Candle Candle_M30[];
      Candle Candle_H1[];
      Candle Candle_H4[];
      Candle Candle_D1[];
      Candle Candle_W1[];
      Candle Candle_MN1[];
      
      int Current_Candle_M1;
      int Current_Candle_M5;
      int Current_Candle_M15;
      int Current_Candle_M30;
      int Current_Candle_H1;
      int Current_Candle_H4;
      int Current_Candle_D1;
      int Current_Candle_W1;
      int Current_Candle_MN1;
      
      int Last_Candle_M1;
      int Last_Candle_M5;
      int Last_Candle_M15;
      int Last_Candle_M30;
      int Last_Candle_H1;
      int Last_Candle_H4;
      int Last_Candle_D1;
      int Last_Candle_W1;
      int Last_Candle_MN1;
      
      double AveCandle_M1;
      double AveCandle_M5;
      double AveCandle_M15;
      double AveCandle_M30;
      double AveCandle_H1;
      double AveCandle_H4;
      double AveCandle_D1;
      double AveCandle_W1;
      double AveCandle_MN1;
      
      int Candle_arraySize;
      
      //Bota_GUI *GUI;
      
  public:
  
      Ave(string new_Name,ENUM_TIMEFRAMES new_P, int candle_arraysize,string id);
      Ave(void);
      ~Ave(void);
      
      void tick(datetime time,double ask,double bid);
      
      void calcCandles();
      void calcPenalty(); 
      void calcSpread();
      void calcAveCandle(ENUM_TIMEFRAMES this_P);
      
      double getCandle(ENUM_TIMEFRAMES this_P);
      datetime get_BuyPenalty_Time(int pos);
      datetime get_SellPenalty_Time(int pos);
      double get_Spread();
      double get_AveBid();
      double get_AveAsk();
      double get_AveTime();
      
      
      void resize_candleArray();
};      

void Ave::Ave(){
   AveSpread_MinPointer = 0;
   AveSpread_Pointer = 0;
   Spread = 0;
   AS_iMax = 0;
   //CandleSize = 0;
   last_min = 0;
   
   arraySize=50;
   
   //timetarget = 60*60;
   
   //PenaltyFactor=30;
   

   ArrayResize(bid_array,arraySize);
   ArrayResize(ask_array,arraySize);
   ArrayResize(time_array,arraySize);
   
   pointer = 0;
   
   full_array=false;
   
   ArrayResize(BuyPenalty_Time,10);
   ArrayResize(SellPenalty_Time,10);
   ArrayResize(PenaltyFactor,10);
   for(int i=0;i<10;i++){
      PenaltyFactor[i] = 6+6*i;   
   }
   
   //BuyPenalty = true;
   //SellPenalty = true;
   
   //BuyPenalty_Time = 0;
   //SellPenalty_Time = 0;
   
   
   Candle_arraySize = 30;
   resize_candleArray();
}

void Ave::Ave(string new_Name,ENUM_TIMEFRAMES new_P, int candle_arraysize,string id){
   Name = new_Name;
   P=new_P;
   
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
   
   
   AveSpread_MinPointer = 0;
   AveSpread_Pointer = 0;
   Spread = 0;
   AS_iMax = 0;
   //CandleSize = 0;
   last_min = 0;
   
   arraySize=50;
   
   //timetarget = 60*60;
   
   //PenaltyFactor=30;
   
   ArrayResize(bid_array,arraySize);
   ArrayResize(ask_array,arraySize);
   ArrayResize(time_array,arraySize);
   
   pointer = 0;
   
   full_array=false;
   
   ArrayResize(BuyPenalty_Time,10);
   ArrayResize(SellPenalty_Time,10);
   ArrayResize(PenaltyFactor,10);
   for(int i=0;i<10;i++){
      PenaltyFactor[i] = 6+6*i;   
   }
   /*BuyPenalty = true;
   SellPenalty = true;
   
   BuyPenalty_Time = 0;
   SellPenalty_Time = 0;*/
   
   Candle_arraySize = candle_arraysize;
   resize_candleArray();
}

void Ave::~Ave(){
   
   ArrayFree(Candle_M1); 
   ArrayFree(Candle_M5); 
   ArrayFree(Candle_M15); 
   ArrayFree(Candle_M30); 
   ArrayFree(Candle_H1); 
   ArrayFree(Candle_H4); 
   ArrayFree(Candle_D1); 
   ArrayFree(Candle_W1); 
   ArrayFree(Candle_MN1); 
   ArrayFree(AveSpread);   
   ArrayFree(bid_array); 
   ArrayFree(ask_array); 
   ArrayFree(time_array); 
}

datetime Ave::get_BuyPenalty_Time(int pos){return(BuyPenalty_Time[pos]);}
datetime Ave::get_SellPenalty_Time(int pos){return(SellPenalty_Time[pos]);}
double Ave::get_Spread(){return(Spread);}
double Ave::get_AveBid(){return(AveBid);}
double Ave::get_AveTime(){return(AveTime);}
double Ave::get_AveAsk(){return(AveAsk);}

void Ave::tick(datetime time,double ask,double bid){   
   pointer+=1;
   if(pointer == arraySize){
      pointer=0;
      full_array=true;
   }
   
   ask_array[pointer] = ask;
   bid_array[pointer] = bid;
   time_array[pointer] = time;
   
   calcPenalty();
   calcSpread();

   
   calcCandles();
   //string status = string(AveCandle_M1)+"|"+string(AveCandle_M5)+"|"+string(AveCandle_M15)+"|"+string(AveCandle_M30)+"|"+string(AveCandle_H1)+"|"+string(AveCandle_H4)+"||"+string(Spread)+"||"+string(AveBid)+"||"+string(AveAsk);
   //GUI.setPanel(status);
}
void Ave::calcCandles(){ 
   if(Use_M1){
      if(Last_Candle_M1 != this_Aethas.get_Current_Candle_M1()){
         Last_Candle_M1 = this_Aethas.get_Current_Candle_M1();
         
         Current_Candle_M1+=1;
         if(Current_Candle_M1>=Candle_arraySize){
            Current_Candle_M1=0;
         }
         Candle_M1[Current_Candle_M1].setCandle(this_Aethas.getHigh(PERIOD_M1,1),this_Aethas.getLow(PERIOD_M1,1),this_Aethas.getOpen(PERIOD_M1,1),this_Aethas.getClose(PERIOD_M1,1),this_Aethas.getTime(PERIOD_M1,1));
         calcAveCandle(PERIOD_M1);
         
      }
   }
   if(Use_M5){
      if(Last_Candle_M5 != this_Aethas.get_Current_Candle_M5()){
         Last_Candle_M5 = this_Aethas.get_Current_Candle_M5();
         
         Current_Candle_M5+=1;
         if(Current_Candle_M5>=Candle_arraySize){
            Current_Candle_M5=0;
         }
         Candle_M5[Current_Candle_M5].setCandle(this_Aethas.getHigh(PERIOD_M5,1),this_Aethas.getLow(PERIOD_M5,1),this_Aethas.getOpen(PERIOD_M5,1),this_Aethas.getClose(PERIOD_M5,1),this_Aethas.getTime(PERIOD_M5,1));
         calcAveCandle(PERIOD_M5);
      }
   }
   if(Use_M5){
      if(Last_Candle_M15 != this_Aethas.get_Current_Candle_M15()){
         Last_Candle_M15 = this_Aethas.get_Current_Candle_M15();
         
         Current_Candle_M15+=1;
         if(Current_Candle_M15>=Candle_arraySize){
            Current_Candle_M15=0;
         }
         Candle_M15[Current_Candle_M15].setCandle(this_Aethas.getHigh(PERIOD_M15,1),this_Aethas.getLow(PERIOD_M15,1),this_Aethas.getOpen(PERIOD_M15,1),this_Aethas.getClose(PERIOD_M15,1),this_Aethas.getTime(PERIOD_M15,1));
         
         calcAveCandle(PERIOD_M15);
      }
   }
   if(Use_M30){
      if(Last_Candle_M30 != this_Aethas.get_Current_Candle_M30()){
         Last_Candle_M30 = this_Aethas.get_Current_Candle_M30();
         
         Current_Candle_M30+=1;
         if(Current_Candle_M30>=Candle_arraySize){
            Current_Candle_M30=0;
         }
         
         Candle_M30[Current_Candle_M30].setCandle(this_Aethas.getHigh(PERIOD_M30,1),this_Aethas.getLow(PERIOD_M30,1),this_Aethas.getOpen(PERIOD_M30,1),this_Aethas.getClose(PERIOD_M30,1),this_Aethas.getTime(PERIOD_M30,1));
         calcAveCandle(PERIOD_M30);
      }
   }
   if(Use_H1){
      if(Last_Candle_H1 != this_Aethas.get_Current_Candle_H1()){
         Last_Candle_H1 = this_Aethas.get_Current_Candle_H1();
         
         Current_Candle_H1+=1;
         if(Current_Candle_H1>=Candle_arraySize){
            Current_Candle_H1=0;
         }
         Candle_H1[Current_Candle_H1].setCandle(this_Aethas.getHigh(PERIOD_H1,1),this_Aethas.getLow(PERIOD_H1,1),this_Aethas.getOpen(PERIOD_H1,1),this_Aethas.getClose(PERIOD_H1,1),this_Aethas.getTime(PERIOD_H1,1));
         
         calcAveCandle(PERIOD_H1);
      }
   }
   if(Use_H4){
      if(Last_Candle_H4 != this_Aethas.get_Current_Candle_H4()){
         Last_Candle_H4 = this_Aethas.get_Current_Candle_H4();
         
         Current_Candle_H4+=1;
         if(Current_Candle_H4>=Candle_arraySize){
            Current_Candle_H4=0;
         }
         Candle_H4[Current_Candle_M1].setCandle(this_Aethas.getHigh(PERIOD_H4,1),this_Aethas.getLow(PERIOD_H4,1),this_Aethas.getOpen(PERIOD_H4,1),this_Aethas.getClose(PERIOD_H4,1),this_Aethas.getTime(PERIOD_H4,1));
         
         calcAveCandle(PERIOD_H4);
      }
   }
   if(Use_D1){
      if(Last_Candle_D1 != this_Aethas.get_Current_Candle_D1()){
         Last_Candle_D1 = this_Aethas.get_Current_Candle_D1();
         
         Current_Candle_D1+=1;
         if(Current_Candle_D1>=Candle_arraySize){
            Current_Candle_D1=0;
         }
         Candle_D1[Current_Candle_D1].setCandle(this_Aethas.getHigh(PERIOD_D1,1),this_Aethas.getLow(PERIOD_D1,1),this_Aethas.getOpen(PERIOD_D1,1),this_Aethas.getClose(PERIOD_D1,1),this_Aethas.getTime(PERIOD_D1,1));
         
         calcAveCandle(PERIOD_D1);
      }
   }
   if(Use_W1){
      if(Last_Candle_W1 != this_Aethas.get_Current_Candle_W1()){
         Last_Candle_W1 = this_Aethas.get_Current_Candle_W1();
         
         Current_Candle_W1+=1;
         if(Current_Candle_W1>=Candle_arraySize){
            Current_Candle_W1=0;
         }
         Candle_W1[Current_Candle_W1].setCandle(this_Aethas.getHigh(PERIOD_W1,1),this_Aethas.getLow(PERIOD_W1,1),this_Aethas.getOpen(PERIOD_W1,1),this_Aethas.getClose(PERIOD_W1,1),this_Aethas.getTime(PERIOD_W1,1));
   
         calcAveCandle(PERIOD_W1);
      }
   }
   if(Use_MN1){
      if(Last_Candle_MN1 != this_Aethas.get_Current_Candle_MN1()){
         Last_Candle_MN1 = this_Aethas.get_Current_Candle_MN1();
         
         Current_Candle_MN1+=1;
         if(Current_Candle_MN1>=Candle_arraySize){
            Current_Candle_MN1=0;
         }
         Candle_MN1[Current_Candle_MN1].setCandle(this_Aethas.getHigh(PERIOD_MN1,1),this_Aethas.getLow(PERIOD_MN1,1),this_Aethas.getOpen(PERIOD_MN1,1),this_Aethas.getClose(PERIOD_MN1,1),this_Aethas.getTime(PERIOD_MN1,1));
         
         calcAveCandle(PERIOD_MN1);
      }
   }
}
void Ave::calcPenalty(){ 
   if(full_array){
      double bid_delta[];
      double abs_bid_delta[];
      ArrayResize(bid_delta,arraySize);
      ArrayResize(abs_bid_delta,arraySize);
      double bid_sum =0;
      int divider=0;
      for(int i=0;i<ArraySize(bid_array);i++){
         double val1;
         double val2;
         
         if(pointer-i<0){
            int delta = i-pointer;
            val1 = bid_array[arraySize-delta];
         }
         else{
            val1 = bid_array[pointer-i];
         }
         if((pointer-1)-i<0){
            int delta = i-(pointer-1);
            val2 = bid_array[arraySize-delta];
         }
         else{
            val2 = bid_array[(pointer-1)-i];
         }
         
         bid_delta[i] = val1-val2;
         abs_bid_delta[i] = MathAbs(bid_delta[i]);
         if(i>0 && abs_bid_delta[i]>0){
            bid_sum +=abs_bid_delta[i];
            divider +=1;
         }
      }
      if(divider>0){
         AveBid = bid_sum/divider;
      }
      else{
         AveBid=0;
      }
      
      double ask_delta[];
      double abs_ask_delta[];
      ArrayResize(ask_delta,arraySize);
      ArrayResize(abs_ask_delta,arraySize);
      double ask_sum =0;
      divider=0;
      for(int i=0;i<ArraySize(ask_array);i++){
         double val1;
         double val2;
         if(pointer-i<0){
            int delta = i-pointer;
            val1 = ask_array[arraySize-delta];
         }
         else{
            val1 = ask_array[pointer-i];
         }
         if((pointer-1)-i<0){
            int delta = i-(pointer-1);
            val2 = ask_array[arraySize-delta];
         }
         else{
            val2 = ask_array[(pointer-1)-i];
         }
         ask_delta[i] = val1-val2;
         abs_ask_delta[i] = MathAbs(ask_delta[i]);
         if(i>0 && abs_ask_delta[i]>0){
            ask_sum +=abs_ask_delta[i];
            divider+=1;
         }
      }
      if(divider>0){
         AveAsk = ask_sum/divider;
      }
      else{
         AveAsk=0;
      }
      int time_delta[];
      ArrayResize(time_delta,arraySize);
      double time_sum =0;
      divider=0;
      for(int i=0;i<ArraySize(time_array);i++){
         datetime val1;
         datetime val2;
         if(pointer-i<0){
            int delta = i-pointer;
            val1 = time_array[arraySize-delta];
         }
         else{
            val1 = time_array[pointer-i];
         }
         if((pointer-1)-i<0){
            int delta = i-(pointer-1);
            val2 = time_array[arraySize-delta];
         }
         else{
            val2 = time_array[(pointer-1)-i];
         }
         time_delta[i] = int(val1)-int(val2);
         if(i>0 && time_delta[i]>0){
            time_sum +=time_delta[i];
            divider+=1;
         }
      }
      if(divider>0){
         AveTime = time_sum/divider;
      }
      else{
         AveTime=0;
      }
      for(int i =0;i<ArraySize(PenaltyFactor);i++){
         if(time_delta[0]>AveTime*(PenaltyFactor[i]*1000)){
            //BuyPenalty=True;
            //SellPenalty=True;
            BuyPenalty_Time[i] = time_array[pointer];
            SellPenalty_Time[i] = time_array[pointer];
            
            ArrayFree(bid_array);
            ArrayFree(ask_array);
            ArrayFree(time_array);
            
            ArrayResize(bid_array,arraySize);
            ArrayResize(ask_array,arraySize);
            ArrayResize(time_array,arraySize);
            
            pointer = 0;
            
            full_array=false;
            
         }
         else{
            if(abs_bid_delta[0]>AveBid*PenaltyFactor[i]){
               if(bid_delta[0]<0){  
                  //BuyPenalty = True;
                  BuyPenalty_Time[i] = time_array[pointer];
                  
               }
               else{
                  //SellPenalty = True;
                  SellPenalty_Time[i] = time_array[pointer];
               }
            }
         }
         /*else{
            if(BuyPenalty){
               if((time_array[pointer]-BuyPenalty_Time) > timetarget){
                  BuyPenalty=false;
               }
            }
            if(SellPenalty){
               if((time_array[pointer]-SellPenalty_Time) > timetarget){
                  SellPenalty=false;
               }
            }
         }*/
      }
   }
   //-----------------GUI----------------
   /*if(!SIMULATION){
      if(SellPenalty && BuyPenalty){
         GUI.AVE_GUI.setPanel("BOTH");
      }
      else{
         if(SellPenalty){
            GUI.AVE_GUI.setPanel("SELL");
         }
         else{
            if(BuyPenalty){
               GUI.AVE_GUI.setPanel("BUY");
            }
            else{
               GUI.AVE_GUI.setPanel("OK");
            }
         }
      }
   }*/
}
void Ave::calcSpread(){
   MqlDateTime struct_time;
   TimeToStruct(time_array[pointer],struct_time);   
   
   if(struct_time.min!=last_min){
      //New Minute
      AveSpread_MinPointer+=1;
      if(AveSpread_MinPointer>=30){
         AveSpread_MinPointer=0;
      }
      for(int i=0;i<AS_iMax;i++){
         AveSpread[i][AveSpread_MinPointer] = 0;
         AveSpread_Pointer = 0;
      }
   }
   last_min = struct_time.min;
   
   if(AS_iMax<=AveSpread_Pointer){
      ArrayResize(AveSpread,AveSpread_Pointer+1);
      for(int j=0;j<30;j++){
         AveSpread[AveSpread_Pointer][j] = 0;
      }
      AS_iMax = AveSpread_Pointer+1;
   }
   AveSpread[AveSpread_Pointer][AveSpread_MinPointer] = ask_array[pointer] - bid_array[pointer];
   AveSpread_Pointer+=1;
   
   int help_count =0;
   
   for(int i=0;i<AS_iMax;i++){
      for(int j=0;j<30;j++){
         if(AveSpread[i][j]!=0){
            help_count+=1;
            Spread += AveSpread[i][j];
         }
      }
   }
   if(help_count!=0){
      Spread = Spread/help_count;
   }
   else{
      Spread=0;
   }
}

void Ave::calcAveCandle(ENUM_TIMEFRAMES this_P){
   if(this_P == PERIOD_M1){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_M1[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_M1[i].get_High() - Candle_M1[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_M1 = body_sum/i;
  }
  else if(this_P == PERIOD_M5){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_M5[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_M5[i].get_High() - Candle_M5[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_M5 = body_sum/i;
  }
  else if(this_P == PERIOD_M15){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_M15[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_M15[i].get_High() - Candle_M15[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_M15 = body_sum/i;
  }
  else if(this_P == PERIOD_M30){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_M30[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_M30[i].get_High() - Candle_M30[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_M30 = body_sum/i;
  }
  else if(this_P == PERIOD_H1){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_H1[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_H1[i].get_High() - Candle_H1[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_H1 = body_sum/i;
  }
  else if(this_P == PERIOD_H4){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_H4[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_H4[i].get_High() - Candle_H4[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_H4 = body_sum/i;
  }
  else if(this_P == PERIOD_D1){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_D1[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_D1[i].get_High() - Candle_D1[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_D1 = body_sum/i;
  }
  else if(this_P == PERIOD_W1){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_W1[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_W1[i].get_High() - Candle_W1[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_W1 = body_sum/i;
  }
  else if(this_P == PERIOD_MN1){
      double body_sum = 0;
      int i =0;
      for(i=0;i<Candle_arraySize;i++){
         if(Candle_MN1[i].get_High()==0){
            break;
         }
         else{
            double delta = Candle_MN1[i].get_High() - Candle_MN1[i].get_Low();
            body_sum += delta;
         }
      }
      AveCandle_MN1 = body_sum/i;
  }
}

double Ave::getCandle(ENUM_TIMEFRAMES this_P){
   if(this_P == PERIOD_M1){
      return(AveCandle_M1);
   }
   if(this_P == PERIOD_M5){
      return(AveCandle_M5);
   }
   if(this_P == PERIOD_M15){
      return(AveCandle_M15);
   }
   if(this_P == PERIOD_M30){
      return(AveCandle_M30);
   }
   if(this_P == PERIOD_H1){
      return(AveCandle_H1);
   }
   if(this_P == PERIOD_H4){
      return(AveCandle_H4);
   }
   if(this_P == PERIOD_D1){
      return(AveCandle_D1);
   }
   if(this_P == PERIOD_W1){
      return(AveCandle_W1);
   }
   if(this_P == PERIOD_MN1){
      return(AveCandle_MN1);
   }
   return(0);
}

void Ave::resize_candleArray(void){
   ArrayResize(Candle_M1,Candle_arraySize);
   ArrayResize(Candle_M5,Candle_arraySize);
   ArrayResize(Candle_M15,Candle_arraySize);
   ArrayResize(Candle_M30,Candle_arraySize);
   ArrayResize(Candle_H1,Candle_arraySize);
   ArrayResize(Candle_H4,Candle_arraySize);
   ArrayResize(Candle_D1,Candle_arraySize);
   ArrayResize(Candle_W1,Candle_arraySize);
   ArrayResize(Candle_MN1,Candle_arraySize);
   
   Current_Candle_M1 = 0;
   Current_Candle_M5 = 0;
   Current_Candle_M15 = 0;
   Current_Candle_M30 = 0;
   Current_Candle_H1 = 0;
   Current_Candle_H4 = 0;
   Current_Candle_D1 = 0;
   Current_Candle_W1 = 0;
   Current_Candle_MN1 = 0;
   
        
   Last_Candle_M1 = 0;
   Last_Candle_M5 = 0;
   Last_Candle_M15 = 0;
   Last_Candle_M30 = 0;
   Last_Candle_H1 = 0;
   Last_Candle_H4 = 0;
   Last_Candle_D1 = 0;
   Last_Candle_W1 = 0;
   Last_Candle_MN1 = 0;
   
   AveCandle_M1 = 0;
   AveCandle_M5 = 0;
   AveCandle_M15 = 0;
   AveCandle_M30 = 0;
   AveCandle_H1 = 0;
   AveCandle_H4 = 0;
   AveCandle_D1 = 0;
   AveCandle_W1 = 0;
   AveCandle_MN1 = 0;
}