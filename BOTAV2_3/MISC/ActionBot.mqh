//+------------------------------------------------------------------+
//|                                                    ActionBot.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/MISC/Order.mqh>
//#include <BOTAV2_3/MISC/CSV.mqh>
#include <BOTAV2_3/MISC/GEO.mqh>
#include <BOTAV2_3/MISC/SLEEPTIME.mqh>
#include <BOTAV2_3/Support/Ave.mqh>
#include <BOTAV2_3/Support/Aethas.mqh>
#include <BOTAV2_3/MISC/SaveManager.mqh>

class ActionBot{
      protected:
      
      ENUM_TIMEFRAMES P;

      sleeptime SleepT;
      
      save_manager *SaveManager;
      
      bool SIM;
      bool inSleepTime;
      bool inBOTSleepTime;
      
      string BOT_exe_time1_start;
      string BOT_exe_time1_end;
      
      string BOT_exe_time2_start;
      string BOT_exe_time2_end;
      
      string BOT_exe_time3_start;
      string BOT_exe_time3_end;
      
      string BOT_exe_time4_start;
      string BOT_exe_time4_end;
      
      string BOT_exe_time5_start;
      string BOT_exe_time5_end;
      
      int Excuse_TIME;
      
      bool UseBEClose;

      Ave *this_Ave;
      Aethas *this_Aethas;
      Order BUY_order[];
      Order SELL_order[];
      int BUY_Pos;
      int SELL_Pos;
      
      double Profits_BUY;
      double Profits_SELL;
      double Profits_SUM;
      double Profits_Pip;
      double Profits_SIM;
      
      double Points;
      double HighestPoints;
      
      double highest_P;
      double highest_Loss;
      double highest_DD;
      
      /*double D1_Profits_SUM;
      double D1_highest_P;
      double D1_highest_Loss;
      double D1_highest_DD;
      double D1_HighestProfitDelta;

      double H4_Profits_SUM;
      double H4_highest_P;
      double H4_highest_Loss;
      double H4_highest_DD;
      double H4_HighestProfitDelta;*/
               
      int OrderSum_i;

      double LossCombo;
      int LossCombo_i;
      double ProfitCombo;
      int ProfitCombo_i;
      double HighestLossCombo;
      double HighestProfitCombo;
      double Last_Profit;
      double HighestProfitDelta;
      
      double g_Profits_BUY;
      double g_Profits_SELL;
      double g_Profits_SUM;
      double g_Profits_Pip;
      double g_Profits_SIM;
     
      
      double g_Points;
      double g_HighestPoints;
      
      double g_highest_P;
      double g_highest_Loss;
     
      /*double g_D1_Profits_SUM; 
      double g_D1_highest_P;
      double g_D1_highest_Loss;
      double g_D1_HighestProfitDelta;
      
      double g_H4_Profits_SUM; 
      double g_H4_highest_P;
      double g_H4_highest_Loss;
      double g_H4_HighestProfitDelta;*/
      
      int g_OrderSum_i;

      double g_LossCombo;
      int g_LossCombo_i;
      double g_ProfitCombo;
      int g_ProfitCombo_i;
      double g_HighestLossCombo;
      double g_HighestProfitCombo;
      double g_Last_Profit;
      double g_HighestProfitDelta;
      
      double DD;
      
      /*bool draw_helpLines;
      bool draw_slLine;
      bool draw_ghostLine;*/
      
      /*color Line_Color_SELL;
      color Line_Color_BUY;
      ENUM_LINE_STYLE Line_Style;                                                                                                                                                                                                                                                                                            
      int Line_Width;*/
   
      double Lot;
      int Lot_Divider;
   
      datetime TIME;
      double ASK;
      double BID;
      
      print_manager *PrintManager;
      string name;
      
      double SIM_Volume;
      
      public:

      
      bool CloseOrder(Order *this_order);
      /*void D1_Trigger();
      void H4_Trigger();*/
      void clear();
      void clear_SleepT();
      
