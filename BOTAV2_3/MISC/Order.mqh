//+------------------------------------------------------------------+
//|                                                    WLB_Order.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/MISC/GEO.mqh>
#include <BOTAV2_3/MISC/CANDLE.mqh>
#include <BOTAV2_3/MISC/PrintManager.mqh>

class Order{
   private:
            //bool Sell;
            bool Buy;
            string name;
            
            bool OPEN;
            
            int   Num;
            
            bool Ghost;
            bool SIM;
            
            double Lot;
            
            //bool draw_ghost;
            //tline ghost_line;
            
            datetime orderopentime;
            datetime failtime;
            double orderopen;
            double orderclose;
            double ordercommission;
            
            datetime ExcuseTime;
            
            //color Line_Color;
            //ENUM_LINE_STYLE Line_Style;                                                                                                                                                                                                                                                                                            
            //int Line_Width;

            double profit_MIN;
            double profit_MAXLOSS;
            double profit_SL;
            double profit_BE;
            double profit_TP;
            
            double TP_val;
            double SL_val;
            double MAX_val;
            
            double TPCountdown_p;
            datetime TPCountdown;
            
            bool BE_SET;
            
            //double highest_DD;
            //double highest_P;

            double TSL_Activate;
            bool TSL_ACTIVE;
            
            //bool draw_SLLine;
            //hline SL_line;
            
            //bool draw_TPLine;
            //hline TP_line;
          
            //bool draw_MINLine;
            //tline MIN_line;
            //bool draw_TSLALine;
            //tline TSLA_line;
            //bool draw_MAXLine;
            //tline MAX_line;
            
                   
            double Profit;
            double Profit_pip;            
            double Profit_SIM;




            bool is_PE;
            double candle_size;
            
            int WLB_Time;
            int Clear_Time;
            double Clear_Val;
            double Clear_Val_Percent;
            double highest_Loss;
            double highest_Loss_Percent;
            
            double highest_Profit;
            double highest_Profit_Percent;

public:

            void  Order();
            void ~Order();  
            
            bool create(datetime time,double ask,double bid);
            
            int candleTime();  

            double getDelta(datetime time,double ask,double bid);
            bool CloseOrder(datetime time,double ask,double bid);

            bool check_SL(datetime time,double ask,double bid);
            bool check_TP(datetime time,double ask,double bid);
             
            bool check_BE(datetime time,double ask,double bid);
            bool check_MaxLoss(datetime time,double ask,double bid);
            
            bool check_TSLA(datetime time,double ask,double bid);
            
            void SL_Tailing(datetime time,double ask,double bid);
            
            /*void init_ghostLine(datetime time);
            void init_MINLine(datetime time);
            void init_MAXLine(datetime time);
            void init_TSLALine(datetime time);
            void init_TPLine(datetime time);
            void init_SLLine(datetime time);*/

            
            //void setCandle();
            
            void Clear();
            
            double tick(datetime time,double ask,double bid);
            
            bool get_OPEN();
            bool get_Buy();
            bool get_Ghost();
            bool get_SIM();
            double get_TP_val();
            double get_SL_val();
            double get_MAX_val();
            double get_Profit();
            int get_Num();
            datetime get_orderopentime();
            double get_orderopen();
            double get_orderclose();
            double get_highest_Profit();
            double get_highest_Loss();
            
            datetime get_ExcuseTime();
            double get_profit_MIN();
            double get_profit_MAXLOSS();
            double get_profit_SL();
            double get_profit_BE();
            double get_profit_TP();
            bool get_BE_SET();
            double get_TSL_Activate();
            double get_Lot(); 
            double get_Profit_pip();     
            double get_Profit_SIM();                   
            bool get_is_PE();       
            double get_candle_size(); 
            int get_WLB_Time();  
            int get_Clear_Time();     
            double get_Clear_Val();  
            double get_Clear_Val_Percent();
            double get_highest_Loss_Percent();
            double get_highest_Profit_Percent();         
            bool get_TSL_ACTIVE();  
            datetime get_failtime();
            datetime get_TPCountdown();            
            //bool get_BE_SET();
            
