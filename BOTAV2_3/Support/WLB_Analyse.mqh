//+------------------------------------------------------------------+
//|                                                  WLB_Analyse.mqh |
//|                                       Copyright 2022, Heisl INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"

#property strict

#include <BOTAV2_3/Tank/Garen.mqh>

#include <BOTAV2_3/Support/Ave.mqh>

#include <BOTAV2_3/MISC/PrintManager.mqh>
#include <BOTAV2_3/MISC/SLEEPTIME.mqh>
#include <BOTAV2_3/MISC/SaveManager.mqh>

#include <BOTAV2_3/Support/WLB.mqh>

class WLB_Analyse{

   private:
   
      string name;
      ENUM_TIMEFRAMES P;
      
      //sleeptime SleepT;
      print_manager *PrintManager;
      save_manager *SaveManager;
      Ave *this_Ave;
      Aethas *this_Aethas;
      
      datetime TIME;
      double ASK;
      double BID;
      Candle CANDLE;
      bool new_candle;
      int candleCounter;
      
      //bool draw_breakLine_e;
      //bool draw_breakLine_pe;
      
      
      int UseWLBTimeOut;  
      double UseWLB_Percent;
      double UseWLB_Bonus;  
      double UseWLB_PE;   
      double UseWLB_BodyPercent;
      double UseWLB_BodyBigger;  
      double UseWLB_BodyMin;  

      int WLB_Mode;

      //color Line_Color_SELL;
      //color Line_Color_BUY;
      //ENUM_LINE_STYLE Line_Style;                                                                                                                                                                                                                                                                                            
      //int Line_Width;

      bool printLog;
      bool writeLog;
      
      datetime last_time;
      datetime last_min;
      //bool inSleepTime;
      
      WLB WLB_H_Level[];
      WLB WLB_L_Level[];
      int WLBH_Count;
      int WLBL_Count;
      int WLBH_Pos;
      int WLBL_Pos;
            
      Garen *Garen_Bot[];
      
      bool this_candle_WLB;
      WLB *this_WLB;
      
      
      
public:      

      WLB_Analyse(void);
      WLB_Analyse(string new_Name,ENUM_TIMEFRAMES new_P,print_manager *this_pm,int new_WLB_TimeOut,double new_WLB_Bonus,
                  double new_WLB_Percent,double new_WLB_BodyPercent,double new_WLB_BodyBigger,double new_PE_VAL,
                  int new_WLB_mode);
      ~WLB_Analyse(void);
      
      void clear(bool clearDrawing);
      
      void Tank_Trigger(WLB *checkthis_WLB,bool isPE);
      void Add_Garen(Garen *new_garen);
      void tick(datetime time,double ask,double bid);

      void getWLB();
      void setWLB(bool high);
      void updateWLB(); 
      
      void checkWLB();
      bool this_checkWLB_Time(WLB *checkthis_WLB);
      bool this_checkWLB(WLB *checkthis_WLB,bool isPE);
      
      ENUM_TIMEFRAMES get_P();
      string get_name();
      
      void hole_tick(double priceL,double priceH,datetime time);
      
      Candle *get_CANDLE();
      
      void set_TIME(datetime new_val);
      void set_SaveManager(save_manager *new_bot);
      
      void new_H(bool pe_hit,bool isreturn);
      void new_L(bool pe_hit,bool isreturn);
      //void check_draw();
};   

