//+------------------------------------------------------------------+
//|                                                  SaveManager.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Heisl"
#property link      "https://www.google.com"
#property strict

//#include <BOTAV2/MISC/CANDLE.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Order_Save
  {
public:  

   bool              Buy;
   string            name;
   int               Num;

   bool              Ghost;

   datetime          orderopentime;
   double            orderopen;


   double            profit_MIN;
   double            profit_MAXLOSS;
   double            profit_SL;
   double            profit_BE;
   double            profit_TP;
   bool              BE_SET;
   bool              IS_FED;
   
   double            TSL_Activate;

   datetime          ExcuseTime;

   //double            highest_DD;
   //double            highest_P;
  //
   double            Lot;     
   double            Profit;
   double            Profit_pip;            
   bool              is_PE;
   double            candle_size;
   
   int               WLB_Time;
   int               Clear_Time;
   double            Clear_Val;
   double            Clear_Val_Percent;
   double            highest_Loss;
   double            highest_Loss_Percent;
   
   double            highest_Profit;
   double            highest_Profit_Percent;

   

                     Order_Save(void);
                    ~Order_Save(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Order_Save::Order_Save(void) {}
Order_Save::~Order_Save(void) {}



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CopyCat_Save
  {
public:
   string            name;
   bool              Active;
   int               ActiveCounter;
   int               DeactiveCounter;

   double            Profit_Sum;
   double            highest_Loss;
   double            highest_P;
   double            highest_DD;
   double            highest_PD;
   double            highest_Poi;
   double            Profit_Pip;
   double            Profit_SIM;
   
   double            SIM_Volume;
   
   int               OrderSum_i;

                     CopyCat_Save(void);
                    ~CopyCat_Save(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CopyCat_Save::CopyCat_Save(void) {}
CopyCat_Save::~CopyCat_Save(void) {}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Garen_Save
  {
public:
   string            name;

   double            Profit_Sum;
   double            highest_Loss;
   double            highest_P;
   double            highest_DD;
   double            highest_PD;
   double            highest_Poi;
   double            Profit_Pip;
   double            Profit_SIM;
                     Garen_Save(void);
                    ~Garen_Save(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Garen_Save::Garen_Save(void) {}
Garen_Save::~Garen_Save(void) {}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class WLB_Save
  {
public:
   string            name;

   double            open;
   double            close;
   double            high;
   double            low;
   datetime          time;

   bool              isreturn;
   bool              pe_hit;

                     WLB_Save(void);
                    ~WLB_Save(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
WLB_Save::WLB_Save(void) {}
WLB_Save::~WLB_Save(void) {}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class save_manager
  {
public:  
   string            file_name;
   string            file_name2;

   int               filehandle;
   int               filehandle2;
   
   CopyCat_Save      copycat_save[];
   Garen_Save        garen_save[];
   WLB_Save          wlb_save[];

   Order_Save        order_save[];
   
   double all_Profit_SUM;
   double all_HP;
   double all_DD;
   double all_HDD;
   double all_HPD;

   double highest_DD_percent;
   double highest_DeltaDay;
   double highest_DeltaDay_percent;
   
                     save_manager(void);
                     save_manager(string fn);
                    ~save_manager(void);

   void              load();
   void              save();

   void              add_WLBSave(string name,double open,double close,double high, double low, datetime candletime,bool isReturn,bool pe_hit);
   void              clear_WLBSave();

   void              add_GarenSave(string name, double PSUM, double HL,double HP, double HDD,double HPD, double HPOI,double PPIP,double PSIM);
   void              clear_GarenSave();
   
   void              add_CopyCatSave(string name,bool Active, int AC, int DC,double PSUM, double HL, double HP, double HDD, double HPD, double HPOI,double PPIP,double PSIM,double sim_volume,int ordersum);
   void              clear_CopyCatSave();

   void              add_OrderSave( string   name,                bool     buy,           int      num,                 bool     ghost,            datetime orderopentime,
                                    double   orderopen,           datetime excuseTime,    double   profit_MIN,          double   profit_MAXLOSS,   double   profit_SL, 
                                    double   profit_BE,           double   profit_TP,     bool     BE_SET,              bool     IS_FED,           
                                    double   TSL_Activate,        double   Lot,           double   Profit,              double   Profit_pip, 
                                    bool     is_PE,               double   candle_size,   int WLB_Time,                 int      Clear_Time,       double   Clear_Val,  
                                    double   Clear_Val_Percent,   double   highest_Loss,  double   highest_Loss_Percent,double   highest_Profit,   double   highest_Profit_Percent);
   
   void              clear_OrderSave();
   void              clear();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
save_manager::save_manager(void)
  {
   clear();
  }
save_manager::~save_manager(void) {
   ArrayFree(copycat_save);
   ArrayFree(garen_save);
   ArrayFree(wlb_save);
   ArrayFree(order_save);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
save_manager::save_manager(string fn)
  {
   file_name = fn + "\\SaveFile\\save.csv";
   file_name2 = fn + "\\SaveFile\\save_clear.csv";
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::save()
  {

   filehandle = FileOpen(file_name,FILE_WRITE|FILE_CSV,';');

   if(filehandle!=INVALID_HANDLE)
     {
      FileWrite(filehandle,"WLB");
      for(int i=0; i<ArraySize(wlb_save); i++)
        {
         FileWrite(filehandle,wlb_save[i].name,wlb_save[i].open ,wlb_save[i].close,wlb_save[i].high,wlb_save[i].low, wlb_save[i].time,wlb_save[i].isreturn,wlb_save[i].pe_hit);
        }

      FileWrite(filehandle,"Garen");
      for(int i=0; i<ArraySize(garen_save); i++)
        {
         FileWrite(filehandle,garen_save[i].name,
                   garen_save[i].Profit_Sum,garen_save[i].highest_Loss,
                   garen_save[i].highest_P,garen_save[i].highest_DD,garen_save[i].highest_PD,garen_save[i].highest_Poi,
                   garen_save[i].Profit_Pip,garen_save[i].Profit_SIM);
        }
     
      
      FileWrite(filehandle,"CopyCat");
      for(int i=0; i<ArraySize(copycat_save); i++)
        {
         FileWrite(filehandle,copycat_save[i].name,copycat_save[i].Active,copycat_save[i].ActiveCounter,copycat_save[i].DeactiveCounter,
                   copycat_save[i].Profit_Sum,copycat_save[i].highest_Loss,
                   copycat_save[i].highest_P,copycat_save[i].highest_DD,copycat_save[i].highest_PD,copycat_save[i].highest_Poi,
                   copycat_save[i].Profit_Pip,copycat_save[i].Profit_SIM,copycat_save[i].SIM_Volume,copycat_save[i].OrderSum_i);
        }

      FileWrite(filehandle,"Order");
      for(int i=0; i<ArraySize(order_save); i++)
        {
         FileWrite(filehandle,
                     order_save[i].name,              order_save[i].Buy,         order_save[i].Num,                  order_save[i].Ghost,          order_save[i].orderopentime,
                     order_save[i].orderopen,         order_save[i].ExcuseTime,  order_save[i].profit_MIN,           order_save[i].profit_MAXLOSS, order_save[i].profit_SL,
                     order_save[i].profit_BE,         order_save[i].profit_TP,   order_save[i].BE_SET,               order_save[i].IS_FED,        
                     order_save[i].TSL_Activate,      order_save[i].Lot,         order_save[i].Profit,               order_save[i].Profit_pip,
                     order_save[i].is_PE,             order_save[i].candle_size, order_save[i].WLB_Time,             order_save[i].Clear_Time,     order_save[i].Clear_Val,
                     order_save[i].Clear_Val_Percent, order_save[i].highest_Loss,order_save[i].highest_Loss_Percent, order_save[i].highest_Profit, order_save[i].highest_Profit_Percent   );
        }
      FileWrite(filehandle,"SUM");
         //for(int i=0;i<ArraySize(all_Profit_SUM);i++){
            FileWrite(filehandle,all_Profit_SUM,all_HP,all_DD,all_HDD,all_HPD,highest_DD_percent,highest_DeltaDay,highest_DeltaDay_percent);
         //}
      FileWrite(filehandle,"FINISH");

      FileClose(filehandle);
     }
  
   if(SIMULATION){
      filehandle2 = FileOpen(file_name2,FILE_WRITE|FILE_CSV,';');

      if(filehandle!=INVALID_HANDLE)
        {
         FileWrite(filehandle,"WLB");
         for(int i=0; i<ArraySize(wlb_save); i++)
           {
            FileWrite(filehandle,wlb_save[i].name,wlb_save[i].open ,wlb_save[i].close,wlb_save[i].high,wlb_save[i].low, wlb_save[i].time,wlb_save[i].isreturn,wlb_save[i].pe_hit);
           }
   
         FileWrite(filehandle,"Garen");
         for(int i=0; i<ArraySize(garen_save); i++)
           {
            FileWrite(filehandle,garen_save[i].name,
                      garen_save[i].Profit_Sum,garen_save[i].highest_Loss,
                      garen_save[i].highest_P,garen_save[i].highest_DD,garen_save[i].highest_PD,garen_save[i].highest_Poi,
                      garen_save[i].Profit_Pip,garen_save[i].Profit_SIM);
           }
        
         
         FileWrite(filehandle,"CopyCat");
         for(int i=0; i<ArraySize(copycat_save); i++)
           {
            FileWrite(filehandle,copycat_save[i].name,copycat_save[i].Active,copycat_save[i].ActiveCounter,copycat_save[i].DeactiveCounter,
                      0,0,
                      0,0,0,0,
                      0,0,0,0);
           }
   
         FileWrite(filehandle,"Order");
         for(int i=0; i<ArraySize(order_save); i++)
           {
            FileWrite(filehandle,
                        order_save[i].name,              order_save[i].Buy,         order_save[i].Num,                  order_save[i].Ghost,          order_save[i].orderopentime,
                        order_save[i].orderopen,         order_save[i].ExcuseTime,  order_save[i].profit_MIN,           order_save[i].profit_MAXLOSS, order_save[i].profit_SL,
                        order_save[i].profit_BE,         order_save[i].profit_TP,   order_save[i].BE_SET,               order_save[i].IS_FED,        
                        order_save[i].TSL_Activate,      order_save[i].Lot,         order_save[i].Profit,               order_save[i].Profit_pip,
                        order_save[i].is_PE,             order_save[i].candle_size, order_save[i].WLB_Time,             order_save[i].Clear_Time,     order_save[i].Clear_Val,
                        order_save[i].Clear_Val_Percent, order_save[i].highest_Loss,order_save[i].highest_Loss_Percent, order_save[i].highest_Profit, order_save[i].highest_Profit_Percent   );
           }
         FileWrite(filehandle,"SUM");
            FileWrite(filehandle,0,0,0,0,0,0,0,0);
         FileWrite(filehandle,"FINISH");
   
         FileClose(filehandle);
        }
     }
   
   }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::load()
  {

   if(FileIsExist(file_name))
     {
      filehandle = FileOpen(file_name,FILE_READ|FILE_CSV,';');

      if(filehandle!=INVALID_HANDLE)
        {

         clear();

         string text_help = FileReadString(filehandle);

         text_help = FileReadString(filehandle);
         for(int i=0; i<1000; i++)
           {
            if(text_help != "Garen")
              {
               double open = double(FileReadString(filehandle));
               double close = double(FileReadString(filehandle));
               double high = double(FileReadString(filehandle));
               double low = double(FileReadString(filehandle));
               
               datetime candletime = FileReadDatetime(filehandle);
               bool isreturn = FileReadBool(filehandle);
               bool pe_hit = FileReadBool(filehandle);

               add_WLBSave(text_help,open,close,high,low,candletime,isreturn,pe_hit);
               text_help = FileReadString(filehandle);
              }
            else
              {
               break;
              }
           }

         
         text_help = FileReadString(filehandle);
         for(int i=0; i<1000; i++)
           {
            if(text_help != "CopyCat")
              {
               
               double ps = double(FileReadString(filehandle));
               double hl = double(FileReadString(filehandle));
               double hp = double(FileReadString(filehandle));
               double hdd = double(FileReadString(filehandle));
               double hpd = double(FileReadString(filehandle));
               double hpoi = double(FileReadString(filehandle));
               double ppip = double(FileReadString(filehandle));
               double psim = double(FileReadString(filehandle));
               add_GarenSave(text_help,ps,hl,hp,hdd,hpd,hpoi,ppip,psim);

               text_help = FileReadString(filehandle);
              }
            else
              {
               break;
              }
           }
         
         
         text_help = FileReadString(filehandle);
         for(int i=0; i<1000; i++)
           {
            if(text_help != "Order")
              {
               bool active = bool(FileReadBool(filehandle));
               int ac = int(FileReadString(filehandle));
               int dc = int(FileReadString(filehandle));
               double ps = double(FileReadString(filehandle));
               double hl = double(FileReadString(filehandle));
               double hp = double(FileReadString(filehandle));
               double hdd = double(FileReadString(filehandle));
               double hpd = double(FileReadString(filehandle));
               double hpoi = double(FileReadString(filehandle));
               double ppip = double(FileReadString(filehandle));
               double psim = double(FileReadString(filehandle));
               double sim_v = double(FileReadString(filehandle));
               int ordersum = int(FileReadString(filehandle));
               add_CopyCatSave(text_help,active,ac,dc,ps,hl,hp,hdd,hpd,hpoi,ppip,psim,sim_v,ordersum);

               text_help = FileReadString(filehandle);
              }
            else
              {
               break;
              }
           }
         text_help = FileReadString(filehandle);

         for(int i=0; i<10000; i++)
           {
            if(text_help != "SUM")
              {
               bool buy = bool(FileReadBool(filehandle));
               int   num = int(FileReadString(filehandle));
               bool ghost = bool(FileReadBool(filehandle));
               datetime orderopentime = datetime(FileReadString(filehandle));
               
               double orderopen = double(FileReadString(filehandle));
               datetime excuseTime = datetime(FileReadString(filehandle));
               double profit_MIN = double(FileReadString(filehandle));
               double profit_MAXLOSS = double(FileReadString(filehandle));
               double profit_SL = double(FileReadString(filehandle));
               
               double profit_BE = double(FileReadString(filehandle));
               double profit_TP = double(FileReadString(filehandle));
               bool BE_SET = bool(FileReadBool(filehandle));
               bool IS_FED = bool(FileReadBool(filehandle));
               //double highest_DD = double(FileReadString(filehandle));
               
               //double highest_P = double(FileReadString(filehandle));
               double tsl_activate =  double(FileReadString(filehandle));
               double lot = double(FileReadString(filehandle));
               double profit = double(FileReadString(filehandle));
               double profit_pip = double(FileReadString(filehandle));
               
               bool ispe = bool(FileReadBool(filehandle));
               double candlesize = double(FileReadString(filehandle));
               int wlbtime = int(FileReadString(filehandle));
               int cleartime = int(FileReadString(filehandle));
               double clearval = double(FileReadString(filehandle));
               
               double clearvalpercent = double(FileReadString(filehandle));
               double highestloss = double(FileReadString(filehandle));
               double highestlosspercent = double(FileReadString(filehandle));
               double highestprofit = double(FileReadString(filehandle));
               double highestprofitpercent = double(FileReadString(filehandle));

               add_OrderSave( text_help,                       buy,                       num,                                ghost,                        orderopentime,
                              orderopen,                       excuseTime,                profit_MIN,                         profit_MAXLOSS,               profit_SL,
                              profit_BE,                       profit_TP,                 BE_SET,                             IS_FED,                     
                              tsl_activate,                    lot,                       profit,                             profit_pip,
                              ispe,                            candlesize,                wlbtime,                            cleartime,                    clearval,
                              clearvalpercent,                 highestloss,               highestlosspercent,                 highestprofit,                highestprofitpercent);

               text_help = FileReadString(filehandle);

              }
            else
              {
               break;
              }
           }
           text_help = FileReadString(filehandle);

            for(int i=0; i<10000; i++)
            {
               if(text_help != "FINISH")
               {  
                  //if(ArraySize(all_Profit_SUM)>0){
                     all_Profit_SUM = double(FileReadString(filehandle));
                     all_HP = double(FileReadString(filehandle));
                     all_DD = double(FileReadString(filehandle));
                     all_HDD = double(FileReadString(filehandle));
                     all_HPD = double(FileReadString(filehandle));
                     highest_DD_percent = double(FileReadString(filehandle));
                     highest_DeltaDay = double(FileReadString(filehandle));
                     highest_DeltaDay_percent = double(FileReadString(filehandle));
                  //}
               }
               else
               {
                  break;
               }
            } 
         FileClose(filehandle);
        }
     }

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::add_WLBSave(string name,double open,double close,double high,double low,datetime candletime,bool isReturn,bool pe_hit)
  {
   int size = ArraySize(wlb_save);
   ArrayResize(wlb_save,size+1);
   wlb_save[size].name = name;
   wlb_save[size].open = open;
   wlb_save[size].close = close;
   wlb_save[size].high = high;
   wlb_save[size].low = low;
   wlb_save[size].time = candletime;
   wlb_save[size].isreturn = isReturn;
   wlb_save[size].pe_hit = pe_hit;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::clear_WLBSave(void)
  {
   ArrayResize(wlb_save,0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::add_GarenSave(string name, double PSUM, double HL, double HP, double HDD, double HPD, double HPOI, double PPIP, double PSIM)
  {
   int size = ArraySize(garen_save);
   ArrayResize(garen_save,size+1);
   garen_save[size].name = name;
   garen_save[size].Profit_Sum = PSUM;
   garen_save[size].highest_Loss = HL;
   garen_save[size].highest_P = HP;
   garen_save[size].highest_DD = HDD;
   garen_save[size].highest_PD = HPD;
   garen_save[size].highest_Poi = HPOI ;
   garen_save[size].Profit_Pip = PPIP ;
   garen_save[size].Profit_SIM = PSIM ;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::clear_GarenSave(void)
  {
   ArrayResize(garen_save,0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::add_CopyCatSave(string name,bool Active, int AC, int DC,double PSUM, double HL, double HP, double HDD, double HPD, double HPOI, double PPIP, double PSIM, double sim_v,int ordersum)
  {
   int size = ArraySize(copycat_save);
   ArrayResize(copycat_save,size+1);
   copycat_save[size].name = name;
   copycat_save[size].Active = Active;
   copycat_save[size].ActiveCounter = AC;
   copycat_save[size].DeactiveCounter = DC;

   copycat_save[size].Profit_Sum = PSUM;
   copycat_save[size].highest_Loss = HL;
   copycat_save[size].highest_P = HP;
   copycat_save[size].highest_DD = HDD;
   copycat_save[size].highest_PD = HPD;
   copycat_save[size].highest_Poi = HPOI ;
   copycat_save[size].Profit_Pip = PPIP ;
   copycat_save[size].Profit_SIM = PSIM ;
   copycat_save[size].SIM_Volume = sim_v ;
   copycat_save[size].OrderSum_i = ordersum ;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::clear_CopyCatSave(void)
  {
   ArrayResize(copycat_save,0);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::add_OrderSave(string name,                     bool buy,                  int num,                            bool ghost,                   datetime orderopentime,
                                 double orderopen,                datetime excuseTime,       double profit_MIN,                  double profit_MAXLOSS,        double profit_SL,
                                 double profit_BE,                double profit_TP,          bool BE_SET,                        bool IS_FED,                  
                                 double TSL_Activate,             double lot,                double profit,                      double profit_pip,
                                 bool ispe,                       double candlesize,         int wlbtime,                        int cleartime,                double clearval,
                                 double clearvalpercent,          double highestloss,        double highestlosspercent,          double highestprofit,         double highestprofitpercent){

   int size = ArraySize(order_save);
   ArrayResize(order_save,size+1);

   order_save[size].Buy = buy;
   order_save[size].name = name;
   order_save[size].Num = num;
   order_save[size].Ghost = ghost;
   order_save[size].orderopentime = orderopentime;
   
   order_save[size].orderopen = orderopen;
   order_save[size].ExcuseTime = excuseTime;
   order_save[size].profit_MIN = profit_MIN;
   order_save[size].profit_MAXLOSS = profit_MAXLOSS;
   order_save[size].profit_SL = profit_SL;
   
   order_save[size].profit_BE = profit_BE;
   order_save[size].profit_TP = profit_TP;
   order_save[size].IS_FED = IS_FED;   
   order_save[size].BE_SET = BE_SET;
   //order_save[size].highest_DD = highest_DD;
   
   //order_save[size].highest_P = highest_P;
   order_save[size].TSL_Activate = TSL_Activate;
   order_save[size].Lot = lot;
   order_save[size].Profit=profit;
   order_save[size].Profit_pip = profit_pip;
   
   order_save[size].is_PE = ispe;
   order_save[size].candle_size = candlesize;
   order_save[size].WLB_Time = wlbtime;
   order_save[size].Clear_Time = cleartime;
   order_save[size].Clear_Val = clearval;
   
   order_save[size].Clear_Val_Percent = clearvalpercent;
   order_save[size].highest_Loss = highestloss;
   order_save[size].highest_Loss_Percent  = highestlosspercent;
   order_save[size].highest_Profit = highestprofit;
   order_save[size].highest_Profit_Percent = highestprofitpercent;
   
   //Print("addordersave:",order_save[size].name," cs:", order_save[size].candle_size,"|O: ",order_save[size].orderopen);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::clear_OrderSave()
  {
   ArrayResize(order_save,0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void save_manager::clear()
  {
   clear_WLBSave();
   clear_GarenSave();
   clear_CopyCatSave();
   clear_OrderSave();
  }
//+------------------------------------------------------------------+