            void set_ExcuseTime(datetime new_time);
            void set_SL_val(double new_val);
            void set_profit_MIN(double new_val);
            void set_orderopen(double new_val);
            void set_Num(int new_num);
            void set_name(string new_name);
            void set_orderopentime(datetime new_time);
            void set_ordercommission(double new_val);
            void set_Buy(bool new_val); 
            void set_Ghost(bool new_val);
            void set_SIM(bool new_val);
            void set_Lot(double new_val);
            void set_OPEN(bool new_val);
            void set_profit_MAXLOSS(double new_val);
            void set_profit_SL(double new_val);
            void set_profit_BE(double new_val);
            void set_profit_TP(double new_val);
            void set_TSL_Activate(double new_val);
            void set_TSL_ACTIVE(bool new_val);
            void set_is_PE(bool new_val);
            void set_WLB_Time(int new_time);
            void set_candle_size(double new_val);
            void set_BE_SET(bool new_val);
            void set_Profit(double new_val);
            void set_Profit_pip(double new_val);
            void set_Clear_Val(double new_val);
            void set_Clear_Val_Percent(double new_val);
            void set_highest_Loss(double new_val);
            void set_highest_Loss_Percent(double new_val);
            void set_highest_Profit(double new_val);
            void set_highest_Profit_Percent(double new_val);
            void set_Clear_Time(int new_time);
};

void Order::Order(){
   Profit =0.0;
   Profit_pip = 0.0;
   
   //highest_DD = 0.0;

   
   BE_SET = false;
   TSL_ACTIVE=false;

   failtime=0;
   ExcuseTime=0;
   
   TPCountdown =0;
   TPCountdown_p =0.95;
}

void Order::~Order(){}

bool Order::get_OPEN(void){return(OPEN);}
bool Order::get_Buy(void){return(Buy);}
bool Order::get_Ghost(void){return(Ghost);}
bool Order::get_SIM(void){return(SIM);}
int Order::get_Num(void){return(Num);}
double Order::get_TP_val(void){return(TP_val);}
double Order::get_SL_val(void){return(SL_val);}
double Order::get_MAX_val(void){return(MAX_val);}
double Order::get_Profit(void){return(Profit);}
datetime Order::get_orderopentime(void){return(orderopentime);}
double Order::get_orderopen(void){return(orderopen);}
double Order::get_orderclose(void){return(orderclose);}
double Order::get_highest_Profit(void){return(highest_Profit);}
double Order::get_highest_Loss(void){return(highest_Loss);}

datetime Order::get_ExcuseTime(void){return(ExcuseTime);}
double Order::get_profit_MIN(void){return(profit_MIN);}
double Order::get_profit_MAXLOSS(void){return(profit_MAXLOSS);}
double Order::get_profit_SL(void){return(profit_SL);}
double Order::get_profit_BE(void){return(profit_BE);}
double Order::get_profit_TP(void){return(profit_TP);}
bool Order::get_BE_SET(void){return(BE_SET);}
double Order::get_TSL_Activate(void){return(TSL_Activate);}
double Order::get_Lot(void){return(Lot);}
double Order::get_Profit_pip(void){return(Profit_pip);}    
double Order::get_Profit_SIM(void){return(Profit_SIM);}                     
bool Order::get_is_PE(void){return(is_PE);}    
double Order::get_candle_size(void){return(candle_size);} 
int Order::get_WLB_Time(void){return(WLB_Time);}  
int Order::get_Clear_Time(void){return(Clear_Time);}     
double Order::get_Clear_Val(void){return(Clear_Val);}
double Order::get_Clear_Val_Percent(void){return(Clear_Val_Percent);}
double Order::get_highest_Loss_Percent(void){return(highest_Loss_Percent);}
double Order::get_highest_Profit_Percent(void){return(highest_Profit_Percent);}
bool Order::get_TSL_ACTIVE(void){return(TSL_ACTIVE);}               
datetime Order::get_failtime(void){return(failtime);}      
datetime Order::get_TPCountdown(void){return(TPCountdown);}     