void WLB_Analyse::WLB_Analyse(){
   //SleepT = sleeptime();
   //inSleepTime = false;
   candleCounter = -1;
   this_candle_WLB = false;
   WLBH_Count = 0;
   WLBL_Count = 0;
   last_min = -1;
   
   WLBL_Pos=0;
   WLBH_Pos=0;
   
   this_Aethas =& Aethas_BOT;
   this_Ave =& Ave_BOT;
}
void WLB_Analyse::WLB_Analyse(string new_Name,ENUM_TIMEFRAMES new_P,print_manager *this_pm,int new_WLB_TimeOut,double new_WLB_Bonus,double new_WLB_Percent,double new_WLB_BodyPercent,double new_WLB_BodyBigger,double new_PE_VAL,int new_WLB_mode){
   candleCounter = -1;
   this_candle_WLB = false;
   WLBH_Count = 0;
   WLBL_Count = 0;
   last_min = -1;
   
   WLBL_Pos=0;
   WLBH_Pos=0;
   
   name = new_Name;
   P = new_P;
   PrintManager = this_pm;
   UseWLBTimeOut = new_WLB_TimeOut;
   UseWLB_Bonus = new_WLB_Bonus;
   UseWLB_Percent = new_WLB_Percent;
   UseWLB_BodyPercent = new_WLB_BodyPercent;
   UseWLB_BodyBigger = new_WLB_BodyBigger;
   UseWLB_PE = new_PE_VAL;
   WLB_Mode = new_WLB_mode;
   this_Aethas =& Aethas_BOT;
   this_Ave =& Ave_BOT;
}
void WLB_Analyse::~WLB_Analyse(){
   ArrayFree(WLB_H_Level);
   ArrayFree(WLB_L_Level);
   ArrayFree(Garen_Bot);
}

ENUM_TIMEFRAMES WLB_Analyse::get_P(){return(P);}
string WLB_Analyse::get_name(){return(name);}
Candle *WLB_Analyse::get_CANDLE(){
   Candle *this_candle =& CANDLE;
   return(this_candle);
}

void WLB_Analyse::set_TIME(datetime new_val){TIME=new_val;}      
void WLB_Analyse::set_SaveManager(save_manager *new_bot){SaveManager=new_bot;}      

void WLB_Analyse::new_H(bool pe_hit,bool isreturn){
   //Print("new_H");
   ArrayResize(WLB_H_Level,ArraySize(WLB_H_Level)+1);
   WLB_H_Level[ArraySize(WLB_H_Level)-1].set_isReturn(isreturn);
   WLB_H_Level[ArraySize(WLB_H_Level)-1].set_pe_hit(pe_hit);
   this_WLB =&WLB_H_Level[ArraySize(WLB_H_Level)-1];
}
void WLB_Analyse::new_L(bool pe_hit,bool isreturn){
   //Print("new_L");
   ArrayResize(WLB_L_Level,ArraySize(WLB_L_Level)+1);
   WLB_L_Level[ArraySize(WLB_L_Level)-1].set_isReturn(isreturn);
   WLB_L_Level[ArraySize(WLB_L_Level)-1].set_pe_hit(pe_hit);
   this_WLB =&WLB_L_Level[ArraySize(WLB_L_Level)-1];
}

