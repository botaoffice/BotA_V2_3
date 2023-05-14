//+------------------------------------------------------------------+
//|                                                        Garen.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/Support/WLB.mqh>

#include <BOTAV2_3/Jungler/CopyCat.mqh>

#include <BOTAV2_3/MISC/ActionBot.mqh>

class Garen : public ActionBot{

      private:
      
   
      bool UseReturn;

      bool UseWLB_Entry;      
      bool UseWLB_PreEntry;
      int UseWLBTimeOut;  
      int UseWLBMinTime;
      //int UseWLBMaxETime;

      CopyCat *Copy_Bot[];
   
      bool AdjustPE;
      double UseBE;
      double UseProfitMin;
      double UseMaxLoss;
      double UseMaxLossFactor;
      double UseSL;
      double UseTP;
      bool UseRiskEntry;
      bool WatchAve;
      bool UseWLBDarkLink;
      bool UseAVEDarkLink;
      int AveIndex;
      int Avetimetarget;
      int AveMinSpeed;
      
public:
      bool check_Order(Order *this_order);
    
      void SetOrder(bool buy,double sl,double ml,double be, double tp,double tsla,double min,bool isPE,int WLB_Time,double candle_size);

      void tick(datetime time,double ask,double bid);
      
      void WLB_trigger(WLB *checkthis_WLB,bool isPE);
      
      void Add_CopyCat(CopyCat *new_cc);
      
      
      
      Garen(void);
      Garen(string new_Name,ENUM_TIMEFRAMES new_P,string new_starttime,string new_endtime,bool new_dl,print_manager *new_pm,bool new_SIMULATION,int new_Excuse_Time,bool new_Return,bool new_BEClose,
            bool new_WLB_USE_E,bool new_WLB_USE_PE,int new_WLB_TimeOut,int new_WLB_MinTime,bool new_ape,double new_BE,double new_PROFITMIN,double new_MAXLOSS,double new_MAXLOSSFACTOR,
            double new_SL,double new_TP,bool new_UseRiskEntry,bool new_wa,bool new_uadl,int new_Ave_ID,int new_Ave_TimeTarget,int new_Ave_MinSpeed);
      ~Garen(void);

};   

void Garen::Garen(){}
void Garen::~Garen(){
   ArrayFree(Copy_Bot); 
}

void Garen::Garen(string new_Name,ENUM_TIMEFRAMES new_P,string new_starttime,string new_endtime,bool new_dl,print_manager *new_pm,bool new_SIMULATION,int new_Excuse_Time,bool new_Return,bool new_BEClose,
            bool new_WLB_USE_E,bool new_WLB_USE_PE,int new_WLB_TimeOut,int new_WLB_MinTime,bool new_ape,double new_BE,double new_PROFITMIN,double new_MAXLOSS,double new_MAXLOSSFACTOR,
            double new_SL,double new_TP,bool new_UseRiskEntry,bool new_wa,bool new_uadl,int new_Ave_ID,int new_Ave_TimeTarget,int new_Ave_MinSpeed){
            
   name = new_Name;
   P=new_P;
   BOT_exe_time1_start = new_starttime;
   BOT_exe_time1_end = new_endtime;  
   UseWLBDarkLink = new_dl;
   PrintManager = new_pm;
   SIM = new_SIMULATION;
   Excuse_TIME = new_Excuse_Time;
   UseReturn = new_Return;
   UseBEClose = new_BEClose;
   UseWLB_Entry = new_WLB_USE_E;
   UseWLB_PreEntry = new_WLB_USE_PE;
   UseWLBTimeOut = new_WLB_TimeOut;
   UseWLBMinTime = new_WLB_MinTime;
   AdjustPE = new_ape;
   UseBE = new_BE;
   UseProfitMin = new_PROFITMIN;
   UseMaxLoss = new_MAXLOSS;
   UseMaxLossFactor = new_MAXLOSSFACTOR;
   UseSL = new_SL;
   UseTP = new_TP;
   UseRiskEntry = new_UseRiskEntry;
   WatchAve = new_wa;
   UseAVEDarkLink = new_uadl;
   AveIndex = new_Ave_ID;
   Avetimetarget = new_Ave_TimeTarget;  
   AveMinSpeed = new_Ave_MinSpeed;
}