void Order::set_ExcuseTime(datetime new_time){ExcuseTime=new_time;}
void Order::set_SL_val(double new_val){SL_val=new_val;}
void Order::set_profit_MIN(double new_val){profit_MIN=new_val;}
void Order::set_orderopen(double new_val){orderopen=new_val;}
void Order::set_Num(int new_num){Num=new_num;}
void Order::set_name(string new_name){name=new_name;}  
void Order::set_orderopentime(datetime new_time){orderopentime=new_time;}  
void Order::set_ordercommission(double new_val){ordercommission=new_val;}  
void Order::set_Buy(bool new_val){Buy=new_val;}          
void Order::set_Ghost(bool new_val){Ghost=new_val;} 
void Order::set_SIM(bool new_val){SIM=new_val;} 
void Order::set_Lot(double new_val){Lot=new_val;} 
void Order::set_OPEN(bool new_val){OPEN=new_val;} 
void Order::set_profit_MAXLOSS(double new_val){profit_MAXLOSS=new_val;} 
void Order::set_profit_SL(double new_val){profit_SL=new_val;} 
void Order::set_profit_BE(double new_val){profit_BE=new_val;} 
void Order::set_profit_TP(double new_val){profit_TP=new_val;}        
void Order::set_TSL_Activate(double new_val){TSL_Activate=new_val;}    
void Order::set_TSL_ACTIVE(bool new_val){TSL_ACTIVE=new_val;}    
void Order::set_is_PE(bool new_val){is_PE=new_val;}    
void Order::set_WLB_Time(int new_time){WLB_Time=new_time;}    
void Order::set_candle_size(double new_val){candle_size=new_val;}   
void Order::set_BE_SET(bool new_val){BE_SET=new_val;}  
void Order::set_Profit(double new_val){Profit=new_val;}  
void Order::set_Profit_pip(double new_val){Profit_pip=new_val;}  
void Order::set_Clear_Val(double new_val){Clear_Val=new_val;}  
void Order::set_Clear_Val_Percent(double new_val){Clear_Val_Percent=new_val;}  
void Order::set_highest_Loss(double new_val){highest_Loss=new_val;}  
void Order::set_highest_Loss_Percent(double new_val){highest_Loss_Percent=new_val;}  
void Order::set_highest_Profit(double new_val){Profit=new_val;}  
void Order::set_highest_Profit_Percent(double new_val){highest_Profit_Percent=new_val;}   
void Order::set_Clear_Time(int new_time){Clear_Time=new_time;}   
       
bool Order::create(datetime time,double ask,double bid){
   //init_SLLine(time);
   //init_TPLine(time);
   
   
   /*if(Ghost || SIM){
      init_ghostLine(time);
   }*/
   

   /*init_TSLALine(time);
   init_MAXLine(time);
   init_MINLine(time);*/
   /*if(draw_MINLine){
      
   }*/
   SL_val = orderopen - profit_SL;
   TP_val = orderopen + profit_TP;
   MAX_val = orderopen - profit_MAXLOSS;
   if(!Buy){
      SL_val = orderopen + profit_SL;
      TP_val = orderopen - profit_TP;
      MAX_val = orderopen + profit_MAXLOSS;
   }
   
   if(!SIM && !Ghost){
      if(AccountEquity()>MIN_ACC_SIZE){
         if(Buy){
            Num = OrderSend(Symbol(),OP_BUY ,Lot, Ask, 2,Ask-profit_MAXLOSS,TP_val,NULL,0,0,clrNONE);
         }
         else{
            Num = OrderSend(Symbol(),OP_SELL ,Lot, Bid, 2,Bid+profit_MAXLOSS,TP_val,NULL,0,0,clrNONE);
         }
         if(OrderSelect(Num,SELECT_BY_TICKET)){
            ordercommission = OrderCommission();
            return(true);
         }
         else{
            Print("Order open was not possible");
            
            Sleep(100);
            Print("retry after 100ms");
            if(Buy){
               Num = OrderSend(Symbol(),OP_BUY ,Lot, Ask, 2,Ask-profit_MAXLOSS,TP_val,NULL,0,0,clrNONE);
            }
            else{
               Num = OrderSend(Symbol(),OP_SELL ,Lot, Bid, 2,Bid+profit_MAXLOSS,TP_val,NULL,0,0,clrNONE);
            }
            if(OrderSelect(Num,SELECT_BY_TICKET)){
               ordercommission = OrderCommission();
               return(true);
            }
            else{
               Print("Order open was not possible");
            
            
            
               OPEN=false;
               
               if(failtime==0){
                  failtime = time;
               }
               return(false);
            }
         }
      }
      else{
         Print("Account to Small (<",MIN_ACC_SIZE,")");
         OPEN=false;
         return(true);
      }
   }
   else{
      return(true);
   }
}