      void init_sleeptime();
      
      
      void add_newProfit(double newProfit,double newProfit_pip,double newProfit_SIM,double &SUM,double &SUM_pip,double &SUM_SIM,double &HL,double &HP,double &HPD);
      void add_ALLnewProfit(double newProfit,double newProfit_pip,double newProfit_SIM,bool Ghost);
      void Add_OrderSave(Order *this_order);
      void check_Sleep();
      
      
      
      
      ActionBot(void);
      ~ActionBot(void);
      
      ENUM_TIMEFRAMES get_P();
      string get_name();
      double get_Points();
      double get_HighestProfitDelta();
      double get_Profits_SUM();
      double get_Profits_Pip();
      double get_Profits_SIM();
      double get_highest_Loss();
      double get_highest_P();
      double get_highest_DD();
      double get_DD();
      double get_HighestPoints();
      double get_g_Profits_SUM();
      double get_g_Profits_Pip();
      double get_g_highest_Loss();
      double get_g_highest_P();
      double get_g_HighestPoints();
      double get_g_Points();
      double get_g_HighestProfitDelta();
      int get_BUY_pos();
      int get_SELL_pos();
      Order *get_BUY_order(int pos);
      Order *get_SELL_order(int pos);
      int get_Excuse_TIME();
      int get_OrderSum_i(void);
      bool get_UseBEClose();
      double get_SIM_Volume();
      int get_Lot_Divider();
      void set_P(ENUM_TIMEFRAMES new_p);
      void set_SleepT();
      void set_SIM(bool new_sim);
      void set_PrintManager(print_manager *new_pm);
      void set_SaveManager(save_manager *new_bot);
      void set_Ave(Ave *new_bot);
      void set_Aethas(Aethas *new_bot);
      void set_name(string new_val);
      void set_Points(double new_val);
      void set_g_Points(double new_val);
      void set_TIME(datetime new_val);
      void set_ASK(double new_val);
      void set_BID(double new_val);
      void set_inSleepTime(bool new_val);
      void set_BOT_exe_time1_start(string new_val);
      void set_BOT_exe_time1_end(string new_val);
      void set_Excuse_TIME(int new_val);
      void set_UseBEClose(bool new_val);
      
      

      
      void set_g_Profits_SUM(double new_val);
      void set_g_highest_Loss(double new_val);
      void set_g_highest_P(double new_val);
      void set_highest_DD(double new_val);
      void set_g_HighestProfitDelta(double new_val);
      void set_g_HighestPoints(double new_val);
      void set_g_ProfitCombo_i(int new_val);
      void set_g_LossCombo_i(int new_val);
      void set_g_Profits_Pip(double new_val);
      void set_g_Profits_SIM(double new_val);
      
      void set_Profits_SUM(double new_val);
      void set_highest_Loss(double new_val);
      void set_highest_P(double new_val);
      void set_HighestProfitDelta(double new_val);
      void set_HighestPoints(double new_val);
      void set_Profits_Pip(double new_val);
      void set_Profits_SIM(double new_val);
      void set_SIM_Volume(double new_val);
      void set_Lot(double new_val);
      void set_Lot_Divider(int new_val);
      void set_OrderSum_i(int new_val);
      
      void check_Buy_order(double priceH,double priceL,datetime time);
      void check_Sell_order(double priceH,double priceL,datetime time);
      
      void add_SleepTwindow(datetime start_time,datetime end_time);
};

