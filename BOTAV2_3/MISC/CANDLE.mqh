//+------------------------------------------------------------------+
//|                                                       CANDLE.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

class Candle{
   
   private:
            double high;   
            double low; 
            
            double open;
            double close; 
                   
            datetime time;  
            
            
            double get_TopWick();
            double get_BotWick();
            double get_Body();
            
            double get_TopWick_Body();
            double get_BotWick_Body();
            double get_Body_Wick();

            //void set_Time(datetime v);
   public:           
            void Candle();
            void ~Candle();
            
            void setCandle(double this_high,double this_low, double this_open,double thisclose, datetime this_time);
      
            double get_High();
            double get_Low();
            double get_Open();
            double get_Close();
            datetime get_Time(); 
            
            double get_TopWick_Percent();
            double get_BotWick_Percent();
            int get_BullBear();
            double get_CandleSum();
            double get_Body_Percent();
            
            void set_High(double v);
            void set_Low(double v);
            void set_Open(double v);
            void set_Close(double v);     
};

void Candle::Candle(){
   high=0;   
   low=0;  
   open=0;
   close=0; 
   time=0;
}

void Candle::~Candle(){}
int Candle::get_BullBear(){
   if(open>close){
      return(-1);
   }
   if(open<close){
      return(1);
   }
   return(0);
}

void Candle::setCandle(double this_high,double this_low,double this_open,double this_close,datetime this_time){
   high = this_high;   
   low = this_low; 
   open = this_open;
   close = this_close; 
   time = this_time;  
}
double Candle::get_TopWick(){
   if(get_BullBear()<0){
      double top_wick = high-open;
      return(top_wick);
   }
   if(get_BullBear()>0){
      double top_wick = high-close;
      return(top_wick);
   }
   return(high-close);
}


double Candle::get_BotWick(){
   if(get_BullBear()<0){
      double bot_wick = close-low;
      return(bot_wick);
   }
   if(get_BullBear()>0){
      double bot_wick = open-low;
      return(bot_wick);
   }
   return(open-low);
}
double Candle::get_Body(){
   double body = MathAbs(open-close);
   return(body);
}

double Candle::get_CandleSum(){
   double sum = get_BotWick() + get_TopWick() + get_Body();
   return(sum);
}


double Candle::get_TopWick_Body(){
   double body = get_Body();
   double top_wick = get_TopWick();
   if(body != 0){
      return(top_wick/body);
   }
   else{
      return(1);
   }
}

double Candle::get_BotWick_Body(){
   double body = get_Body();
   double bot_wick = get_TopWick();
   if(body != 0){
      return(bot_wick/body);
   }
   else{
      return(1);
   }
}

double Candle::get_Body_Wick(){

   double body = get_Body();
   double bot_wick = get_TopWick();
   double top_wick = get_BotWick();
   double wick_sum = bot_wick+top_wick;
   if(wick_sum != 0){
      return(body/wick_sum);
   }
   else{
      return(1);
   }
}

double Candle::get_TopWick_Percent(){

   double top_wick = get_TopWick();
   double sum = get_CandleSum();
   if(sum !=0){
      return(top_wick/sum);
   }
   else{
      return(1);
   }
}
double Candle::get_BotWick_Percent(){

   double wick = get_BotWick();
   double sum = get_CandleSum();
   if(sum !=0){
      return(wick/sum);
   }
   else{
      return(1);
   }
}

double Candle::get_Body_Percent(){

   double body = get_Body();
   double sum = get_CandleSum();
   if(sum !=0){
      return(body/sum);
   }
   else{
      return(1);
   }
}
double Candle::get_High(){return(high);}
double Candle::get_Low(){return(low);}
double Candle::get_Open(){return(open);}
double Candle::get_Close(){return(close);}
datetime Candle::get_Time(){return(time);}

void Candle::set_High(double v){high=v;}
void Candle::set_Low(double v){low=v;}
void Candle::set_Open(double v){open=v;}
void Candle::set_Close(double v){close=v;}
//void Candle::set_Time(datetime v){time=v;}