void Garen::SetOrder(bool buy,double sl,double ml,double be, double tp,double tsla,double min,bool isPE,int WLB_Time,double candle_size){
   string text = "SetOrder_";
   string text2 = "";

   int runs = 1;

   Order *order;
   
   
   if(buy){
      text += "BUY";
      ArrayResize(BUY_order,ArraySize(BUY_order)+1);
      order =& BUY_order[ArraySize(BUY_order)-1]; 
      text2 = "Buy_";
      order.set_orderopen(ASK);
      BUY_Pos+=1;
      order.set_Num(BUY_Pos);
      order.set_name(text2 + name + "_" + string(BUY_Pos));
   }
   else{
      text += "SELL";
      ArrayResize(SELL_order,ArraySize(SELL_order)+1);
      order =& SELL_order[ArraySize(SELL_order)-1];  
      text2 = "Sell_";
      
      order.set_orderopen(BID);
      SELL_Pos+=1;
      order.set_Num(SELL_Pos);
      order.set_name(text2 + name + "_" + string(SELL_Pos));
   }
   
   PrintManager.write_log(name,text,"","","","","","","","");   

   order.set_orderopentime(TIME);
   
   
   order.set_ordercommission(-0.07);
   order.set_Buy(buy);
   //order.Sell=!buy;
   order.set_Ghost(true);
   order.set_SIM(SIM);
  
   order.set_OPEN(true);
   order.set_profit_MIN(min);
   order.set_profit_MAXLOSS(ml);
   order.set_profit_SL(sl);
   order.set_profit_BE(be);
   order.set_profit_TP(tp);

   if(!SIMULATION){
      order.set_profit_TP(tp+0.2);
      order.set_profit_BE(be+0.1);
      order.set_profit_MIN(min+0.1);
   }

   //order.draw_SLLine = draw_slLine;
   //order.Line_Color = Line_Color_BUY;
   //order.Line_Style = Line_Style;                                                                                                                                                                                                                                                                                            
   //order.Line_Width = Line_Width;

   //order.draw_ghost = draw_ghostLine;
  
   //order.draw_MINLine = draw_helpLines;
   //order.draw_MAXLine = draw_helpLines;

   order.set_is_PE(isPE);
   order.set_WLB_Time(WLB_Time);//int(TIME)-int(WLB_Time);
   order.set_candle_size(candle_size);
   
   
   
   order.create(TIME,ASK,BID);
   
   OrderSum_i+=1;
   
   if(sl<=ml || UseRiskEntry){
      for(int i =0;i<ArraySize(Copy_Bot);i++){
         
         Copy_Bot[i].set_ASK(ASK);
         Copy_Bot[i].set_BID(BID);
         Copy_Bot[i].set_TIME(TIME);
         Copy_Bot[i].Tank_trigger(order);
      } 
   }
}

