#include <BOTAV2_3/MISC/GEO.mqh>
#include <BOTAV2_3/Support/Ave.mqh>

class Bota_GUI_AVE{
   private:

      

      panel Panel;
      label Label;
      
      label b_Label;
      label a_Label;
      label s_Label;
      label p_Label;
      label t_Label;
      label cs_Label;
      
      label b_Val;
      label a_Val;
      label s_Val;
      label p_Val;
      label t_Val;
      label cs_Val;
      
      panel b_Color;
      panel a_Color;
      panel s_Color;
      panel p_Color;
      panel t_Color;
      panel cs_Color;
      
      Ave *this_Ave;
      
   public:
      void Bota_GUI_AVE(void);
      void ~Bota_GUI_AVE(void);
      
      void init_gui();
      
      void set_ave(Ave *new_ave);
      
      void tick(datetime time,double ask,double bid);
};

void Bota_GUI_AVE::Bota_GUI_AVE(){
}

void Bota_GUI_AVE::~Bota_GUI_AVE(){}

void Bota_GUI_AVE::set_ave(Ave *new_ave){this_Ave = new_ave;}

void Bota_GUI_AVE::init_gui(){
   int pos_x=120;
   int pos_y=365;
   int size_x = 100;
   int size_y = 200;
   
   int lable_offset_x = 30;
   int lable_offset_y = 5;
   Panel.set_panel("AVE_PANEL",pos_x,pos_y,size_x,size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrBlack,2,false);
   Panel.Update();

   Label.set_label("AVE_LABEL",pos_x-lable_offset_x,pos_y-lable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrOlive,0,"Ave","Arial",8,false);
   Label.Update();
   //-----------------------------------
   int color_size_x = 70;
   int color_size_y = 20;
   
   int color_offset_x = 110;
   
   int blable_offset_x = 100;
   
   int blable_offset_y = 300;
   int alable_offset_y = 280;
   int slable_offset_y = 260;
   int plable_offset_y = 240;
   int tlable_offset_y = 220;
   int cslable_offset_y = 200;
   
   int bcolor_offset_y = blable_offset_y+5;
   int acolor_offset_y = alable_offset_y+5;
   int scolor_offset_y = slable_offset_y+5;
   int pcolor_offset_y = plable_offset_y+5;
   int tcolor_offset_y = tlable_offset_y+5;
   
   Panel.set_panel("AVE_bColor",color_offset_x,bcolor_offset_y,color_size_x,color_size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrCornflowerBlue,2,false);
   Panel.Update();
   
   
   Panel.set_panel("AVE_aColor",color_offset_x,acolor_offset_y,color_size_x,color_size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrSalmon,2,false);
   Panel.Update();
   
   
   Panel.set_panel("AVE_sColor",color_offset_x,scolor_offset_y,color_size_x,color_size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrPaleGoldenrod,2,false);
   Panel.Update();
   
   
   Panel.set_panel("AVE_pColor",color_offset_x,pcolor_offset_y,color_size_x,color_size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrGreen,2,false);
   Panel.Update();
   
   
   Panel.set_panel("AVE_tColor",color_offset_x,tcolor_offset_y,color_size_x,color_size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrDarkGray,2,false);
   Panel.Update();
   
   int cscolor_offset_y = cslable_offset_y+5;
   Panel.set_panel("AVE_csColor",color_offset_x,cscolor_offset_y,color_size_x,color_size_y,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrGray,2,false);
   Panel.Update();
  
   //-----------------------------------
   b_Label.set_label("AVE_bLABEL",blable_offset_x,blable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"B:","Arial",8,false);
   b_Label.Update();
   
   a_Label.set_label("AVE_aLABEL",blable_offset_x,alable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"A:","Arial",8,false);
   a_Label.Update();

   s_Label.set_label("AVE_sLABEL",blable_offset_x,slable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"S:","Arial",8,false);
   s_Label.Update();
    
   p_Label.set_label("AVE_pLABEL",blable_offset_x,plable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"P:","Arial",8,false);
   p_Label.Update();
   
   t_Label.set_label("AVE_tLABEL",blable_offset_x,tlable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"T:","Arial",8,false);
   t_Label.Update();
    
   cs_Label.set_label("AVE_csLABEL",blable_offset_x,cslable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"CS:","Arial",8,false);
   cs_Label.Update();
   //-----------------------------------
   //-----------------------------------
   b_Val.set_label("AVE_bVal",blable_offset_x-20,blable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"0","Arial",8,false);
   b_Val.Update();
   
   a_Val.set_label("AVE_aVal",blable_offset_x-20,alable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"0","Arial",8,false);
   a_Val.Update();

   s_Val.set_label("AVE_sVal",blable_offset_x-20,slable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"0","Arial",8,false);
   s_Val.Update();
    
   p_Val.set_label("AVE_pVal",blable_offset_x-20,plable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"0","Arial",8,false);
   p_Val.Update();
   
   t_Val.set_label("AVE_tVal",blable_offset_x-20,tlable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"0","Arial",8,false);
   t_Val.Update();
    
   cs_Val.set_label("AVE_csVal",blable_offset_x-20,cslable_offset_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"0","Arial",8,false);
   cs_Val.Update();
   //-----------------------------------

   
}


void Bota_GUI_AVE::tick(datetime time,double ask,double bid){
   if(CheckPointer(this_Ave)!=POINTER_INVALID){
      b_Val.set_Text(string(calc_round(this_Ave.get_AveBid(),2)));
      a_Val.set_Text(string(calc_round(this_Ave.get_AveAsk(),2)));
      s_Val.set_Text(string(calc_round(this_Ave.get_Spread(),2)));
      t_Val.set_Text(string(calc_round(this_Ave.get_AveTime(),2)));
      cs_Val.set_Text(string(calc_round(this_Ave.getCandle(PERIOD_M15),2)));

      int p_blevel=0;
      for(p_blevel=0;p_blevel<10;p_blevel++){
         if(this_Ave.get_BuyPenalty_Time(p_blevel)>0){
            int delta_t = int(time - this_Ave.get_BuyPenalty_Time(p_blevel));
            if(delta_t>60){
               break;
            }
         }
         else{
            break;
         }
      } 
      int p_slevel=0;
      for(p_slevel=0;p_slevel<10;p_slevel++){
         if(this_Ave.get_SellPenalty_Time(p_slevel)>0){
            int delta_t = int(time - this_Ave.get_SellPenalty_Time(p_slevel));
            if(delta_t>60){
               break;
            }
         }
         else{
            break;
         }
      } 
      
      p_Val.set_Text(string(p_blevel)+string(p_slevel));
      
      b_Val.Update();
      a_Val.Update();
      s_Val.Update();
      t_Val.Update();
      cs_Val.Update();
      p_Val.Update();
   }
   else{
      Print("No Ave");
   }
}