void ActionBot::ActionBot(){
   this_Aethas =& Aethas_BOT;
   SleepT = sleeptime();
   BOT_exe_time1_start   = "1:10";
   BOT_exe_time1_end   = "23:50";
   
   BOT_exe_time2_start   = "";
   BOT_exe_time2_end   = "";
   
   BOT_exe_time3_start   = "";
   BOT_exe_time3_end   = "";
   
   BOT_exe_time4_start   = "";
   BOT_exe_time4_end   = "";
   
   BOT_exe_time5_start   = "";
   BOT_exe_time5_end   = "";
   
   
   Profits_BUY=0;
   Profits_SELL=0;
   Profits_SUM=0;
   Profits_Pip=0;
   Points=0;
   HighestPoints=0;
   
   highest_P=0;
   highest_Loss=0;
   highest_DD=0;
   
   OrderSum_i=0;

   LossCombo=0;
   LossCombo_i=0;
   ProfitCombo=0;
   ProfitCombo_i=0;
   HighestLossCombo=0;
   HighestProfitCombo=0;
   Last_Profit=0;
   HighestProfitDelta = 0;
   g_Profits_BUY=0;
   g_Profits_SELL=0;
   g_Profits_SUM=0;
   g_Profits_Pip=0;
   g_Points=0;
   g_HighestPoints=0;
   
   g_highest_P=0;
   g_highest_Loss=0;
   
   g_OrderSum_i=0;

   g_LossCombo=0;
   g_LossCombo_i=0;
   g_ProfitCombo=0;
   g_ProfitCombo_i=0;
   g_HighestLossCombo=0;
   g_HighestProfitCombo=0;
   g_Last_Profit=0;
   g_HighestProfitDelta = 0;
   
   DD=0;
   
   SIM_Volume = 10000;
   Lot = 0.01;

   BUY_Pos=0;
   SELL_Pos=0;
   Lot_Divider=1.0;
}
void ActionBot::~ActionBot(){
   ArrayFree(SELL_order); 
   ArrayFree(BUY_order); 
}

ENUM_TIMEFRAMES ActionBot::get_P(){return(P);}
string ActionBot::get_name(){return(name);}
double ActionBot::get_Points(){return(Points);}
double ActionBot::get_HighestProfitDelta(){return(HighestProfitDelta);}
double ActionBot::get_Profits_SUM(){return(Profits_SUM);}
double ActionBot::get_Profits_Pip(){return(Profits_Pip);}
double ActionBot::get_Profits_SIM(){return(Profits_SIM);}
double ActionBot::get_highest_Loss(){return(highest_Loss);}
double ActionBot::get_highest_P(){return(highest_P);}
double ActionBot::get_highest_DD(){return(highest_DD);}
double ActionBot::get_DD(){return(DD);}
double ActionBot::get_HighestPoints(){return(HighestPoints);}
double ActionBot::get_g_Profits_SUM(){return(g_Profits_SUM);}
double ActionBot::get_g_Profits_Pip(){return(g_Profits_Pip);}
double ActionBot::get_g_highest_Loss(){return(g_highest_Loss);}
double ActionBot::get_g_highest_P(){return(g_highest_P);}
double ActionBot::get_g_HighestPoints(){return(g_HighestPoints);}
double ActionBot::get_g_Points(){return(g_Points);}
double ActionBot::get_g_HighestProfitDelta(){return(g_HighestProfitDelta);}
int ActionBot::get_BUY_pos(){return(BUY_Pos);}
int ActionBot::get_SELL_pos(){return(SELL_Pos);}
int ActionBot::get_Excuse_TIME(void){return(Excuse_TIME);}
int ActionBot::get_OrderSum_i(void){return(OrderSum_i);}
bool ActionBot::get_UseBEClose(void){return(UseBEClose);}
double ActionBot::get_SIM_Volume(){return(SIM_Volume);}
int ActionBot::get_Lot_Divider(){return(Lot_Divider);}