void Garen::tick(datetime time,double ask,double bid){
   TIME = time;
   ASK = ask;
   BID = bid;
   
   check_Sleep();
   for(int i =0;i<ArraySize(Copy_Bot);i++){
      Copy_Bot[i].set_inSleepTime(inSleepTime);
   }
   DD=0;
   Order *this_order;
   Order copyArray[];
   for(int i =0;i<ArraySize(BUY_order);i++){
      if(BUY_order[i].get_OPEN()){ 
         DD+=BUY_order[i].getDelta(time, ask, bid);
         this_order =& BUY_order[i];
         if(check_Order(this_order)){
            if(!CloseOrder(this_order)){
               ArrayResize(copyArray,ArraySize(copyArray)+1);
               copyArray[ArraySize(copyArray)-1]=BUY_order[i];
               this_order =&BUY_order[i];
               Add_OrderSave(this_order);
               /*if(CheckPointer(SaveManager)!=POINTER_INVALID){   
                  SaveManager.add_OrderSave(name,true,BUY_order[i].Num,BUY_order[i].Ghost,
                              BUY_order[i].orderopentime,BUY_order[i].orderopen,BUY_order[i].ExcuseTime,
                              BUY_order[i].profit_MIN,BUY_order[i].profit_MAXLOSS,BUY_order[i].profit_SL,BUY_order[i].profit_BE,BUY_order[i].profit_TP,
                              BUY_order[i].BE_SET,BUY_order[i].TSL_Activate,BUY_order[i].highest_DD,BUY_order[i].highest_P,BUY_order[i].TSL_Activate);
               }*/
            }
         }
         else{
            ArrayResize(copyArray,ArraySize(copyArray)+1);
            copyArray[ArraySize(copyArray)-1]=BUY_order[i];
            this_order =&BUY_order[i];
            Add_OrderSave(this_order);
            /*if(CheckPointer(SaveManager)!=POINTER_INVALID){   
               SaveManager.add_OrderSave(name,true,BUY_order[i].Num,BUY_order[i].Ghost,
                           BUY_order[i].orderopentime,BUY_order[i].orderopen,BUY_order[i].ExcuseTime,
                           BUY_order[i].profit_MIN,BUY_order[i].profit_MAXLOSS,BUY_order[i].profit_SL,BUY_order[i].profit_BE,BUY_order[i].profit_TP,
                           BUY_order[i].BE_SET,BUY_order[i].TSL_Activate,BUY_order[i].highest_DD,BUY_order[i].highest_P,BUY_order[i].TSL_Activate);
            }*/
         }
      }
   }
   if(ArraySize(copyArray)!=ArraySize(BUY_order)){
      ArrayResize(BUY_order,ArraySize(copyArray));
      for(int i=0;i<ArraySize(copyArray);i++){
         BUY_order[i]=copyArray[i];
      }
   }
   ArrayResize(copyArray,0);
   
   for(int i =0;i<ArraySize(SELL_order);i++){
      if(SELL_order[i].get_OPEN()){ 
         DD+=SELL_order[i].getDelta(time, ask, bid);
         this_order =& SELL_order[i];
         if(check_Order(this_order)){
            if(!CloseOrder(this_order)){
               ArrayResize(copyArray,ArraySize(copyArray)+1);
               copyArray[ArraySize(copyArray)-1]=SELL_order[i];
               this_order =&SELL_order[i];
               Add_OrderSave(this_order);
               /*if(CheckPointer(SaveManager)!=POINTER_INVALID){   
                  SaveManager.add_OrderSave( name,false,SELL_order[i].Num,SELL_order[i].Ghost,
                                          SELL_order[i].orderopentime,SELL_order[i].orderopen,SELL_order[i].ExcuseTime,
                                          SELL_order[i].profit_MIN,SELL_order[i].profit_MAXLOSS,SELL_order[i].profit_SL,SELL_order[i].profit_BE,SELL_order[i].profit_TP,
                                          SELL_order[i].BE_SET,SELL_order[i].TSL_Activate,SELL_order[i].highest_DD,SELL_order[i].highest_P,SELL_order[i].TSL_Activate);
               }*/
            }
         }
         else{
            ArrayResize(copyArray,ArraySize(copyArray)+1);
            copyArray[ArraySize(copyArray)-1]=SELL_order[i];
            this_order =&SELL_order[i];
            Add_OrderSave(this_order);
            /*if(CheckPointer(SaveManager)!=POINTER_INVALID){   
               SaveManager.add_OrderSave(name,false,SELL_order[i].Num,SELL_order[i].Ghost,
                                       SELL_order[i].orderopentime,SELL_order[i].orderopen,SELL_order[i].ExcuseTime,
                                       SELL_order[i].profit_MIN,SELL_order[i].profit_MAXLOSS,SELL_order[i].profit_SL,SELL_order[i].profit_BE,SELL_order[i].profit_TP,
                                       SELL_order[i].BE_SET,SELL_order[i].TSL_Activate,SELL_order[i].highest_DD,SELL_order[i].highest_P,SELL_order[i].TSL_Activate);
            }*/
         }
      }
   }
   if(ArraySize(copyArray)!=ArraySize(SELL_order)){
      ArrayResize(SELL_order,ArraySize(copyArray));
      for(int i=0;i<ArraySize(copyArray);i++){
         SELL_order[i]=copyArray[i];
      }
   }
   ArrayFree(copyArray);
   if(DD<highest_DD){
      highest_DD = DD;
   }
   if(CheckPointer(SaveManager)!=POINTER_INVALID){   
      SaveManager.add_GarenSave(name,g_Profits_SUM,g_highest_Loss,g_highest_P,highest_DD,g_HighestProfitDelta,g_HighestPoints,g_Profits_Pip,g_Profits_SIM);
   }
}
         
bool Garen::check_Order(Order *this_order){
   string text = "B";
   string full_text="";
   if(!this_order.get_Buy()){
      text = "S";
   }      
   this_order.tick(TIME,ASK,BID);

   if(this_order.check_TP(TIME,ASK,BID)){  
      full_text = text + " TP Close";   
      PrintManager.write_log(name,full_text ,string(this_order.get_Num()),"","","","","","","");
      return(true);//CloseOrder(true,i);
   }
   else{
      if(this_order.check_MaxLoss(TIME,ASK,BID)){
         full_text = text + " MaxLoss Close";   
         PrintManager.write_log(name,full_text ,string(this_order.get_Num()),"","","","","","","");
         return(true);
      }
      
      if(this_order.check_SL(TIME,ASK,BID)){
         if(this_order.get_ExcuseTime() == 0){
            this_order.set_ExcuseTime(TIME);
         }
         
         int delta = int(TIME - this_order.get_ExcuseTime());

         if(delta >= Excuse_TIME || (UseBEClose && this_order.get_BE_SET())){
            full_text = text + " SL Close";   
            PrintManager.write_log(name,full_text ,string(this_order.get_Num()),"","","","","","","");
            return(true);
         }
      }
   }
   return(false);
}

