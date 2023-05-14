//+------------------------------------------------------------------+
//|                                                       TI_TSL.mqh |
//|                                       Copyright 2022, Heisl INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"

#property strict

#include <BOTAV2_3/Support/Aethas.mqh>
#include <BOTAV2_3/MISC/Order.mqh>

class TI_TSL{

   private:
      string name;
      ENUM_TIMEFRAMES P;

      int TSL_CandleCount;
      double WLB_percent;
      double TP_Factor;
      double TSL_Bonus;
      
      datetime TIME;
      double ASK;
      double BID;
      
      Aethas *this_Aethas;
      
      bool clear_ExcuseTime;
      bool fill_ExcuseTime;
      
      Order *BUY_order[];
      Order *SELL_order[];

      int candle_pos;
      
      int Percent_Save;
   
   public:
      void tick(datetime time,double ask,double bid);
   
      TI_TSL(void);
      TI_TSL(string new_name,ENUM_TIMEFRAMES new_p,int new_tslcc,double new_wlbpercent,double new_tpfactor,double new_tslbonus,bool new_clearet,bool new_fillet,int p_save);
      ~TI_TSL(void);
 
      void Jungle_trigger(Order *this_order,bool fed);
      void SL_Tailing(Order *this_order);
      
      void set_ASK(double new_val);
      void set_BID(double new_val);
      void set_TIME(datetime new_val);
      void set_Aethas(Aethas *new_aethas);
      
      double get_TP_Factor();
};

void TI_TSL::TI_TSL(){
   ArrayResize(BUY_order,0);
   ArrayResize(SELL_order,0);
   clear_ExcuseTime =false;
   fill_ExcuseTime= false;
   candle_pos=-1;
   
   this_Aethas =& Aethas_BOT;
}
void TI_TSL::TI_TSL(string new_name,ENUM_TIMEFRAMES new_p,int new_tslcc,double new_wlbpercent,double new_tpfactor,double new_tslbonus,bool new_clearet,bool new_fillet,int p_save){
   ArrayResize(BUY_order,0);
   ArrayResize(SELL_order,0);
   clear_ExcuseTime =false;
   fill_ExcuseTime= false;
   candle_pos=-1;
   
   name = new_name;
   P = new_p;
   TSL_CandleCount = new_tslcc;
   WLB_percent = new_wlbpercent;
   TP_Factor = new_tpfactor;
   TSL_Bonus = new_tslbonus;
   clear_ExcuseTime = new_clearet;
   fill_ExcuseTime = new_fillet;
   
   this_Aethas =& Aethas_BOT;
   
   Percent_Save = 30+p_save*20;
}

void TI_TSL::~TI_TSL(){
   ArrayFree(SELL_order); 
   ArrayFree(BUY_order); 
}

void TI_TSL::set_ASK(double new_val){ASK=new_val;}
void TI_TSL::set_BID(double new_val){BID=new_val;}
void TI_TSL::set_TIME(datetime new_val){TIME=new_val;}
void TI_TSL::set_Aethas(Aethas *new_aethas){this_Aethas=new_aethas;}

double TI_TSL::get_TP_Factor(void){return(TP_Factor);}      

void TI_TSL::Jungle_trigger(Order *this_order,bool fed){
   if(this_order.get_Buy()){
      int size = ArraySize(BUY_order);
      ArrayResize(BUY_order,size+1);
      BUY_order[size] = this_order;
      
      if(!fed){
         //BUY_order[size].profit_TP = BUY_order[size].profit_TP*TP_Factor;
         if(clear_ExcuseTime){
         this_order.set_ExcuseTime(0);
         }
         if(fill_ExcuseTime){
            this_order.set_ExcuseTime(TIME-99999);
         }
      }
      
      /*BUY_order[size].TP_line.Price = BUY_order[size].orderopen + BUY_order[size].profit_TP;
      if(BUY_order[size].draw_TPLine){
         BUY_order[size].TP_line.Update();
      }*/
      
      
   }
   else{
      int size = ArraySize(SELL_order);
      ArrayResize(SELL_order,size+1);

      SELL_order[size] = this_order;
      if(!fed){
         //SELL_order[size].profit_TP = SELL_order[size].profit_TP*TP_Factor;
         if(clear_ExcuseTime){
            this_order.set_ExcuseTime(0);
         }
         if(fill_ExcuseTime){
            this_order.set_ExcuseTime(TIME-99999);
         }
      }
      
      /*SELL_order[size].TP_line.Price = SELL_order[size].orderopen - SELL_order[size].profit_TP;
      if(SELL_order[size].draw_TPLine){
         SELL_order[size].TP_line.Update();
      }*/
      
      
   } 
}