Order *ActionBot::get_BUY_order(int pos){
   Order *this_order = NULL;
   if(pos<ArraySize(BUY_order)){
      this_order =& BUY_order[pos];
   }
   return(this_order);   
}
Order *ActionBot::get_SELL_order(int pos){
   Order *this_order = NULL;
   if(pos<ArraySize(SELL_order)){
      this_order =& SELL_order[pos];
   }
   return(this_order);
}
void ActionBot::set_P(ENUM_TIMEFRAMES new_p){P=new_p;}
void ActionBot::set_SleepT(){SleepT=SleepTime;}
void ActionBot::set_SIM(bool new_sim){SIM=new_sim;}
void ActionBot::set_PrintManager(print_manager *new_pm){PrintManager=new_pm;}
void ActionBot::set_SaveManager(save_manager *new_bot){SaveManager=new_bot;}
void ActionBot::set_Ave(Ave *new_bot){this_Ave=new_bot;}
void ActionBot::set_Aethas(Aethas *new_bot){this_Aethas=new_bot;}
void ActionBot::set_name(string new_val){name=new_val;}
void ActionBot::set_Points(double new_val){Points=new_val;}
void ActionBot::set_g_Points(double new_val){g_Points=new_val;}
void ActionBot::set_TIME(datetime new_val){TIME=new_val;}
void ActionBot::set_ASK(double new_val){ASK=new_val;}
void ActionBot::set_BID(double new_val){BID=new_val;}
void ActionBot::set_Lot(double new_val){Lot=new_val;}
void ActionBot::set_Lot_Divider(int new_val){Lot_Divider=new_val;}
void ActionBot::set_inSleepTime(bool new_val){inSleepTime=new_val;}
void ActionBot::set_BOT_exe_time1_start(string new_val){BOT_exe_time1_start=new_val;}
void ActionBot::set_BOT_exe_time1_end(string new_val){BOT_exe_time1_end=new_val;}      
void ActionBot::set_g_Profits_SUM(double new_val){g_Profits_SUM=new_val;} 
void ActionBot::set_g_highest_Loss(double new_val){g_highest_Loss=new_val;} 
void ActionBot::set_g_highest_P(double new_val){g_highest_P=new_val;} 
void ActionBot::set_highest_DD(double new_val){highest_DD=new_val;} 
void ActionBot::set_g_HighestProfitDelta(double new_val){g_HighestProfitDelta=new_val;} 
void ActionBot::set_g_HighestPoints(double new_val){g_HighestPoints=new_val;} 
void ActionBot::set_g_ProfitCombo_i(int new_val){g_ProfitCombo_i=new_val;} 
void ActionBot::set_g_LossCombo_i(int new_val){g_LossCombo_i=new_val;} 
void ActionBot::set_Profits_SUM(double new_val){Profits_SUM=new_val;} 
void ActionBot::set_highest_Loss(double new_val){highest_Loss=new_val;} 
void ActionBot::set_highest_P(double new_val){highest_P=new_val;} 
void ActionBot::set_HighestProfitDelta(double new_val){HighestProfitDelta=new_val;} 
void ActionBot::set_HighestPoints(double new_val){HighestPoints=new_val;} 
void ActionBot::set_Excuse_TIME(int new_val){Excuse_TIME=new_val;}
void ActionBot::set_UseBEClose(bool new_val){UseBEClose=new_val;}
void ActionBot::set_Profits_Pip(double new_val){Profits_Pip=new_val;} 
void ActionBot::set_Profits_SIM(double new_val){Profits_SIM=new_val;} 
void ActionBot::set_g_Profits_Pip(double new_val){g_Profits_Pip=new_val;} 
void ActionBot::set_g_Profits_SIM(double new_val){g_Profits_SIM=new_val;} 
void ActionBot::set_SIM_Volume(double new_val){SIM_Volume=new_val;} 
void ActionBot::set_OrderSum_i(int new_val){OrderSum_i=new_val;}

void ActionBot::add_SleepTwindow(datetime start_time,datetime end_time){
   SleepT.addwindow(start_time,end_time);
}

void ActionBot::clear_SleepT(){
   SleepT.clear_windows();
}
                        