void WLB_Analyse::clear(bool clearDrawing){
   //PrintManager.write_log(name,"clear","","","","","","","","");
   
   for(int i=0;i<ArraySize(WLB_H_Level);i++){
      if(clearDrawing){
         WLB_H_Level[i].clear();
      }
      else{
         /*if(WLB_H_Level[i].pe_hit==false){         
            WLB_H_Level[i].pe_line.Time2 = this_Aethas.getTime(P,0);
            if(WLB_H_Level[i].draw_pe_line){
               WLB_H_Level[i].pe_line.Update();
            }
         }
         if(WLB_H_Level[i].done==false){         
            WLB_H_Level[i].e_line.Time2 = this_Aethas.getTime(P,0);
            if(WLB_H_Level[i].draw_e_line){
               WLB_H_Level[i].e_line.Update();
            }
         }*/
      }   
   }
   for(int i=0;i<ArraySize(WLB_L_Level);i++){
      if(clearDrawing){
         WLB_L_Level[i].clear();
      }
      /*else{
         if(WLB_L_Level[i].pe_hit==false){         
            WLB_L_Level[i].pe_line.Time2 = this_Aethas.getTime(P,0);
            if(WLB_L_Level[i].draw_pe_line){
               WLB_L_Level[i].pe_line.Update();
            }
         }
         if(WLB_L_Level[i].done==false){         
            WLB_L_Level[i].e_line.Time2 = this_Aethas.getTime(P,0);
            if(WLB_L_Level[i].draw_e_line){
               WLB_L_Level[i].e_line.Update();
            }
         }
      }*/
   }
}
void WLB_Analyse::getWLB(){

   bool high = false;
   bool found = false;
   if(!this_candle_WLB){
      if(CANDLE.get_BullBear()==-1){
         //Print("Bear|",CANDLE.get_TopWick_Percent(),"|",UseWLB_Percent);
         if(CANDLE.get_TopWick_Percent()<=UseWLB_Percent){ 
            //Print("wick percent");
            double help_sum = this_Aethas.getHigh(P,1) - this_Aethas.getLow(P,1);
            if(CANDLE.get_CandleSum()>(help_sum*UseWLB_BodyBigger)){ 
               //Print("bigger");
               if(CANDLE.get_Body_Percent()>UseWLB_BodyPercent){ 
                  //Print("body percent");
                  if(CANDLE.get_CandleSum()>UseWLB_BodyMin){ 
                     this_candle_WLB = true;
                     ArrayResize(WLB_H_Level,ArraySize(WLB_H_Level)+1);
                     this_WLB =& WLB_H_Level[ArraySize(WLB_H_Level)-1];
                     //Print("new WLB_H");
                     setWLB(true);
                  }
               }
            }
         }
      }
      else{
         if(CANDLE.get_BullBear()==1){
            if(CANDLE.get_BotWick_Percent()<=UseWLB_Percent){ 
               if(CANDLE.get_Body_Percent()>UseWLB_BodyPercent){ 
                  double help_sum = this_Aethas.getHigh(P,1) - this_Aethas.getLow(P,1);
                  if(CANDLE.get_CandleSum()>(help_sum*UseWLB_BodyBigger)){ 
                     if(CANDLE.get_CandleSum()>UseWLB_BodyMin){ 
                        this_candle_WLB = true;
                        
                        ArrayResize(WLB_L_Level,ArraySize(WLB_L_Level)+1);
                        this_WLB =& WLB_L_Level[ArraySize(WLB_L_Level)-1];
                        //Print("new WLB_L");
                        setWLB(false);
                     }
                  }
               }
            }
         }
      }
   }
   else{
      updateWLB();
   }
}
void WLB_Analyse::setWLB(bool high){   
   int other_WLB_Count = 0;
   string text = "";
   string full_name = "";
   
   bool isreturn =false;
   //color this_color;
   if(high){
      text = "WLB_S";
      //this_color = Line_Color_SELL;
      WLBH_Count+=1;
      other_WLB_Count = WLBL_Count;
      WLBH_Pos +=1;
      full_name = text + name +"_" + string(WLBH_Pos);
   }
   else{
      text = "WLB_B";
      //this_color = Line_Color_BUY;
      WLBL_Count+=1;
      other_WLB_Count = WLBH_Count;
      WLBL_Pos +=1;
      full_name = text + name +"_" + string(WLBL_Pos);
   }
   if(other_WLB_Count>0){
       isreturn = true;
   }

   
   this_WLB.set_wlb(full_name,P,!high,TIME,this_Aethas,isreturn);
   this_WLB.create();
   
   PrintManager.write_log(name,text + " Create" ,this_WLB.get_name(),"","","","","","","");
   updateWLB();
}

