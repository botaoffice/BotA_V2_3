//+------------------------------------------------------------------+
//|                                                  Save_Global.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#include <BOTAV2_3/MISC/SaveManager.mqh>
//--------------------------------------------------------------
//                            SAVE-METHODS
//--------------------------------------------------------------

void init_save(){
   //Print("init_save");
   save_manager *this_sm =& SaveManager;
   for(int i =0;i<ArraySize(CopyCat_BOT);i++){
      CopyCat_BOT[i].set_SaveManager(this_sm);// =& SaveManager;
   }

   for(int i =0;i<ArraySize(Garen_BOT);i++){
      Garen_BOT[i].set_SaveManager(this_sm);// =& SaveManager;
   }
   for(int i =0;i<ArraySize(WLB_BOT);i++){
      WLB_BOT[i].set_SaveManager(this_sm);
   }
   
   for(int i=0;i<ArraySize(SaveManager.order_save);i++){
      
      bool found = false;
      for(int j=0;j<ArraySize(Garen_BOT);j++){
         if(Garen_BOT[j].get_name() == SaveManager.order_save[i].name){
            Garen_BOT[j].set_TIME(SaveManager.order_save[i].orderopentime);
            Garen_BOT[j].set_ASK(SaveManager.order_save[i].orderopen);
            Garen_BOT[j].set_BID(SaveManager.order_save[i].orderopen);
            
            //Print(Garen_BOT[j].BID,"|",Garen_BOT[j].ASK);
            Garen_BOT[j].SetOrder(  SaveManager.order_save[i].Buy,
                                    SaveManager.order_save[i].profit_SL,
                                    SaveManager.order_save[i].profit_MAXLOSS,
                                    SaveManager.order_save[i].profit_BE,
                                    SaveManager.order_save[i].profit_TP,
                                    99,
                                    SaveManager.order_save[i].profit_MIN,
                                    SaveManager.order_save[i].is_PE,
                                    SaveManager.order_save[i].WLB_Time,
                                    SaveManager.order_save[i].candle_size);
            
            //Print("SAVE Garen SetOrder|Open:",SaveManager.order_save[i].orderopen);
            Order *this_order;
            if(SaveManager.order_save[i].Buy){
               int size = Garen_BOT[j].get_BUY_pos()-1;
               this_order = Garen_BOT[j].get_BUY_order(size);
            }
            else{
               int size = Garen_BOT[j].get_SELL_pos()-1;
               this_order = Garen_BOT[j].get_SELL_order(size);
            }
            this_order.set_BE_SET(SaveManager.order_save[i].BE_SET);
            this_order.set_ExcuseTime(SaveManager.order_save[i].ExcuseTime);
            //this_order.highest_DD = SaveManager.order_save[i].highest_DD;
            this_order.set_WLB_Time(SaveManager.order_save[i].WLB_Time);
            this_order.set_Lot(SaveManager.order_save[i].Lot);
            this_order.set_Profit(SaveManager.order_save[i].Profit);
            this_order.set_Profit_pip(SaveManager.order_save[i].Profit_pip);
            
            this_order.set_Clear_Time(SaveManager.order_save[i].Clear_Time);
            this_order.set_Clear_Val(SaveManager.order_save[i].Clear_Val);
            this_order.set_Clear_Val_Percent(SaveManager.order_save[i].Clear_Val_Percent);
            this_order.set_highest_Loss(SaveManager.order_save[i].highest_Loss);
            this_order.set_highest_Loss_Percent(SaveManager.order_save[i].highest_Loss_Percent);
            
            this_order.set_highest_Profit(SaveManager.order_save[i].highest_Profit);
            this_order.set_highest_Profit_Percent(SaveManager.order_save[i].highest_Profit_Percent);
            
            //Print(SaveManager.order_save[i].name," cs:", SaveManager.order_save[i].candle_size);
            
            /*}
            else{
               int size = ArraySize(Garen_BOT[j].SELL_order)-1;
               Garen_BOT[j].SELL_order[size].BE_SET = SaveManager.order_save[i].BE_SET;
               Garen_BOT[j].SELL_order[size].ExcuseTime = SaveManager.order_save[i].ExcuseTime;
               Garen_BOT[j].SELL_order[size].highest_DD = SaveManager.order_save[i].highest_DD;
               Garen_BOT[j].SELL_order[size].highest_P = SaveManager.order_save[i].highest_P;
            }*/
            found = true;
            break;
         }
      }
      if(!found){
         for(int j=0;j<ArraySize(CopyCat_BOT);j++){
            if(CopyCat_BOT[j].get_name() == SaveManager.order_save[i].name){
               CopyCat_BOT[j].set_TIME(SaveManager.order_save[i].orderopentime);
               CopyCat_BOT[j].set_ASK(SaveManager.order_save[i].orderopen);
               CopyCat_BOT[j].set_BID(SaveManager.order_save[i].orderopen);
               CopyCat_BOT[j].SetOrder(  SaveManager.order_save[i].Buy,
                                       SaveManager.order_save[i].profit_SL,
                                       SaveManager.order_save[i].profit_MAXLOSS,
                                       SaveManager.order_save[i].profit_BE,
                                       SaveManager.order_save[i].profit_TP,
                                       SaveManager.order_save[i].TSL_Activate,
                                       SaveManager.order_save[i].profit_MIN,
                                       SaveManager.order_save[i].IS_FED,
                                       SaveManager.order_save[i].is_PE,
                                       SaveManager.order_save[i].WLB_Time,
                                       SaveManager.order_save[i].candle_size);
               //Print("SAVE CC SetOrder");
               Order *this_order;
               if(SaveManager.order_save[i].Buy){
                  int size = CopyCat_BOT[j].get_BUY_pos()-1;
                  this_order = CopyCat_BOT[j].get_BUY_order(size);
               }
               else{
                  int size = CopyCat_BOT[j].get_SELL_pos()-1;
                  this_order = CopyCat_BOT[j].get_SELL_order(size);
               }
               this_order.set_BE_SET(SaveManager.order_save[i].BE_SET);
               this_order.set_ExcuseTime(SaveManager.order_save[i].ExcuseTime);
               //this_order.highest_DD = SaveManager.order_save[i].highest_DD;
               this_order.set_WLB_Time(SaveManager.order_save[i].WLB_Time);
               this_order.set_Lot(SaveManager.order_save[i].Lot);
               this_order.set_Profit(SaveManager.order_save[i].Profit);
               this_order.set_Profit_pip(SaveManager.order_save[i].Profit_pip);
               
               this_order.set_Clear_Time(SaveManager.order_save[i].Clear_Time);
               this_order.set_Clear_Val(SaveManager.order_save[i].Clear_Val);
               this_order.set_Clear_Val_Percent(SaveManager.order_save[i].Clear_Val_Percent);
               this_order.set_highest_Loss(SaveManager.order_save[i].highest_Loss);
               this_order.set_highest_Loss_Percent(SaveManager.order_save[i].highest_Loss_Percent);
               
               this_order.set_highest_Profit(SaveManager.order_save[i].highest_Profit);
               this_order.set_highest_Profit_Percent(SaveManager.order_save[i].highest_Profit_Percent);
               
               if(!SaveManager.order_save[i].Ghost){
                  this_order.set_Num(SaveManager.order_save[i].Num);
                  this_order.set_Ghost(false);
               }
                  
               /*if(SaveManager.order_save[i].Buy){
                  int size = ArraySize(CopyCat_BOT[j].BUY_order)-1;

                  
               }
               else{
                  int size = ArraySize(CopyCat_BOT[j].SELL_order)-1;
                  CopyCat_BOT[j].SELL_order[size].BE_SET = SaveManager.order_save[i].BE_SET;
                  CopyCat_BOT[j].SELL_order[size].ExcuseTime = SaveManager.order_save[i].ExcuseTime;
                  CopyCat_BOT[j].SELL_order[size].highest_DD = SaveManager.order_save[i].highest_DD;
                  CopyCat_BOT[j].SELL_order[size].highest_P = SaveManager.order_save[i].highest_P;

                  if(!SaveManager.order_save[i].Ghost){
                     CopyCat_BOT[j].SELL_order[size].Num = SaveManager.order_save[i].Num;
                     CopyCat_BOT[j].SELL_order[size].Ghost=false;
                  }
               }*/
               //Print("Order added to ",CopyCat_BOT[j].name,"|",SaveManager.order_save[i].orderopentime,"|",SaveManager.order_save[i].orderopen,"|",SaveManager.order_save[i].Num);
               found = true;
               break;
            }
         }
      }
   }
   for(int i=0;i<ArraySize(SaveManager.wlb_save);i++){
      for(int j=0;j<ArraySize(WLB_BOT);j++){
         
         if(WLB_BOT[j].get_name() == SaveManager.wlb_save[i].name){
            //int candle_pos = getCandle_byTime(SaveManager.wlb_save[i].time,WLB_BOT[j].P);
            //WLB_BOT[j].CANDLE_Bonus = candle_pos;
            WLB_BOT[j].set_TIME(SaveManager.wlb_save[i].time);
            
            WLB_BOT[j].get_CANDLE().setCandle(SaveManager.wlb_save[i].high,SaveManager.wlb_save[i].low,SaveManager.wlb_save[i].open,SaveManager.wlb_save[i].close,SaveManager.wlb_save[i].time);
            
            
            if(WLB_BOT[j].get_CANDLE().get_Open()>WLB_BOT[j].get_CANDLE().get_Close()){
               //bear
               WLB_BOT[j].new_H(SaveManager.wlb_save[i].pe_hit,SaveManager.wlb_save[i].isreturn);
               //ArrayResize(WLB_BOT[j].WLB_H_Level,ArraySize(WLB_BOT[j].WLB_H_Level)+1);
               /*WLB *this_help =& WLB_BOT[j].WLB_H_Level[ArraySize(WLB_BOT[j].WLB_H_Level)-1];
               WLB_BOT[j].set_this_WLB(this_help);// =& WLB_BOT[j].WLB_H_Level[ArraySize(WLB_BOT[j].WLB_H_Level)-1];
               this_help.set_pe_hit(SaveManager.wlb_save[i].pe_hit);*/
               WLB_BOT[j].setWLB(true);
               //this_help.set_isReturn(SaveManager.wlb_save[i].isreturn);
            }
            else{
               //bull
               WLB_BOT[j].new_L(SaveManager.wlb_save[i].pe_hit,SaveManager.wlb_save[i].isreturn);
               //ArrayResize(WLB_BOT[j].WLB_L_Level,ArraySize(WLB_BOT[j].WLB_L_Level)+1);
               /*WLB *this_help =& WLB_BOT[j].WLB_L_Level[ArraySize(WLB_BOT[j].WLB_L_Level)-1];
               WLB_BOT[j].set_this_WLB(this_help);// =& WLB_BOT[j].WLB_L_Level[ArraySize(WLB_BOT[j].WLB_L_Level)-1];
               this_help.set_pe_hit(SaveManager.wlb_save[i].pe_hit);*/
               WLB_BOT[j].setWLB(false);
               //this_help.set_isReturn(SaveManager.wlb_save[i].isreturn);
            }
            //WLB_BOT[j].CANDLE_Bonus = 0;
            //Print("WLB added to ",WLB_BOT[j].name);
            break;
         }
      }
   }
   for(int i=0;i<ArraySize(SaveManager.garen_save);i++){
      for(int j=0;j<ArraySize(Garen_BOT);j++){
         if(Garen_BOT[j].get_name() == SaveManager.garen_save[i].name){
            
            Garen_BOT[j].set_g_Profits_SUM(SaveManager.garen_save[i].Profit_Sum);
            Garen_BOT[j].set_g_highest_Loss(SaveManager.garen_save[i].highest_Loss);
            Garen_BOT[j].set_g_highest_P(SaveManager.garen_save[i].highest_P);
            Garen_BOT[j].set_highest_DD(SaveManager.garen_save[i].highest_DD);
            Garen_BOT[j].set_g_HighestProfitDelta(SaveManager.garen_save[i].highest_PD);
            Garen_BOT[j].set_g_HighestPoints(SaveManager.garen_save[i].highest_Poi);
            Garen_BOT[j].set_g_Profits_Pip(SaveManager.garen_save[i].Profit_Pip);
            Garen_BOT[j].set_g_Profits_SIM(SaveManager.garen_save[i].Profit_SIM);
            //Print("Garen added to ",Garen_BOT[j].name,"|",Garen_BOT[j].g_Profits_SUM);
            break;
         }
      }
   }
   
   for(int i=0;i<ArraySize(SaveManager.copycat_save);i++){
      for(int j=0;j<ArraySize(CopyCat_BOT);j++){
         if(CopyCat_BOT[j].get_name() == SaveManager.copycat_save[i].name){
            CopyCat_BOT[j].set_isActive(SaveManager.copycat_save[i].Active);
            CopyCat_BOT[j].set_g_ProfitCombo_i(SaveManager.copycat_save[i].ActiveCounter);
            CopyCat_BOT[j].set_g_LossCombo_i(SaveManager.copycat_save[i].DeactiveCounter);
            
            CopyCat_BOT[j].set_Profits_SUM(SaveManager.copycat_save[i].Profit_Sum);
            CopyCat_BOT[j].set_highest_Loss(SaveManager.copycat_save[i].highest_Loss);
            CopyCat_BOT[j].set_highest_P(SaveManager.copycat_save[i].highest_P);
            CopyCat_BOT[j].set_highest_DD(SaveManager.copycat_save[i].highest_DD);
            CopyCat_BOT[j].set_HighestProfitDelta(SaveManager.copycat_save[i].highest_PD);
            CopyCat_BOT[j].set_HighestPoints(SaveManager.copycat_save[i].highest_Poi);
            CopyCat_BOT[j].set_Profits_Pip(SaveManager.copycat_save[i].Profit_Pip);
            CopyCat_BOT[j].set_Profits_SIM(SaveManager.copycat_save[i].Profit_SIM);
            CopyCat_BOT[j].set_SIM_Volume(SaveManager.copycat_save[i].SIM_Volume);
            CopyCat_BOT[j].set_OrderSum_i(SaveManager.copycat_save[i].OrderSum_i);
            //Print("CopyCat added to ",CopyCat_BOT[j].name,"|",CopyCat_BOT[j].g_ProfitCombo_i,"|",CopyCat_BOT[j].g_LossCombo_i);
            break;
         }
      }
   }
   //Print("Found Orders: ",ArraySize(SaveManager.order_save)); 
}