bool ActionBot::CloseOrder(Order *this_order){
   string text = "CloseOrder_";
   if(this_order.get_OPEN()){
      if(this_order.CloseOrder(TIME,ASK,BID)){
      
         double this_profit = this_order.get_Profit();
         if(SIMULATION && !this_order.get_Ghost()){
            this_profit = this_order.get_Profit() * this_order.get_Lot() * 100;
            SIM_Volume+=this_profit;
         }
         double this_profit_pip = this_order.get_Profit_pip();
         double this_profit_sim = this_order.get_Profit_SIM();
         add_ALLnewProfit(this_profit,this_profit_pip,this_profit_sim,this_order.get_Ghost());
         
         if(this_profit_pip<0){
            g_LossCombo += this_profit_pip;
            g_ProfitCombo = 0.0;
            g_ProfitCombo_i=0;
            g_LossCombo_i+=1;
            if(g_LossCombo<g_HighestLossCombo){
               g_HighestLossCombo=g_LossCombo;
            }
         }
         if(this_profit_pip>0){
            g_ProfitCombo += this_profit_pip;
            g_LossCombo = 0.0;
            g_ProfitCombo_i+=1;
            g_LossCombo_i=0;
            if(g_ProfitCombo>g_HighestProfitCombo){
               g_HighestProfitCombo=g_ProfitCombo;
            }  
         }
         if(g_HighestProfitDelta>1){
            g_Points = (g_Profits_SUM/g_HighestProfitDelta)*10;
            if(g_Points <0.5){
               g_Points = -2;
            }
         }
         else{
            g_Points = -1;
         }
         if(!this_order.get_Ghost()){
            if(this_profit_pip<0){
               LossCombo += this_profit_pip;
               ProfitCombo = 0.0;
               ProfitCombo_i=0;
               LossCombo_i+=1;
               if(LossCombo<HighestLossCombo){
                  HighestLossCombo=LossCombo;
               }
            }
            if(this_profit_pip>0){  
               ProfitCombo += this_profit_pip;
               LossCombo = 0.0;
               ProfitCombo_i+=1;
               LossCombo_i=0;
               if(ProfitCombo>HighestProfitCombo){
                  HighestProfitCombo=ProfitCombo;
               }
            }
            if(HighestProfitDelta>1){
               Points = (Profits_SUM/HighestProfitDelta)*10;
               if(Points <0.5){
                  Points = -2;
               }
            }
            else{
               Points = -1;
            }
         }
         string text_ghost= ""; 
         if(this_order.get_SIM()){
            text_ghost= "SIM_";
         }
   
         if(this_order.get_Ghost()){
            text_ghost += "GHOST";
         }
         else{
            text_ghost += "REAL";
         }
         
         PrintManager.write_data( name,text_ghost ,"",text,string(this_order.get_Num()),
                              string(this_order.get_orderopentime()),string(this_order.get_orderopen()),string(TIME),
                              string(this_order.get_orderclose()),string(this_profit),
                              string(this_order.get_highest_Profit()),string(this_order.get_highest_Loss()));
   
         Last_Profit = this_profit;
         return(true);
      }
      else{
         return(false);
      }
   }
   return(true);
}
void ActionBot::clear(){
   PrintManager.write_log(name,"clear","","","","","","","","");
}
/*void ActionBot::D1_Trigger(){
    D1_Profits_SUM = 0;
    D1_highest_P = 0;
    D1_highest_Loss = 0;
    D1_highest_DD = 0;
    D1_HighestProfitDelta = 0;
         
    g_D1_Profits_SUM = 0; 
    g_D1_highest_P = 0;
    g_D1_highest_Loss = 0;
    g_D1_HighestProfitDelta = 0;
}
void ActionBot::H4_Trigger(){
    H4_Profits_SUM = 0;
    H4_highest_P = 0;
    H4_highest_Loss = 0;
    H4_highest_DD = 0;
    H4_HighestProfitDelta = 0;
         
    g_H4_Profits_SUM = 0; 
    g_H4_highest_P = 0;
    g_H4_highest_Loss = 0;
    g_H4_HighestProfitDelta = 0;
}*/

