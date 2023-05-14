//+------------------------------------------------------------------+
//|                                                     WLB_Type.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/MISC/CANDLE.mqh>
#include <BOTAV2_3/MISC/GEO.mqh>

#include <BOTAV2_3/Support/Aethas.mqh>

class WLB{

   private:
   
            //bool Sell;
            bool Buy;
   
            string name;
            
            ENUM_TIMEFRAMES P;
            
            Aethas *this_Aethas;
            
            bool done;
            
            bool isReturn;
            
            int E_check2_sum;
            int PE_check2_sum;
            
            double entry;
            bool e_hit;
            datetime e_time;
            
            double pre_entry;
            bool pe_hit;
            datetime pe_time;

            //bool draw_e_line;
            //bool draw_pe_line;
            
            Candle candle;
            datetime creation_time;
            
            //tline e_line;
            //tline pe_line;
            //color Line_Color;
            //ENUM_LINE_STYLE Line_Style;                                                                                                                                                                                                                                                                                            
            //int Line_Width;
            
public:

            void WLB();
            void ~WLB();
            
            void create();
            void clear();
            
            void setCandle();   
            bool check_pehit(datetime time,double ask,double bid);  
            bool check_ehit(datetime time,double ask,double bid);
            bool check_timeout(datetime time,int target);
            
            datetime get_e_time();
            datetime get_pe_time();
            datetime get_creation_time();
            bool get_isReturn();
            Candle *get_candle();
            bool get_Buy();
            bool get_done();
            bool get_pe_hit();
            string get_name();  
            bool get_e_hit();
            double get_pre_entry();
            double get_entry();

            void set_name(string new_val);
            void set_wlb(string new_name,ENUM_TIMEFRAMES new_P,bool new_buy,datetime new_creationTIME,Aethas *new_Aethas,bool new_return);
            void set_entry(double new_val);
            void set_pre_entry(double new_val);
            void set_done(bool new_val);
            void set_e_hit(bool new_val);
            void set_pe_hit(bool new_val);
            void set_isReturn(bool new_val);
};

void WLB::WLB(){ 
   E_check2_sum = 0;
   PE_check2_sum = 0;
   
   e_hit = false;
   pe_hit = false;
}
void WLB::~WLB(){
}

datetime WLB::get_e_time(){return(e_time);}
datetime WLB::get_pe_time(){return(pe_time);}
datetime WLB::get_creation_time(){return(creation_time);}
bool WLB::get_isReturn(){return(isReturn);}    
bool WLB::get_done(){return(done);}         
bool WLB::get_pe_hit(){return(pe_hit);}  
string WLB::get_name(){return(name);}  
bool WLB::get_e_hit(){return(e_hit);}  
double WLB::get_pre_entry(){return(pre_entry);}  
double WLB::get_entry(){return(entry);}  
            

void WLB::set_name(string new_val){name = new_val;}
void WLB::set_entry(double new_val){entry = new_val;}
void WLB::set_pre_entry(double new_val){pre_entry = new_val;}
void WLB::set_done(bool new_val){done = new_val;}
void WLB::set_e_hit(bool new_val){e_hit = new_val;}
void WLB::set_pe_hit(bool new_val){pe_hit = new_val;}
void WLB::set_isReturn(bool new_val){isReturn = new_val;}    
       
void WLB::set_wlb(string new_name,ENUM_TIMEFRAMES new_P,bool new_buy,datetime new_creationTIME,Aethas *new_Aethas,bool new_return){
   name = new_name;
   P=new_P;
   Buy = new_buy;
   creation_time = new_creationTIME;
   this_Aethas = new_Aethas;
   isReturn = new_return;
}


Candle *WLB::get_candle(){
   Candle *this_candle =& candle;
   return(this_candle);
}   
bool WLB::get_Buy(){return(Buy);} 

void WLB::create(){
   setCandle();

   /*e_line = tline("el_"+name,candle.get_Time(),entry,candle.get_Time()+999999,entry,false,false,Line_Color,Line_Style,Line_Width,true);
   
   if(draw_e_line){
      e_line.Update();
   }
   
   pe_line = tline("pel_"+name,candle.get_Time(),pre_entry,candle.get_Time()+999999,pre_entry,false,false,Line_Color,Line_Style,Line_Width,true);

   if(draw_pe_line){
      pe_line.Update();
   }*/
}
void WLB::clear(){
   /*e_line.Delete();
   pe_line.Delete();*/
}

void WLB::setCandle(){
   candle.setCandle(this_Aethas.getHigh(P,0),this_Aethas.getLow(P,0),this_Aethas.getOpen(P,0),this_Aethas.getClose(P,0),this_Aethas.getTime(P,0));
}
bool WLB::check_timeout(datetime time,int target){
   if(time - creation_time > target){
      if(pe_hit==false){
         /*pe_line.Time2 = time;
         if(draw_pe_line){
            pe_line.Update();
         }*/
      }
      /*e_line.Time2 = time;
      if(draw_e_line){
         e_line.Update();
      }*/
      pe_hit = true;
      e_hit = true;
      return(true);
   }
   return(false);
}

bool WLB::check_pehit(datetime time,double ask,double bid){
   if(!Buy){

      if(bid>pre_entry){
         
         pe_hit = true;
         //pe_line.set_Time2(time);
         /*if(draw_pe_line){
            pe_line.Update();   
         }*/
         return(true);
      }
   }
   else{
      if(Buy){
         if(bid<pre_entry){
            pe_hit = true;
            
          
            //pe_line.set_Time2(time);
            
            /*if(draw_pe_line){
               pe_line.Update();   
            }*/
            return(true);
         }
      }
   }
   return(false);
}

bool WLB::check_ehit(datetime simtime,double simask,double simbid){
   if(!Buy){
      if(simbid>entry){
         e_hit = true;
         
         /*e_line.set_Time2(simtime);
         
         if(draw_e_line){
            e_line.Update();   
         }*/
         return(true);
      }
      double e_check2 = pre_entry;
      
      if(simbid<e_check2 && e_time !=0){
         E_check2_sum+=1;
         e_time=0;
      }
      
      double e_check = pre_entry + ((entry-pre_entry)*0.42);
      
      if(simbid>e_check && e_time ==0){
         e_time = simtime;
      }
   }
   else{
      if(Buy){
         if(simbid<entry){
            
            e_hit = true;
            
            
            /*e_line.Time2 = simtime;
            if(draw_e_line){
               e_line.Update();   
            }*/
            return(true);
         }
         double e_check2 = pre_entry;
      
         if(simbid>e_check2 && e_time !=0){
            E_check2_sum+=1;
            e_time=0;
         }
         
         double e_check = pre_entry - ((pre_entry-entry)*0.42);
      
         if(simbid<e_check && e_time ==0){
            e_time = simtime;
         }
      }
   }
   
   return(false);
}