void TI_TSL::tick(datetime time,double ask,double bid){
   TIME = time;
   ASK = ask;
   BID = BID;
   int current_pos = this_Aethas.getCurrentCandle(P);
   if(candle_pos != current_pos){
      candle_pos = current_pos;
      
      Order *copyArray[];
      for(int i=0;i<ArraySize(BUY_order);i++){
         if(CheckPointer(BUY_order[i])!=POINTER_INVALID){
            if(BUY_order[i].get_OPEN()){
               SL_Tailing(BUY_order[i]);
               
               int size = ArraySize(copyArray);
               ArrayResize(copyArray,size+1);
               copyArray[size] = BUY_order[i];
            }
         }
      }
      
      ArrayResize(BUY_order,ArraySize(copyArray));
      for(int i=0;i<ArraySize(copyArray);i++){
         BUY_order[i] = copyArray[i];
      }
      
      ArrayResize(copyArray,0);
      
      for(int i=0;i<ArraySize(SELL_order);i++){
         if(CheckPointer(SELL_order[i])!=POINTER_INVALID){
            if(SELL_order[i].get_OPEN()){
               SL_Tailing(SELL_order[i]);
               
               int size = ArraySize(copyArray);
               ArrayResize(copyArray,size+1);
               copyArray[size] = SELL_order[i];
            }
         }
      }
      
      ArrayResize(SELL_order,ArraySize(copyArray));
      for(int i=0;i<ArraySize(copyArray);i++){
         SELL_order[i] = copyArray[i];
      }
      
      ArrayFree(copyArray);
   }
}

void TI_TSL::SL_Tailing(Order *this_order){

   double price=9999999.99;
   if(!this_order.get_Buy()){
      price=0.0;
   }
   
   bool found = false;
   
   int candle_start=candle_pos;
   int current_pos=1;

   Candle this_candle;
   while(found == false){
      if(!this_order.get_Buy()){
         if(price<this_Aethas.getHigh(P,current_pos)){
            price = this_Aethas.getHigh(P,current_pos);
         }

         if(current_pos >= TSL_CandleCount){
            this_candle.setCandle(this_Aethas.getHigh(P,current_pos),this_Aethas.getLow(P,current_pos),this_Aethas.getOpen(P,current_pos),this_Aethas.getClose(P,current_pos),this_Aethas.getTime(P,current_pos));
            if(this_candle.get_TopWick_Percent()>WLB_percent){ 
               found = true;
            }
            else{
               if(current_pos>TSL_CandleCount+1){
                  found = true;
               }
            }
         }
         current_pos++;
      }
      else{
         if(price>this_Aethas.getLow(P,current_pos)){
            price = this_Aethas.getLow(P,current_pos);
         }
         if(current_pos >= TSL_CandleCount){
            this_candle.setCandle(this_Aethas.getHigh(P,current_pos),this_Aethas.getLow(P,current_pos),this_Aethas.getOpen(P,current_pos),this_Aethas.getClose(P,current_pos),this_Aethas.getTime(P,current_pos));
            if(this_candle.get_TopWick_Percent()>WLB_percent){ 
               found = true;  
            }
            else{
               if(current_pos>TSL_CandleCount+1){
                  found = true;
               }
            }
         }
         current_pos++;
      }
   }
   
   
   double delta_price;
   double factor = Percent_Save /100.0;
   double target = this_order.get_highest_Profit()*factor;
   
   if(!this_order.get_Buy()){
      price = price + TSL_Bonus;
      delta_price = this_order.get_orderopen()-price;
      if(delta_price<target){
         price = this_order.get_orderopen()-target;
         //Print("SELL-SL moved to ",Percent_Save,"%|",price,"|",this_order.get_orderopen(),"|",this_order.get_highest_Profit());
      }
   }
   else{
      price = price - TSL_Bonus;
      delta_price = price-this_order.get_orderopen();
      if(delta_price<target){
         price = this_order.get_orderopen()+target;
         //Print("Buy-SL moved to ",Percent_Save,"%|",price,"|",this_order.get_orderopen(),"|",this_order.get_highest_Profit());
      }
   }


   if(!this_order.get_Buy()){
      if(price > ASK){
         if(this_order.get_SL_val()>price){
            this_order.set_SL_val(price);
            //Print("SL move to ", price);
            /*if(this_order.draw_SLLine){
               this_order.SL_line.Update(); 
            }*/
         }
      }
   }
   else{
       if(price < BID){
         if(this_order.get_SL_val()<price){
            this_order.set_SL_val(price);
            //Print("SL move to ", price);
            /*if(this_order.draw_SLLine){
               this_order.SL_line.Update(); 
            }*/
         }
      }
   }
            
   
}