void ActionBot::add_newProfit(double newProfit,double newProfit_pip,double newProfit_SIM,double &SUM,double &SUM_pip,double &SUM_SIM,double &HL,double &HP,double &HPD){
   SUM+=newProfit;
   SUM_pip+=newProfit_pip;
   SUM_SIM+=newProfit_SIM;
   if(SUM<HL){
      HL = SUM;
   }
   if(SUM>HP){
      HP = SUM;
   }
   else{
      double profit_delta = HP-SUM;
      if(profit_delta>HPD){
         HPD = profit_delta;
      }
   }
}
void ActionBot::add_ALLnewProfit(double newProfit,double newProfit_pip,double newProfit_SIM,bool Ghost){
   //add_newProfit(newProfit,newProfit_pip,g_D1_Profits_SUM,g_D1_highest_Loss,g_D1_highest_P,g_D1_HighestProfitDelta);
   //add_newProfit(newProfit,newProfit_pip,g_H4_Profits_SUM,g_H4_highest_Loss,g_H4_highest_P,g_H4_HighestProfitDelta);
   add_newProfit(newProfit,newProfit_pip,newProfit_SIM,g_Profits_SUM,g_Profits_Pip,g_Profits_SIM,g_highest_Loss,g_highest_P,g_HighestProfitDelta);
   if(!Ghost){
      //add_newProfit(newProfit,newProfit_pip,D1_Profits_SUM,D1_highest_Loss,D1_highest_P,D1_HighestProfitDelta);
      //add_newProfit(newProfit,newProfit_pip,H4_Profits_SUM,H4_highest_Loss,H4_highest_P,H4_HighestProfitDelta);
      add_newProfit(newProfit,newProfit_pip,newProfit_SIM,Profits_SUM,Profits_Pip,Profits_SIM,highest_Loss,highest_P,HighestProfitDelta);
   }
}

void ActionBot::Add_OrderSave(Order *this_order){
   if(CheckPointer(SaveManager)!=POINTER_INVALID){ 
      bool buy = false;
      if(this_order.get_Buy()){
         buy=true;
      }                                 
      SaveManager.add_OrderSave( name,                            buy,                       this_order.get_Num(),                     this_order.get_Ghost(),             this_order.get_orderopentime(),
                                 this_order.get_orderopen(),            this_order.get_ExcuseTime(),     this_order.get_profit_MIN(),              this_order.get_profit_MAXLOSS(),    this_order.get_profit_SL(),
                                 this_order.get_profit_BE(),            this_order.get_profit_TP(),      this_order.get_BE_SET(),                  this_order.get_TSL_Activate(),     
                                 this_order.get_TSL_Activate(),          this_order.get_Lot(),            this_order.get_Profit(),                  this_order.get_Profit_pip(),
                                 this_order.get_is_PE(),                this_order.get_candle_size(),    this_order.get_WLB_Time(),                this_order.get_Clear_Time(),        this_order.get_Clear_Val(),
                                 this_order.get_Clear_Val_Percent(),    this_order.get_highest_Loss(),   this_order.get_highest_Loss_Percent(),    this_order.get_highest_Profit(),    this_order.get_highest_Profit_Percent());
   }
}
         
         
void ActionBot::check_Sleep(){   
   //Print(name, "check");        
   if(SleepT.check_time(this_Aethas.getTime(PERIOD_M1,0))){
      if(inSleepTime){
         if(!SIMULATION){
            Print(name,"SleepTime END - ",this_Aethas.getTime(P,0));
         }
         PrintManager.write_log(name,"SleepTime END" ,"","","","","","","","");
         inSleepTime = false;
      }
   }
   else{
      if(inSleepTime==false){
         if(!SIMULATION){
            Print(name,"SleepTime Start - ",this_Aethas.getTime(P,0));
         }
         PrintManager.write_log(name,"SleepTime START" ,"","","","","","","","");
         inSleepTime = true;
      }
   }
}


