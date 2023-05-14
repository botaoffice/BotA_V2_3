//+------------------------------------------------------------------+
//|                                                      CopyCat.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/Carry/TI_TSL.mqh>
#include <BOTAV2_3/MISC/ActionBot.mqh>
#include <BOTAV2_3/GUI/CC_GUI.mqh>

class CopyCat : public ActionBot{

   private:
      
      //Bota_GUI_CC *GUI;
      //bool has_GUI;
      
      TI_TSL *TI_BOT;
      bool has_TI;
      
      bool isActive;
      int ActiveTarget;
      int DeactiveTarget;
      
      bool isDark;
      double UseFed;
      double UseFastClose;
      
      
      
      bool GhostCarry;
       
      Order OpenFails[]; 
      
      
      int AveIndex;
      int Avetimetarget;
      
      //double SIM_Volume;
      
public:    
      CopyCat(void);
      CopyCat(string new_name,ENUM_TIMEFRAMES new_P,print_manager *new_pm,bool new_sim,int new_ET,bool new_UGC,bool is_active,bool new_Dark,double new_Fed,double new_FastClose,bool new_BEClose,int new_ActiveTarget,int new_DeactiveTarget,double new_LOT);
      ~CopyCat(void);
      
      
      
      bool check_Order(Order *this_order);
      bool check_Order_SL(Order *this_order);
      bool check_Order_MaxLoss(Order *this_order);
      bool check_Order_FastClose(Order *this_order);
      bool check_Order_Fed(Order *this_order);
      
      void SetOrder(bool buy,double sl,double ml,double be, double tp, double tsla,double min,bool isfed,bool isPE,int WLB_Time,double candle_size);

      void tick(datetime time,double ask,double bid);
      
      void Tank_trigger(Order *this_order);
      void Carry_trigger(Order *this_order); 
      
      bool CC_CloseOrder(Order *this_order);
      
      void set_isActive(bool new_val);
      //void set_Excuse_TIME(int new_val);
      //void set_UseBEClose(bool new_val);
      void set_has_TI(bool new_val);
      void set_TI_BOT(TI_TSL *new_bot);
};   
void CopyCat::CopyCat(){
   isActive=false;
   ArrayResize(OpenFails,0);
   has_TI = False;
   //has_GUI =False;
   //this_Aethas =& Aethas_BOT;
   SIM_Volume = 10000;
}
void CopyCat::CopyCat(string new_name,ENUM_TIMEFRAMES new_P,print_manager *new_pm,bool new_sim,int new_ET,bool new_UGC,bool is_active,bool new_Dark,double new_Fed,double new_FastClose,bool new_BEClose,int new_ActiveTarget,int new_DeactiveTarget,double new_LOT){

   ArrayResize(OpenFails,0);
   has_TI = False;
   //has_GUI =False;
   
   name = new_name;
   P=new_P;
   PrintManager = new_pm;
   SIM = new_sim;
   Excuse_TIME = new_ET;
   GhostCarry = new_UGC;
   isActive = is_active;
   isDark = new_Dark;
   UseFed = new_Fed;
   UseFastClose = new_FastClose;
   UseBEClose = new_BEClose;
   ActiveTarget = new_ActiveTarget;
   DeactiveTarget = new_DeactiveTarget;
   Lot=new_LOT;
   
   //this_Aethas =& Aethas_BOT;
}
void CopyCat::~CopyCat(){
   ArrayFree(OpenFails);  
}
void CopyCat::set_isActive(bool new_val){isActive=new_val;}
void CopyCat::set_has_TI(bool new_val){has_TI=new_val;}
void CopyCat::set_TI_BOT(TI_TSL *new_bot){TI_BOT=new_bot;}

