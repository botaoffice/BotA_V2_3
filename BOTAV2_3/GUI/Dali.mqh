//+------------------------------------------------------------------+
//|                                                         Dali.mqh |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <BOTAV2_3/MISC/GEO.mqh>
#include <BOTAV2_3/Jungler/CopyCat.mqh>

class Dali{
   private:
      bool draw_CC_SL;
   
      CopyCat *CC[];
      hline CC_SL[];
      Order *Orders[];
      
      void my_init();
      void get_Orders();
   public:
      void Dali();
      void ~Dali();  
      void Dali(bool draw_cc_sl);
      
      void add_CC(CopyCat *new_CC);
      void free_CC();
      
      void update_CC();
      
      
      
      
};

void Dali::Dali(){
   my_init();
}
void Dali::Dali(bool draw_cc_sl){
   my_init();
   draw_CC_SL = draw_cc_sl;
}
void Dali::~Dali(){}

void Dali::my_init(){}
void Dali::add_CC(CopyCat *new_CC){
   int size = ArraySize(CC);
   ArrayResize(CC,size+1);
   CC[size] = new_CC;
}
void Dali::free_CC(){
   ArrayFree(CC);
   ArrayResize(CC,0);
}

void Dali::update_CC(){
   get_Orders();

   
   //for(int i =0;i<ArraySize(CC_SL);i++){
   //   CC_SL[i].Delete();
   //}
   //ArrayFree(CC_SL);
   /*for(int i =0;i<ArraySize(Orders);i++){
      int size = ArraySize(CC_SL);
      ArrayResize(CC_SL,size+1);
      CC_SL[size]= hline(string(Orders[i].get_Num()), Orders[i].get_SL_val(),clrWhite,STYLE_DOT,1,false);
      CC_SL[size].Update();
   }*/
}

void Dali::get_Orders(){
   ArrayFree(Orders);
   for(int i=0;i<ArraySize(CC);i++){
      int order_i = 0;
      Order *this_order;
      this_order = CC[i].get_BUY_order(order_i);
      while(CheckPointer(this_order)!=POINTER_INVALID) {
         if(!this_order.get_Ghost()){   
            if(this_order.get_OPEN()){
            
               ArrayResize(Orders,ArraySize(Orders)+1);
               Orders[ArraySize(Orders)-1] = this_order;
            }
            else{
               for(int j=0;j<ArraySize(CC_SL);j++){
                  if(CC_SL[j].get_Name() == string(this_order.get_Num())){
                     CC_SL[j].Delete();
                     j = ArraySize(CC_SL);
                  }
               }
            }
         }
         order_i++;
         this_order = CC[i].get_BUY_order(order_i);
      }
      this_order = CC[i].get_SELL_order(order_i);
      while(CheckPointer(this_order)!=POINTER_INVALID) {
         if(!this_order.get_Ghost()){
            if(this_order.get_OPEN()){
            
               ArrayResize(Orders,ArraySize(Orders)+1);
               Orders[ArraySize(Orders)-1] = this_order;
            }
            else{
               for(int j=0;j<ArraySize(CC_SL);j++){
                  if(CC_SL[j].get_Name() == string(this_order.get_Num())){
                     CC_SL[j].Delete();
                     j = ArraySize(CC_SL);
                  }
               }
            }
         }
         order_i++;
         this_order = CC[i].get_SELL_order(order_i);
      }
   }
}