void ActionBot::init_sleeptime(){ 
   
   string t1 ="";
   string t2 ="";
   string time_help[];
   string time_help2[];
   string sep = ":";
   ushort u_sep;
   datetime starttime;
   datetime endtime;
   MqlDateTime full_time;
   u_sep =StringGetCharacter(sep,0);
   
                        
   int window_count = 0;
   if(BOT_exe_time1_start!="" && BOT_exe_time1_end!=""){
      window_count+=1;
      if(BOT_exe_time2_start!="" && BOT_exe_time2_end!=""){
         window_count+=1;
         if(BOT_exe_time3_start!="" && BOT_exe_time3_end!=""){
            window_count+=1;
            if(BOT_exe_time4_start!="" && BOT_exe_time4_end!=""){
               window_count+=1;
               if(BOT_exe_time5_start!="" && BOT_exe_time5_end!=""){
                  window_count+=1;
               }
            }
         }
      }
   }
   

   
   for(int i =0;i<(window_count+1);i++){
      if(i==0){
         t1 = "0:00";
         t2 = BOT_exe_time1_start;
      }
      if(i==1){
         t1 = BOT_exe_time1_end;
         t2 = BOT_exe_time2_start;
      }
      if(i==2){
         t1 = BOT_exe_time2_end;
         t2 = BOT_exe_time3_start;
      }
      if(i==3){
         t1 = BOT_exe_time3_end;
         t2 = BOT_exe_time4_start;
      }
      if(i==4){
         t1 = BOT_exe_time4_end;
         t2 = BOT_exe_time5_start;
      }
      if(i==5){
         t1 = BOT_exe_time5_end;
         t2 = "23:59";
      }
      if(i==window_count){
         t2 = "23:59";
      }

      if(t1 != ""){
         StringSplit(t1,u_sep,time_help);
         
         
         TimeToStruct(Aethas_BOT.getTime(PERIOD_M1,0),full_time);
         //Print("AEThAS0: ", Aethas_BOT.getTime(PERIOD_M1,0));
         full_time.hour = int(time_help[0]);
         full_time.min = int(time_help[1]);
         full_time.sec = 0;
         
         starttime = StructToTime(full_time);
      
      
         if(t2 != ""){
            
            
            u_sep =StringGetCharacter(sep,0);
            
            StringSplit(t2,u_sep,time_help2);
            
            TimeToStruct(Aethas_BOT.getTime(PERIOD_M1,0),full_time);
            full_time.hour = int(time_help2[0]);
            full_time.min = int(time_help2[1]);
            full_time.sec = 0;
            
            endtime = StructToTime(full_time);
            
            SleepT.addwindow(starttime,endtime);
            //Print(name, " add sleeptime ",starttime, " - " , endtime);
         }
      }
   }
   /*Print(name," AS:",ArraySize(SleepT.TimeWindows));
   for(int i=0;i<ArraySize(SleepT.TimeWindows);i++){
      Print(SleepT.TimeWindows[i].TimeStart,"|",SleepT.TimeWindows[i].TimeEnd);
   }*/
}


void ActionBot::check_Buy_order(double priceH,double priceL,datetime time){
   for(int j=0;j<ArraySize(BUY_order);j++){
      if(BUY_order[j].get_OPEN()){
         if(priceL<=BUY_order[j].get_MAX_val()){
            Order *thisorder =& BUY_order[j];
            
            double price_sl = BUY_order[j].get_MAX_val();
            
            TIME = time;
            ASK = price_sl;
            BID = price_sl;
            
            CloseOrder(thisorder);
         }
         else{
            if(priceH>=BUY_order[j].get_TP_val()){
               Order *thisorder =& BUY_order[j];
               
               double price_tp = BUY_order[j].get_TP_val();
               
               TIME = time;
               ASK = price_tp;
               BID = price_tp;
               
               CloseOrder(thisorder);
            }
         }
      }
   }
}
void ActionBot::check_Sell_order(double priceH,double priceL,datetime time){
   for(int j=0;j<ArraySize(SELL_order);j++){
      if(SELL_order[j].get_OPEN()){
         if(priceH>=SELL_order[j].get_MAX_val()){
            Order *thisorder =& SELL_order[j];
            
            double price_sl = SELL_order[j].get_MAX_val();
            
            TIME = time;
            ASK = price_sl;
            BID = price_sl;
            
            CloseOrder(thisorder);
            //Print("GAREN Closing SOrder HOLE SL",thisorder.Num, " with profit:", thisorder.Profit,"|O:",thisorder.orderopen,"|C:",thisorder.orderclose );
         }
         else{
            if(priceL<=SELL_order[j].get_TP_val()){
               Order *thisorder =& SELL_order[j];
               
               double price_tp = SELL_order[j].get_TP_val();
               
               TIME = time;
               ASK = price_tp;
               BID = price_tp;
               
               CloseOrder(thisorder);
               //Print("GAREN Closing SOrder HOLE TP",thisorder.Num, " with profit:", thisorder.Profit,"|O:",thisorder.orderopen,"|C:",thisorder.orderclose );
            }
         }
      }
   }

}