void CopyCat::SetOrder(bool buy,double sl,double ml,double be, double tp,double tsla,double min,bool isfed,bool isPE,int WLB_Time,double candle_size){
   string text = "SetOrder_";
   string text2 = "";

   int runs = 1;

   Order *order;
   if(buy){
      text += "BUY";
      ArrayResize(BUY_order,ArraySize(BUY_order)+1);
      order =& BUY_order[ArraySize(BUY_order)-1]; 
      order.set_orderopen(ASK);
      BUY_Pos+=1;
      order.set_Num(BUY_Pos);
      order.set_name("Buy_" + name + "_" + string(BUY_Pos));
   }
   else{
      text += "SELL";
      ArrayResize(SELL_order,ArraySize(SELL_order)+1);
      order =& SELL_order[ArraySize(SELL_order)-1];  
      order.set_orderopen(BID);
      SELL_Pos+=1;
      order.set_Num(SELL_Pos);
      order.set_name("Sell_" + name + "_" + string(SELL_Pos));
   }
   PrintManager.write_log(name,text,"","","","","","","","");   
   
   order.set_orderopentime(TIME);
   
   order.set_ordercommission(-0.06);
   order.set_Buy(buy);
   //order.Sell=!buy;
   
   if(isActive){
      order.set_Ghost(false);
   }
   else{
      order.set_Ghost(true);
   }
   order.set_SIM(SIM);
   if(Lot>0.01){
      order.set_Lot(Lot);
   }
   else{
      order.set_Lot(0.01);
   }
   order.set_OPEN(true);
   order.set_profit_MIN(min);
   order.set_profit_MAXLOSS(ml);
   order.set_profit_SL(sl);
   order.set_profit_BE(be);
   order.set_profit_TP(tp);
   
   if(!isfed && has_TI){
      order.set_profit_TP(tp*TI_BOT.get_TP_Factor());
   }
   order.set_TSL_Activate(tsla);
   //order.draw_SLLine = draw_slLine;
   //order.set_Line_Color(Line_Color_BUY);
   //order.set_Line_Style(Line_Style);                                                                                                                                                                                                                                                                                            
   //order.set_Line_Width(Line_Width);
   //order.draw_ghost = draw_ghostLine;
  
   /*order.draw_MINLine = draw_helpLines;
   order.draw_TSLALine = draw_helpLines;
   order.draw_MAXLine = draw_helpLines;
   order.draw_TPLine = draw_helpLines;*/
   order.set_TSL_ACTIVE(isfed);
   
   order.set_is_PE(isPE);
   order.set_WLB_Time(WLB_Time);
   order.set_candle_size(candle_size);   
   
   if(!order.create(TIME,ASK,BID)){
      if(order.get_failtime() == TIME){
         int size = ArraySize(OpenFails);
         ArrayResize(OpenFails,size+1);
         OpenFails[size] = order;
      }
   }
   else{
      if(isfed && has_TI){
         order.set_TSL_ACTIVE(true);
         TI_BOT.set_ASK(ASK);
         TI_BOT.set_BID(BID);
         TI_BOT.set_TIME(TIME);
         TI_BOT.Jungle_trigger(order,true);
      }
   }
   //Print("Setting Order with O:",order.orderopen);
   OrderSum_i+=1;
   
   
}

bool CopyCat::check_Order_MaxLoss(Order *this_order){
   string text = "B";
   string full_text="";
   if(!this_order.get_Buy()){
      text = "S";
   }      
   this_order.tick(TIME,ASK,BID); 
   if(this_order.check_MaxLoss(TIME,ASK,BID)){
      full_text = text + " MaxLoss Close";   
      PrintManager.write_log(name,full_text ,string(this_order.get_Num()),"","","","","","","");
      return(true);
   
   }
   return(false);
}

bool CopyCat::check_Order_SL(Order *this_order){
    
   this_order.tick(TIME,ASK,BID); 
   if(this_order.check_SL(TIME,ASK,BID)){
      if(this_order.get_ExcuseTime() == 0){
         this_order.set_ExcuseTime(TIME);
      }
      
      int delta = int(TIME - this_order.get_ExcuseTime());
      if(delta >= Excuse_TIME || (this_order.get_BE_SET() && UseBEClose)){
         string text = "B";
         string full_text="";
         if(!this_order.get_Buy()){
            text = "S";
         }  
         
         full_text = text + " SL Close";   
         PrintManager.write_log(name,full_text ,string(this_order.get_Num()),"","","","","","","");
         return(true);
      }
   }
   return(false);
}
bool CopyCat::check_Order_Fed(Order *this_order){     
   if(this_order.check_TSLA(TIME,ASK,BID)){
      return(true); 
   }
   return(false);
}