void WLB_Analyse::updateWLB(){  
   this_WLB.setCandle();
               
   if(!this_WLB.get_Buy()){
      if(WLB_Mode==0){
         this_WLB.set_entry(CANDLE.get_Open() - (CANDLE.get_CandleSum()*UseWLB_Bonus));
         this_WLB.set_pre_entry(CANDLE.get_Open() - ((CANDLE.get_CandleSum()/100)* UseWLB_PE));
      }
      else{
         this_WLB.set_entry(CANDLE.get_High() - (CANDLE.get_CandleSum()*UseWLB_Bonus));
         this_WLB.set_pre_entry(CANDLE.get_High() - ((CANDLE.get_CandleSum()/100)* UseWLB_PE));
      }
      
   }
   else{
      if(WLB_Mode==0){
         this_WLB.set_entry(CANDLE.get_Open() + (CANDLE.get_CandleSum()*UseWLB_Bonus));
         this_WLB.set_pre_entry(CANDLE.get_Open() + ((CANDLE.get_CandleSum()/100)* UseWLB_PE));  
      }
      else{
         this_WLB.set_entry(CANDLE.get_Low() + (CANDLE.get_CandleSum()*UseWLB_Bonus));
         this_WLB.set_pre_entry(CANDLE.get_Low() + ((CANDLE.get_CandleSum()/100)* UseWLB_PE));       
      }            
   }   
   /*if(!this_WLB.e_hit){
      this_WLB.e_line.Time1 = CANDLE.get_Time();
      this_WLB.e_line.Time2 = CANDLE.get_Time()+999999;
      this_WLB.e_line.Price1 = this_WLB.entry;
      this_WLB.e_line.Price2 = this_WLB.entry;
      if(this_WLB.draw_e_line){
         this_WLB.e_line.Update();

      }
   }
   if(!this_WLB.pe_hit){
      this_WLB.pe_line.Time1 = CANDLE.get_Time();
      this_WLB.pe_line.Time2 = CANDLE.get_Time()+999999;
      this_WLB.pe_line.Price1 = this_WLB.pre_entry;
      this_WLB.pe_line.Price2 = this_WLB.pre_entry;
   
      if(this_WLB.draw_pe_line){
         this_WLB.pe_line.Update();
      }
   }*/
   

}


void WLB_Analyse::checkWLB(){
   for(int i = 0;i<ArraySize(WLB_H_Level);i++){
      if(WLB_H_Level[i].get_done()==false){
         WLB *checkthis_WLB =& WLB_H_Level[i];
         if(this_checkWLB_Time(checkthis_WLB)){
            WLBH_Count-=1;
         }
         else{
            if(this_checkWLB(checkthis_WLB,false)){
               WLBH_Count-=1;
               Tank_Trigger(checkthis_WLB,false);
               
            }
            else{
               
               if(!checkthis_WLB.get_pe_hit()){
                  if(this_checkWLB(checkthis_WLB,true)){
                     Tank_Trigger(checkthis_WLB,true);
                  }
               }
            }
         }
      }
   }
   for(int i =0;i<ArraySize(WLB_L_Level);i++){
      if(WLB_L_Level[i].get_done()==false){
         WLB *checkthis_WLB =& WLB_L_Level[i];
         if(this_checkWLB_Time(checkthis_WLB)){
            WLBL_Count-=1;
         }
         else{
            if(this_checkWLB(checkthis_WLB,false)){
               WLBL_Count-=1;
               
               Tank_Trigger(checkthis_WLB,false);

            }
            else{
               if(!checkthis_WLB.get_pe_hit()){
                  if(this_checkWLB(checkthis_WLB,true)){
                     Tank_Trigger(checkthis_WLB,true);
                  }
               }   
            }
         }
      }
   }
}
bool WLB_Analyse::this_checkWLB_Time(WLB *checkthis_WLB){
   string text = "S";
   string full_text;
   if(!checkthis_WLB.get_Buy()){
      text = "H";
   }
   if(checkthis_WLB.check_timeout(TIME,UseWLBTimeOut)){

      checkthis_WLB.set_done(true);
      full_text = "WLB "+text+" E-TimeOut";
      PrintManager.write_log(name,full_text ,checkthis_WLB.get_name(),"","","","","","","");       
      /*if(checkthis_WLB.pe_hit==false){
         checkthis_WLB.pe_line.Time2 = TIME;
         if(checkthis_WLB.draw_pe_line){
            checkthis_WLB.pe_line.Update();
         }
      }

      checkthis_WLB.e_line.Time2 = TIME;
      
      if(checkthis_WLB.draw_e_line){
         checkthis_WLB.e_line.Update();
      }*/
      return(true);
   }
   return(false);
}
bool WLB_Analyse::this_checkWLB(WLB *checkthis_WLB,bool isPE){
   string text = "WLB S";
   if(!checkthis_WLB.get_Buy()){
      text = "WLB H";
   }
   if(isPE){
      text+=" PE-";
      if(checkthis_WLB.get_pe_hit()==false){
         if(checkthis_WLB.check_pehit(TIME,ASK,BID)){  
            text +="Hit";
            PrintManager.write_log(name,text,checkthis_WLB.get_name(),"","","","","","","");  
            return(true);
         }
      }
   }
   else{
      text+=" E-";
      if(checkthis_WLB.get_e_hit()==false){
         if(checkthis_WLB.check_ehit(TIME,ASK,BID)){  
            text +="Hit";
            PrintManager.write_log(name,text,checkthis_WLB.get_name(),"","","","","","","");  
            checkthis_WLB.set_done(true);
            //checkthis_WLB.clear();
            return(true);
         }
      }
   }
   
   
   return(false);
}
void WLB_Analyse::Tank_Trigger(WLB *checkthis_WLB,bool isPE){
   for(int i=0;i<ArraySize(Garen_Bot);i++){
      Garen_Bot[i].WLB_trigger(checkthis_WLB,isPE);
   }
}
void WLB_Analyse::Add_Garen(Garen *new_garen){
   int size = ArraySize(Garen_Bot);
   ArrayResize(Garen_Bot,size+1);
   Garen_Bot[size] = new_garen;
}