bool Order::CloseOrder(datetime time,double ask,double bid){
   if(!Buy){
      orderclose =  ask;
   }
   else{
      orderclose = bid;
   }
   
   Profit_pip = orderclose-orderopen;
   if(!Buy){
      Profit_pip = orderopen-orderclose;
   }
   Profit_SIM = Profit_pip + ordercommission;
   
   if(Ghost==false && SIM == false){

      if(OrderSelect(Num, SELECT_BY_TICKET)){ 
         if(OrderCloseTime()>0){
            Profit=OrderProfit()+OrderCommission();
            OPEN = false;
            Clear();
           
            return(true);        
         }
         else{
            color c  = clrRed;
            if((OrderProfit()+OrderCommission())>0){
               c = clrGreen;
            }
            if(!OrderClose(Num,OrderLots(),Ask,3,c)){
               return(false);
            }
            else{
               Profit=OrderProfit()+OrderCommission();
               OPEN = false;
               Clear();
              
               return(true);            
            }
         }
      }
      else{
         return(true);
      }
   }
   else{
      if(OPEN){
         
         Profit=Profit_pip+ordercommission;
         if(SIM){
            Profit=Profit_pip+(ordercommission*2);
         }
         OPEN = false;
         
         Clear();
         /*if(draw_ghost){
            ghost_line.Price2 = orderclose;
            ghost_line.Time2 = time;
            if(o_profit>0){
               ghost_line.Color =clrGreen;
            }
            else{
               ghost_line.Color =clrOrange;
            }
            ghost_line.Update();
         }*/
      }
      return(true); 
   }
  
}

double Order::tick(datetime time,double ask,double bid){
   Profit_pip = getDelta(time,ask,bid);
   if(!BE_SET){
      check_BE(time,ask,bid);
   }
   if(Profit_pip>highest_Profit){
      highest_Profit = Profit_pip;
      if(candle_size>0){
         highest_Profit_Percent = Profit_pip/candle_size;
      }
   }
   if(Profit_pip<highest_Loss){
      highest_Loss = Profit_pip;
      if(candle_size>0){
         highest_Loss_Percent = Profit_pip/candle_size;
      }
   }
   return(Profit_pip);
}

double Order::getDelta(datetime time,double ask,double bid){
   
   double delta = orderopen-bid;
   if(Buy){
      delta = bid-orderopen;
   }
   return(delta);
} 


bool Order::check_TSLA(datetime time,double ask,double bid){
   if(!Buy){
      if(bid<(orderopen-TSL_Activate) && !TSL_ACTIVE){
         TSL_ACTIVE=true;
         return(true);
      }
   }
   else{
      if(bid>(orderopen+TSL_Activate) && !TSL_ACTIVE){
         TSL_ACTIVE=true;
         return(true);
      }
   }
   return(false);
}
bool Order::check_MaxLoss(datetime time,double ask,double bid){
   if(Buy){ 
      if(bid<=MAX_val){
         return(true);
      }
      else{
         return(false);
      }
   }
   else{
      if(ask>=MAX_val){
         return(true);
      }
      else{
         return(false);
      }
   } 
}


bool Order::check_SL(datetime time,double ask,double bid){
   if(Buy){ 
      if(bid<SL_val){
         Clear_Time=0;
         return(true);
         
      }
   }
   else{
      if(ask>SL_val){
         Clear_Time=0;
         return(true);
      }
   }
   if(Clear_Time==0){
      Clear_Time = int(time)-int(orderopentime);
      Clear_Val = highest_Profit;
      Clear_Val_Percent = highest_Profit_Percent;
   }
   return(false);
}

bool Order::check_TP(datetime time,double ask,double bid){

   if(TPCountdown==0){
      if(Buy){
         double target = TP_val * TPCountdown_p;
         if(bid >=target){
            TPCountdown=time;
         }
      }
      else{
         double target = TP_val + TP_val * (1-TPCountdown_p);
         if(bid >=target){
            TPCountdown=time;
         }
      }
   }

   if(Buy){ 
      if(bid>(orderopen+profit_TP)){
         return(true);
      }
      else{
         return(false);
      }

   }
   else{
      if(ask<(orderopen-profit_TP)){
         return(true);
      }
      else{
         return(false);
      }
   }
}
bool Order::check_BE(datetime time,double ask,double bid){
   if(!BE_SET){
      if(!Buy){
         if(ask<(orderopen-profit_BE)){
            BE_SET=true;
            if(SL_val>(orderopen-profit_MIN)){
               SL_val = orderopen-profit_MIN;
               return(true);
            }
         }
      }
      else{
         if(bid>(orderopen+profit_BE)){
            BE_SET=true;
            if(SL_val<(orderopen+profit_MIN)){
               SL_val = orderopen+profit_MIN;
               return(true);
            }
         }
      }
   }
   return(false);
}


void Order::Clear(){
}