bool CopyCat::check_Order_FastClose(Order *this_order){  
   int delta = int(TIME)-int(this_order.get_orderopentime());
   if(delta>UseFastClose && this_order.getDelta(TIME,ASK,BID)<0){
      if(delta>UseFastClose*2){
         if(delta>UseFastClose*3){
            CloseOrder(this_order);
            return(true);
         }
         this_order.set_profit_MIN(this_order.get_profit_MIN()*-1);
      }   
   }   
   return(false);
}

void CopyCat::Tank_trigger(Order *this_order){
   if(!inSleepTime ){
      bool buy = this_order.get_Buy();
      if(isDark){
         buy =!this_order.get_Buy();
      }
      double sl = this_order.get_profit_SL();
      double ml = this_order.get_profit_MAXLOSS();
      double be = this_order.get_profit_BE();
      double tp = this_order.get_profit_TP();
      double tsla = this_order.get_profit_TP()*UseFed;
      double min = this_order.get_profit_MIN();
      //Print("Tanktrigger SetOrder@",ASK,"|",BID);
      SetOrder(buy,sl,ml,be,tp,tsla,min,false,this_order.get_is_PE(),this_order.get_WLB_Time(),this_order.get_candle_size());
   }    
}

void CopyCat::tick(datetime time,double ask,double bid){
   TIME = time;
   ASK = ask;
   BID = bid; 
   /*
   if(SleepT.check_time(this_Aethas.getTime(P,0)-3600)){//iTime(Symbol(),1,0)
      if(inSleepTime){

         PrintManager.write_log(name,"SleepTime END" ,"","","","","","","","");
         inSleepTime = false;
      }
   }
   else{
      if(inSleepTime==false){

         PrintManager.write_log(name,"SleepTime START" ,"","","","","","","","");
         inSleepTime = true;
      }
   }*/

   
   /*
   Order copy_fails[];
   int runs = ArraySize(OpenFails);
   for(int i=0;i<runs;i++){
      if(TIME-OpenFails[i].get_failtime()<60){
         bool buy = OpenFails[i].get_Buy();
         double sl = OpenFails[i].get_profit_SL();
         double ml = OpenFails[i].get_profit_MAXLOSS();
         double be = OpenFails[i].get_profit_BE();
         double tp = OpenFails[i].get_profit_TP()*UseFed;
         double tsla = 99999;
         double min = OpenFails[i].get_profit_MIN();
         bool tslactive = OpenFails[i].get_TSL_ACTIVE();
         //Print("RETRY Setorder");
         SetOrder(buy,sl,ml,be,tp,tsla,min,tslactive,OpenFails[i].get_is_PE(),OpenFails[i].get_WLB_Time(),OpenFails[i].get_candle_size());
      
         Print("Try to reopen");
         if(!OpenFails[i].get_OPEN()){
            Sleep(100);
            Print("retry after 100ms");
            SetOrder(buy,sl,ml,be,tp,tsla,min,tslactive,OpenFails[i].get_is_PE(),OpenFails[i].get_WLB_Time(),OpenFails[i].get_candle_size());
            if(!OpenFails[i].get_OPEN()){
               Print("reopen faild");
               ArrayResize(copy_fails,ArraySize(copy_fails)+1);
               copy_fails[ArraySize(copy_fails)-1] = OpenFails[i];
            }
            else{
               Print("reopen success");
               i=runs;
               break;
            }
         }
         else{
            Print("reopen success");
            i=runs;
            break;
         }
      }
   }
   ArrayFree(OpenFails);
   ArrayResize(OpenFails,ArraySize(copy_fails));
   for(int i=0;i<ArraySize(copy_fails);i++){
      OpenFails[i]=copy_fails[i];
   }
   ArrayFree(copy_fails);
   */
   
   
   
   DD=0;
   Order *this_order;
   
   Order new_order[];
   int size = 0;
   
   for(int i =0;i<ArraySize(BUY_order);i++){
      if(BUY_order[i].get_OPEN()){
         bool done = false;
         if(!BUY_order[i].get_Ghost()){ 
            if(OrderSelect(BUY_order[i].get_Num(), SELECT_BY_TICKET)){ 
               if(OrderCloseTime()>0){
                  this_order =& BUY_order[i];
                  if(OrderClosePrice() >= this_order.get_TP_val()-0.1){
                     Print(BUY_order[i].get_Num(), " - Order TP Close");
                  }
                  else{
                     if(OrderClosePrice() <= this_order.get_MAX_val()+0.1){
                        Print(BUY_order[i].get_Num(), " - Order SL Close");
                     }
                     else{   
                        Print(BUY_order[i].get_Num(), " - Order Manual Close");
                     }
                  }
                  CloseOrder(this_order);
                  done=true;
               }
               else{
                  DD+=BUY_order[i].getDelta(time, ask, bid)*BUY_order[i].get_Lot()*100;
               }
            }
            if(BUY_order[i].get_SIM()){
               DD+=BUY_order[i].getDelta(time, ask, bid)*BUY_order[i].get_Lot()*100;
            }
         }
         if(!done){
            this_order =& BUY_order[i];
            if(!check_Order(this_order)){
               size+=1;
               ArrayResize(new_order,size);
               new_order[size-1] = BUY_order[i];
               this_order =&BUY_order[i];
               Add_OrderSave(this_order);
               /*
               if(CheckPointer(SaveManager)!=POINTER_INVALID){   
                  SaveManager.add_OrderSave(name,true,BUY_order[i].Num,BUY_order[i].Ghost,
                              BUY_order[i].orderopentime,BUY_order[i].orderopen,BUY_order[i].ExcuseTime,
                              BUY_order[i].profit_MIN,BUY_order[i].profit_MAXLOSS,BUY_order[i].profit_SL,BUY_order[i].profit_BE,BUY_order[i].profit_TP,
                              BUY_order[i].BE_SET,BUY_order[i].TSL_ACTIVE,BUY_order[i].highest_DD,BUY_order[i].highest_P,BUY_order[i].TSL_Activate);
               }*/
            }
         }
      }
   }
   ArrayResize(BUY_order,ArraySize(new_order));
   for(int i=0;i<ArraySize(new_order);i++){
      BUY_order[i]=new_order[i];
   }
   ArrayResize(new_order,0);
   size = 0;
   for(int i =0;i<ArraySize(SELL_order);i++){
      if(SELL_order[i].get_OPEN()){
         bool done = false; 
         if(!SELL_order[i].get_Ghost()){
            if(OrderSelect(SELL_order[i].get_Num(), SELECT_BY_TICKET)){ 
               if(OrderCloseTime()>0){
                  this_order =& SELL_order[i];
                  
                  
                  this_order =& SELL_order[i];
                  if(OrderClosePrice() <= this_order.get_TP_val()+0.1){
                     Print(SELL_order[i].get_Num(), " - Order TP Close");
                  }
                  else{
                     if(OrderClosePrice() >= this_order.get_MAX_val()-0.1){
                        Print(SELL_order[i].get_Num(), " - Order SL Close");
                     }
                     else{   
                        Print(SELL_order[i].get_Num(), " - Order Manual Close");
                     }
                  }
                  CloseOrder(this_order);
                  done=true;
               }
               else{
                  DD+=SELL_order[i].getDelta(time, ask, bid)*SELL_order[i].get_Lot()*100;
               }
            }
            if(SELL_order[i].get_SIM()){
               DD+=SELL_order[i].getDelta(time, ask, bid)*SELL_order[i].get_Lot()*100;
            }
         }
         if(!done){
            this_order =& SELL_order[i];
            if(!check_Order(this_order)){
               size+=1;
               ArrayResize(new_order,size);
               new_order[size-1] = SELL_order[i];
               this_order =&SELL_order[i];
               Add_OrderSave(this_order);
               /*if(CheckPointer(SaveManager)!=POINTER_INVALID){   
                  SaveManager.add_OrderSave(name,false,SELL_order[i].Num,SELL_order[i].Ghost,
                              SELL_order[i].orderopentime,SELL_order[i].orderopen,SELL_order[i].ExcuseTime,
                              SELL_order[i].profit_MIN,SELL_order[i].profit_MAXLOSS,SELL_order[i].profit_SL,SELL_order[i].profit_BE,SELL_order[i].profit_TP,
                              SELL_order[i].BE_SET,SELL_order[i].TSL_ACTIVE,SELL_order[i].highest_DD,SELL_order[i].highest_P,SELL_order[i].TSL_Activate);
               }*/
            }
         }
      }
   }
   ArrayResize(SELL_order,ArraySize(new_order));
   for(int i=0;i<ArraySize(new_order);i++){
      SELL_order[i]=new_order[i];
   }
   ArrayFree(new_order);
   
   if(DD<highest_DD){
      highest_DD = DD;
   }
   if(CheckPointer(SaveManager)!=POINTER_INVALID){   
      SaveManager.add_CopyCatSave(name,isActive,g_ProfitCombo_i,g_LossCombo_i,Profits_SUM,highest_Loss,highest_P,highest_DD,HighestProfitDelta,HighestPoints,Profits_Pip,Profits_SIM,SIM_Volume,OrderSum_i);
   }
   else{
      Print("NO savemanager");
   }
   /*
   
   if(has_GUI){
      if(inSleepTime){
         GUI.set_Panel_State("SLEEP");
         //Print(name," SLEEPGUI");
      }
      else{
         if(isActive){
            if(this_Ave.get_SellPenalty_Time(AveIndex)>0){
               if(this_Ave.get_BuyPenalty_Time(AveIndex)>0){
                  GUI.set_Panel_State("BOTH");
               }
               else{
                  GUI.set_Panel_State("SELL"); 
               }
            }
            else{
               if(this_Ave.get_BuyPenalty_Time(AveIndex)>0){
                  GUI.set_Panel_State("BUY");
               }
               else{
                  GUI.set_Panel_State("OK");
               }
            }
            //Print(name," OKGUI");
         }
         else{
            GUI.set_Panel_State("OFF");
            //Print(name," OFFGUI");
         }
      }
      //GUI.set_IS_Label_Text(set_Text(string(g_ProfitCombo_i));
      GUI.set_IS_Label_Text(string(g_ProfitCombo_i));
      GUI.Update();
   }
   */
   
}
bool CopyCat::check_Order(Order *this_order){
   
   if(check_Order_MaxLoss(this_order)){
      bool result = CC_CloseOrder(this_order);
      //Print("Closing Order ML ",this_order.Num, " with profit:", this_order.Profit,"|O:",this_order.orderopen,"|C:",this_order.orderclose );
      return(result);
   }
   
   if(check_Order_SL(this_order)){
      bool result = CC_CloseOrder(this_order);
      //Print("Closing Order SL ",this_order.Num, " with profit:", this_order.Profit,"|O:",this_order.orderopen,"|C:",this_order.orderclose );
      return(result);
   }
   if(check_Order_FastClose(this_order)){
      
      bool result = CC_CloseOrder(this_order);
      //Print("Closing Order FC ",this_order.Num, " with profit:", this_order.Profit,"|O:",this_order.orderopen,"|C:",this_order.orderclose );
      return(result);
   }
   if(!this_order.get_TSL_ACTIVE() && has_TI && ((GhostCarry && this_order.get_Ghost()) || !this_order.get_Ghost())){
      
      if(check_Order_Fed(this_order)){
         //Print("CarryTrigger");
         TI_BOT.Jungle_trigger(this_order,false);
      }
   }
   else{
      if(this_order.check_TP(TIME,ASK,BID)){
         
         bool result = CC_CloseOrder(this_order);
         //Print("Closing Order TP ",this_order.Num, " with profit:", this_order.Profit,"|O:",this_order.orderopen,"|C:",this_order.orderclose );
         return(result);
         
         
      }
      else{
         if(this_order.get_TPCountdown()!=0){
            int delta_t = int(TIME-this_order.get_TPCountdown());
            if(delta_t>300){
               bool result = CC_CloseOrder(this_order);
               //Print("Closing Order TP ",this_order.Num, " with profit:", this_order.Profit,"|O:",this_order.orderopen,"|C:",this_order.orderclose );
               return(result);
            }
         }
      }
   }
   if(!this_order.get_BE_SET()){
      this_order.check_BE(TIME,ASK,BID);
   }
   
   
   return(false);
}



bool CopyCat::CC_CloseOrder(Order *this_order){

   bool result = CloseOrder(this_order);
   
   if(g_ProfitCombo_i >= ActiveTarget && isActive==false){
      isActive = true;
   }
   else{
      if(g_LossCombo_i >= DeactiveTarget && isActive){
         if(ActiveTarget!=0){
            isActive = false;
         }
      }
   }
   
   return(result);
}