void Garen::WLB_trigger(WLB *checkthis_WLB,bool isPE){
   if((isPE && UseWLB_PreEntry) || (isPE==False && UseWLB_Entry)){
      if(!inSleepTime ){
         int check_time_max = UseWLBTimeOut;
         int check_time_min = UseWLBMinTime;
         datetime check_time_etime = checkthis_WLB.get_e_time();
         if(isPE ){//&& AdjustPE
            check_time_max=check_time_max/2;
            check_time_min=check_time_min/2;
            check_time_etime = checkthis_WLB.get_pe_time();
         }
         int delta = int(TIME-checkthis_WLB.get_creation_time());
         
       
         if(delta < check_time_max){
         if(delta > check_time_min){
         if(UseReturn || checkthis_WLB.get_isReturn() == false){
         
         
         
            bool isBuy=false;
            double sl;
            double max_loss;
            double be;
            double tp;
            double tsla;
            double min;
            
            double candle_size = checkthis_WLB.get_candle().get_High()-checkthis_WLB.get_candle().get_Low();
            min = candle_size*UseProfitMin;
            be = candle_size*UseBE;
            tp = candle_size*UseTP;
            max_loss = candle_size*UseMaxLossFactor;
            /*if(MINBE){
               if(be<MINBE_Val){
                  be = MINBE_Val;
               }
               if(min<MINMIN_Val){
                  min = MINMIN_Val;
               }
            }*/
            if(isPE && AdjustPE){
               tp = candle_size*UseTP-(candle_size*0.5);
            }
            tsla = candle_size*UseTP; 
            if(!checkthis_WLB.get_Buy()){
               if(UseWLBDarkLink){
                  isBuy=true;
               }
               else{
                  isBuy=false; 
               }
            }
            else{
               if(UseWLBDarkLink){
                  isBuy=false;
               }
               else{
                  isBuy=true;
               }
            }
            bool order_ok = true;
            if(this_Ave.get_AveBid()*100>AveMinSpeed){
            
            
               if(WatchAve){
                  bool buypenalty = false;
                  bool sellpenalty = false;
                  //Print("Speed OK:",this_Ave.get_AveBid()*100,"|",AveMinSpeed);
                  if(this_Ave.get_BuyPenalty_Time(AveIndex)>0){
                     int delta_b = int(TIME-this_Ave.get_BuyPenalty_Time(AveIndex));// > timetarget
                     if(delta_b>Avetimetarget*10){
                        buypenalty = true;
                        
                     }
                  }
                  if(this_Ave.get_SellPenalty_Time(AveIndex)>0){
                     int delta_s = int(TIME-this_Ave.get_SellPenalty_Time(AveIndex));// > timetarget
                     if(delta_s>Avetimetarget*10){
                        sellpenalty = true;
                        
                     }
                  }
                  if(isBuy && buypenalty){
                     order_ok = false;
                     //Print("Buy-Penalty");
                     if(UseAVEDarkLink){
                        order_ok=true;
                        isBuy = false;
                     }
                  }
                  if(isBuy==false && sellpenalty){
                     order_ok = false;
                     //Print("Sell-Penalty");
                     if(UseAVEDarkLink){
                        order_ok=true;
                        isBuy = true;
                     }
                  }
               }
            }
            else{
               //Print("Speed to Small:",this_Ave.get_AveBid()*100,"|",AveMinSpeed);
               //buypenalty = true;
               //sellpenalty = true;
               order_ok=false;
            }
            
            if(isBuy){
               sl = BID - (checkthis_WLB.get_candle().get_Low()-(candle_size*UseSL));
            }
            else{
               sl =  (checkthis_WLB.get_candle().get_High()+(candle_size*UseSL)) - BID;
            }
            if(order_ok){
               /*if(sl>(this_Ave.CandleSize*UseMaxLoss)){
                  //Print("SL:",sl," > ",this_Ave.CandleSize,"*",UseMaxLoss,"_",this_Ave.CandleSize*UseMaxLoss);
                  sl = this_Ave.CandleSize*UseMaxLoss;
               }*/
               int wlb_time = int(TIME)-int(checkthis_WLB.get_creation_time());
               if(UseMaxLoss<max_loss){
                  max_loss = UseMaxLoss;
               }
               SetOrder(isBuy ,sl ,max_loss ,be ,tp ,tsla ,min,isPE,wlb_time,candle_size); 
               //Print("WLB setOrder",isBuy ,"|",sl ,"|",max_loss ,"|",be ,"|",tp ,"|",tsla ,"|",min,"|",isPE,"|",wlb_time,"|",candle_size);
            }
            
         }
         }
         }
      }
      /*else{
         Print("SLEEPING");
      }*/
   }    
}
void Garen::Add_CopyCat(CopyCat *new_cc){
   int size = ArraySize(Copy_Bot);
   ArrayResize(Copy_Bot,size+1);
   Copy_Bot[size] = new_cc;
}