void WLB_Analyse::tick(datetime time,double ask,double bid){
   TIME = time;
   ASK = ask;
   BID = bid;

   /*if(SleepT.check_time(this_Aethas.getTime(PERIOD_M1,0)-3600)){//iTime(Symbol(),1,0)
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
   } */
   

   datetime this_time = this_Aethas.getTime(P,0);//iTime(Symbol(),P,getCandle_byTime(TIME,P));//check_newcandle(P,last_time);
   if(this_time != last_time){
      new_candle = true;
      candleCounter+=1;
      last_time = this_time;
      CANDLE.setCandle(BID,BID,BID,BID,TIME);
      this_candle_WLB = false;  
      
      UseWLB_BodyMin = this_Ave.getCandle(P)*0.84;
      if(UseWLB_BodyMin < 4*this_Ave.get_Spread()){
         UseWLB_BodyMin = 4*this_Ave.get_Spread();
      }
   }
   else{
      new_candle = false;
      if(BID>CANDLE.get_High()){
         CANDLE.set_High(BID);
      }
      if(BID<CANDLE.get_Low()){
         CANDLE.set_Low(BID);
      }
      CANDLE.set_Close(BID);
   }
   checkWLB();
   getWLB(); 
   if(CheckPointer(SaveManager)!=POINTER_INVALID){ 
      
      for(int i = 0;i<ArraySize(WLB_H_Level);i++){
         if(!WLB_H_Level[i].get_done()){
            Candle *this_candle =  WLB_H_Level[i].get_candle();
            SaveManager.add_WLBSave(name,this_candle.get_Open(),this_candle.get_Close(),this_candle.get_High(),this_candle.get_Low(),this_candle.get_Time(),WLB_H_Level[i].get_isReturn(),WLB_H_Level[i].get_pe_hit());
         }
      }
      
      for(int i = 0;i<ArraySize(WLB_L_Level);i++){
         if(!WLB_L_Level[i].get_done()){
            Candle *this_candle =  WLB_L_Level[i].get_candle();
            SaveManager.add_WLBSave(name,this_candle.get_Open(),this_candle.get_Close(),this_candle.get_High(),this_candle.get_Low(),this_candle.get_Time(),WLB_L_Level[i].get_isReturn(),WLB_L_Level[i].get_pe_hit());
         }
      }
   }
   /*if(Draw_Limit){
      check_draw();
   }*/
}
/*
void WLB_Analyse::check_draw(){
   bool sleeping = Garen_Bot[0].get_inSleepTime();
   bool isActive = Garen_Bot[0].Copy_Bot[0].isActive;
   int min_time = Garen_Bot[0].UseWLBMinTime;
   int max_time = Garen_Bot[0].UseWLBTimeOut;
   bool ok = false;
   for(int i = 0;i<ArraySize(WLB_H_Level);i++){
      int runtime = int(TIME - WLB_H_Level[i].creation_time);
      if(sleeping || !isActive){
         ok = false;   
      }
      else{
         if(runtime>min_time && runtime <max_time){
            ok = true;
         }
         else{
            ok = false;
         }
      }
      
      if(ok){
         if(WLB_H_Level[i].draw_pe_line){
            WLB_H_Level[i].pe_line.Update();   
         }
         if(WLB_H_Level[i].draw_e_line){
            WLB_H_Level[i].e_line.Update();   
         }
      }
      else{
         if(WLB_H_Level[i].draw_e_line){
            WLB_H_Level[i].clear(); 
         }
         if(WLB_H_Level[i].draw_pe_line){
            WLB_H_Level[i].clear();     
         } 
      }
   }
   
   for(int i = 0;i<ArraySize(WLB_L_Level);i++){
      int runtime = int(TIME - WLB_L_Level[i].creation_time);
      if(sleeping || !isActive){
         ok = false;   
      }
      else{
         if(runtime>min_time && runtime <max_time){
            ok = true;
         }
         else{
            ok = false;
         }
      }
      
      if(ok){
         if(WLB_L_Level[i].draw_pe_line){
            WLB_L_Level[i].pe_line.Update();   
         }
         if(WLB_L_Level[i].draw_e_line){
            WLB_L_Level[i].e_line.Update();   
         }
      }
      else{
         if(WLB_L_Level[i].draw_e_line){
            WLB_L_Level[i].clear(); 
         }
         if(WLB_L_Level[i].draw_pe_line){
            WLB_L_Level[i].clear();     
         } 
      }
   }
}*/
void WLB_Analyse::hole_tick(double priceL,double priceH,datetime time){
   for(int j=0;j<ArraySize(WLB_L_Level);j++){
      if(!WLB_L_Level[j].get_pe_hit()){
         if(priceL<=WLB_L_Level[j].get_pre_entry()){
            WLB_L_Level[j].set_pe_hit(true);
            //WLB_L_Level[j].pe_line.Time2 = time;
         
            /*if(WLB_L_Level[j].draw_pe_line){
            //Print("mainUpdate26");
               WLB_L_Level[j].pe_line.Update();   
            }*/
         }
      }
      if(!WLB_L_Level[j].get_e_hit()){
         if(priceL<=WLB_L_Level[j].get_entry()){
            WLB_L_Level[j].set_e_hit(true);
           // WLB_L_Level[j].e_line.Time2 = time;
         
            /*if(WLB_L_Level[j].draw_e_line){
               //Print("mainUpdate27");
               WLB_L_Level[j].e_line.Update();   
            }*/
         }
      }
   }
   
   for(int j=0;j<ArraySize(WLB_H_Level);j++){
      if(!WLB_H_Level[j].get_pe_hit()){
         if(priceH>=WLB_H_Level[j].get_pre_entry()){
            WLB_H_Level[j].set_pe_hit(true);
            /*WLB_H_Level[j].pe_line.Time2 = time;
         
            if(WLB_H_Level[j].draw_pe_line){
               //Print("mainUpdate28");
               WLB_H_Level[j].pe_line.Update();   
            }*/
         }
      }
      if(!WLB_H_Level[j].get_e_hit()){
         if(priceH>=WLB_H_Level[j].get_entry()){
            WLB_H_Level[j].set_e_hit(true);
            /*WLB_H_Level[j].e_line.Time2 = time;
         
            if(WLB_H_Level[j].draw_e_line){
               //Print("mainUpdate29");
               WLB_H_Level[j].e_line.Update();   
            }*/
         }
      }
   }
}