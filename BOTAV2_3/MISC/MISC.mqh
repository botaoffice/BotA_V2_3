//+------------------------------------------------------------------+
//|                                                         MISC.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

double calc_round(double value, int comma){
   if(comma>0){
      double factor = 1.0;
      for(int i=0;i<comma;i++){
         factor = factor * 10.0;
      }
      double new_val = double(MathRound(value*factor))/factor;
      return(new_val);
   }
   else{
      return(value);
   }
}

double calc_lot(double DLD,double volume){
   double lot =0.01;
   if(DLD > 0){
      lot = lot + volume/DLD;
   }
   if(lot>10){
      lot=10.0;
   }
   return(calc_round(lot,2));
}

ENUM_TIMEFRAMES periodTOp(int period){
   ENUM_TIMEFRAMES P=PERIOD_M1;
   if(Period()==1){
      P=PERIOD_M1;  
   }
   if(Period()==5){
      P=PERIOD_M5;
   }
   if(Period()==15){
      P=PERIOD_M15;
   }
   if(Period()==30){
      P=PERIOD_M30;
   }
   if(Period()==60){
      P=PERIOD_H1;
   }
   if(Period()==240){
      P=PERIOD_H4;
   }
   if(Period()==1440){
      P=PERIOD_D1;
   }
   if(Period()==10080){
      P=PERIOD_W1;
   }
   if(Period()==40300){
      P=PERIOD_MN1;
   }
   return(P);
}


/*void setLineStyle(int count,color &this_colorBuy,color &this_colorSell,ENUM_LINE_STYLE &this_style,int &this_width){

   if(count==1){
      this_colorSell = clrRed;
      this_colorBuy = clrDodgerBlue;
                                                                                                                                                                                                                                                                                                 
      this_width = 1;
      this_style = STYLE_DOT;
      
   }
   else{
      if(count==2){
         this_colorSell = clrOrange;
         this_colorBuy = clrDarkCyan;
                                                                                                                                                                                                                                                                                                     
         this_width = 1;
         this_style = STYLE_DOT;
      }
      else{
         if(count==3){
            this_colorSell = clrDarkRed;
            this_colorBuy = clrAqua;
                                                                                                                                                                                                                                                                                                        
            this_width = 1;
            this_style = STYLE_DOT;
         }
         else{
            if(count==4){
               this_colorSell = clrRed;
               this_colorBuy = clrDodgerBlue;
                                                                                                                                                                                                                                                                                                          
               this_width = 1;
               this_style = STYLE_DASHDOTDOT;
            }
            else{
               if(count==5){
                  this_colorSell = clrOrange;
                  this_colorBuy = clrDarkCyan;
                                                                                                                                                                                                                                                                                                              
                  this_width = 1;
                  this_style = STYLE_DASHDOTDOT;
               }
               else{
                  if(count==6){
                     this_colorSell = clrDarkRed;
                     this_colorBuy = clrAqua;
                                                                                                                                                                                                                                                                                                                 
                     this_width = 1;
                     this_style = STYLE_DASHDOTDOT;
                  }
                  else{
                     Print("???");
                  }
               }
            }
         }
      }
   }                                    
}*/