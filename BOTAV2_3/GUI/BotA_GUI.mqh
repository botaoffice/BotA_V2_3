//+------------------------------------------------------------------+
//|                                                     BotA_GUI.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.google.com"
#property strict

//#include <BOTAV2_3/GUI/AVE_GUI.mqh>
#include <BOTAV2_3/GUI/CC_GUI.mqh>

class Bota_GUI{
   private:

      string Panel_State;
      
      rectangle Hide_Rectangle;
      
      button StartButton;
      /*button ResetButton;
      button TickButton;*/
      
      
     /* button FileButton;
      button FileReloadButton;
      edit_field E_FileName;
      label L_FileName;
      */
      panel Main_Panel;
/*
      edit_field E_StartTime;
      edit_field E_StopTime;*/
      edit_field E_TimeFactor;
      /*
      label L_StartTime;
      label L_StopTime;*/
      label L_TimeFactor;
      label L_Main;
      /*
      button REALButton;
      button SIMButton;
      */
      //Bota_GUI_AVE AVE_GUI;
      Bota_GUI_CC_Panel TF_Panel[];
      
  public:   
   
      void Bota_GUI(void);
      void ~Bota_GUI(void);
      
      void init_gui();
      //void toggle_SimRealButton(bool sim);
      void setPanel(string ps);
      
      void addTF(string name);
      
      void Update();
      
      string get_StartButton_Name();
      
      void set_Hide_Rectangle_Time1(datetime new_val);
      void set_Hide_Rectangle_Price1(double new_val);
      void set_Hide_Rectangle_Time2(datetime new_val);
      void set_Hide_Rectangle_Price2(double new_val);
};

Bota_GUI::Bota_GUI(void){
   Panel_State="STOP";
}

Bota_GUI::~Bota_GUI(void){}

string Bota_GUI::get_StartButton_Name(){return(StartButton.get_Name());}

void Bota_GUI::set_Hide_Rectangle_Time1(datetime new_val){Hide_Rectangle.set_Time1(new_val);}
void Bota_GUI::set_Hide_Rectangle_Price1(double new_val){Hide_Rectangle.set_Price1(new_val);}
void Bota_GUI::set_Hide_Rectangle_Time2(datetime new_val){Hide_Rectangle.set_Time2(new_val);}
void Bota_GUI::set_Hide_Rectangle_Price2(double new_val){Hide_Rectangle.set_Price2(new_val);}


void Bota_GUI::Update(){
   Hide_Rectangle.Update();
}

void Bota_GUI::init_gui(){
   Hide_Rectangle.set_rectangle("SIM_HIDEREC",0,0,0,0,clrGray,STYLE_SOLID,1,true,false);
   Hide_Rectangle.Update();
   
   Main_Panel.set_panel("MAIN_PANEL",220,220,200,180,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrGold,2,false);
   Main_Panel.Update();
   
   L_Main.set_label("L_Main",210,210,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"SIMULATION","Arial",12,false);
   L_Main.Update();
   
   /*FileButton.Chart_ID = 0;
   FileButton.Name="B_FILE";
   FileButton.SubWindow=0;
   FileButton.X=80;
   FileButton.Y=220;
   FileButton.Width=60;
   FileButton.Height=30;
   FileButton.Corner=CORNER_RIGHT_LOWER;
   FileButton.Text="File";
   FileButton.Font="Arial";
   FileButton.FontSize=7;
   FileButton.Color=clrBlack;
   FileButton.BackColor=clrGold;
   FileButton.BorderColor=clrBlack;
   FileButton.State=false;
   FileButton.Back = false;
   FileButton.Selection = false;
   FileButton.Hidden=true;
   FileButton.Z_Order=1;
   
   FileButton.Update();*/
   
   /*FileReloadButton.Chart_ID = 0;
   FileReloadButton.Name="B_RELOADFILE";
   FileReloadButton.SubWindow=0;
   FileReloadButton.X=170;
   FileReloadButton.Y=9000;
   FileReloadButton.Width=100;
   FileReloadButton.Height=40;
   FileReloadButton.Corner=CORNER_RIGHT_LOWER;
   FileReloadButton.Text="Reload File";
   FileReloadButton.Font="Arial";
   FileReloadButton.FontSize=10;
   FileReloadButton.Color=clrBlack;
   FileReloadButton.BackColor=clrGray;
   FileReloadButton.BorderColor=clrWhite;
   FileReloadButton.State=false;
   FileReloadButton.Back = false;
   FileReloadButton.Selection = false;
   FileReloadButton.Hidden=true;
   FileReloadButton.Z_Order=1;
   
   FileReloadButton.Update();*/
   
   /*E_FileName.Chart_ID = 0;
   E_FileName.Name = "E_FileName";
   E_FileName.SubWindow = 0;
   
   E_FileName.X=210;
   E_FileName.Y=16000;
   E_FileName.Width=180;
   E_FileName.Height=20;
   
   E_FileName.Align=ALIGN_CENTER;
   E_FileName.Corner = CORNER_RIGHT_LOWER;

   E_FileName.Color = clrBlack;
   E_FileName.BackColor = clrWhite;
   E_FileName.BorderColor = clrBlack;
   
   
   E_FileName.Font = "Arial";
   E_FileName.FontSize = 7;

   E_FileName.Back = false;
   E_FileName.Selection = false;
   E_FileName.Hidden = true;
   E_FileName.Z_Order=1;
   
   E_FileName.Update();
   */
   /*
   L_FileName.Chart_ID = 0;
   L_FileName.Name = "L_FileName";
   L_FileName.SubWindow = 0;
   
   L_FileName.X=215;
   L_FileName.Y=17700;
   
   L_FileName.Anchor=ANCHOR_LEFT_UPPER;
   L_FileName.Corner = CORNER_RIGHT_LOWER;

   L_FileName.Color = clrBlack;
   L_FileName.Angle = 0;
   
   L_FileName.Text = "FileName:";
   L_FileName.Font = "Arial";
   L_FileName.FontSize = 7;

   L_FileName.Back = false;
   L_FileName.Selection = false;
   L_FileName.Hidden = true;
   L_FileName.Z_Order=1;
   
   L_FileName.Update();
   */
   //StartButton.Chart_ID = 0;
   StartButton.set_button("B_START",215,90,80,40,CORNER_RIGHT_LOWER,"Start","Arial",10,clrGreen,clrGray,clrWhite,false,false);
   /*StartButton.Name="B_START";
   //StartButton.SubWindow=0;
   StartButton.X=215;
   StartButton.Y=90;
   StartButton.Width=80;
   StartButton.Height=40;
   StartButton.Corner=CORNER_RIGHT_LOWER;
   StartButton.Text="Start";
   StartButton.Font="Arial";
   StartButton.FontSize=10;
   StartButton.Color=clrGreen;
   StartButton.BackColor=clrGray;
   StartButton.BorderColor=clrWhite;
   StartButton.State=false;
   StartButton.Back = false;
   //StartButton.Selection = false;
   //StartButton.Hidden=true;
   //StartButton.Z_Order=1;
   */
   StartButton.Update();
   
   /*ResetButton.Chart_ID = 0;
   ResetButton.Name="B_Reset";
   ResetButton.SubWindow=0;
   ResetButton.X=130;
   ResetButton.Y=90;
   ResetButton.Width=50;
   ResetButton.Height=40;
   ResetButton.Corner=CORNER_RIGHT_LOWER;
   ResetButton.Text="Reset";
   ResetButton.Font="Arial";
   ResetButton.FontSize=10;
   ResetButton.Color=clrDarkGray;
   ResetButton.BackColor=clrGray;
   ResetButton.BorderColor=clrWhite;
   ResetButton.State=false;
   ResetButton.Back = false;
   ResetButton.Selection = false;
   ResetButton.Hidden=true;
   ResetButton.Z_Order=1;
   
   ResetButton.Update();*/
   
   /*TickButton.Chart_ID = 0;
   TickButton.Name="B_TICK";
   TickButton.SubWindow=0;
   TickButton.X=75;
   TickButton.Y=90;
   TickButton.Width=50;
   TickButton.Height=40;
   TickButton.Corner=CORNER_RIGHT_LOWER;
   TickButton.Text="Tick";
   TickButton.Font="Arial";
   TickButton.FontSize=10;
   TickButton.Color=clrBlue;
   TickButton.BackColor=clrGray;
   TickButton.BorderColor=clrWhite;
   TickButton.State=false;
   TickButton.Back = false;
   TickButton.Selection = false;
   TickButton.Hidden=true;
   TickButton.Z_Order=1;
   
   TickButton.Update();*/
   /*
   E_StartTime.Chart_ID = 0;
   E_StartTime.Name = "E_StartTime";
   E_StartTime.SubWindow = 0;
   
   E_StartTime.X=140;
   E_StartTime.Y=180;
   E_StartTime.Width=115;
   E_StartTime.Height=20;
   
   E_StartTime.Align=ALIGN_CENTER;
   E_StartTime.Corner = CORNER_RIGHT_LOWER;

   E_StartTime.Color = clrBlack;
   E_StartTime.BackColor = clrWhite;
   E_StartTime.BorderColor = clrBlack;
   
   E_StartTime.Font = "Arial";
   E_StartTime.FontSize = 7;

   E_StartTime.Back = false;
   E_StartTime.Selection = false;
   E_StartTime.Hidden = true;
   E_StartTime.Z_Order=1;
   
   E_StartTime.Update();
   */
   /*
   L_StartTime.Chart_ID = 0;
   L_StartTime.Name = "L_StartTime";
   L_StartTime.SubWindow = 0;
   
   L_StartTime.X=215;
   L_StartTime.Y=177;

   
   L_StartTime.Anchor=ANCHOR_LEFT_UPPER;
   L_StartTime.Corner = CORNER_RIGHT_LOWER;

   L_StartTime.Color = clrBlack;
   L_StartTime.Angle = 0;
   
   L_StartTime.Text = "START TIME:";
   L_StartTime.Font = "Arial";
   L_StartTime.FontSize = 7;

   L_StartTime.Back = false;
   L_StartTime.Selection = false;
   L_StartTime.Hidden = true;
   L_StartTime.Z_Order=1;
   
   L_StartTime.Update();
   
   */
   /*
   E_StopTime.Chart_ID = 0;
   E_StopTime.Name = "E_StopTime";
   E_StopTime.SubWindow = 0;
   
   E_StopTime.X=140;
   E_StopTime.Y=150;
   E_StopTime.Width=115;
   E_StopTime.Height=20;
   
   E_StopTime.Align=ALIGN_CENTER;
   E_StopTime.Corner = CORNER_RIGHT_LOWER;

   E_StopTime.Color = clrBlack;
   E_StopTime.BackColor = clrWhite;
   E_StopTime.BorderColor = clrBlack;
   
   E_StopTime.Font = "Arial";
   E_StopTime.FontSize = 7;

   E_StopTime.Back = false;
   E_StopTime.Selection = false;
   E_StopTime.Hidden = true;
   E_StopTime.Z_Order=1;
   
   E_StopTime.Update();
   
   L_StopTime.Chart_ID = 0;
   L_StopTime.Name = "L_StopTime";
   L_StopTime.SubWindow = 0;
   
   L_StopTime.X=215;
   L_StopTime.Y=147;

   
   L_StopTime.Anchor=ANCHOR_LEFT_UPPER;
   L_StopTime.Corner = CORNER_RIGHT_LOWER;

   L_StopTime.Color = clrBlack;
   L_StopTime.Angle = 0;

   L_StopTime.Text = "STOP TIME:";
   L_StopTime.Font = "Arial";
   L_StopTime.FontSize = 7;

   L_StopTime.Back = false;
   L_StopTime.Selection = false;
   L_StopTime.Hidden = true;
   L_StopTime.Z_Order=1;
   
   L_StopTime.Update();
   */
   E_TimeFactor.set_editfield("E_TimeFactor",60,120,35,20,ALIGN_CENTER,CORNER_RIGHT_LOWER,clrBlack,clrWhite,clrBlack,"0","Arial",8,false);
   E_TimeFactor.Update();
   
   L_TimeFactor.set_label("L_TimeFactor",215,117,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"TimeFactor","Arial",7,false);
   L_TimeFactor.Update();
   
   /*SIMButton.Chart_ID = 0;
   SIMButton.Name="B_SIMTOGGLE";
   SIMButton.SubWindow=0;
   SIMButton.X=220;
   SIMButton.Y=40;
   SIMButton.Width=100;
   SIMButton.Height=40;
   SIMButton.Corner=CORNER_RIGHT_LOWER;

   SIMButton.State = true;
   SIMButton.Text="SIM";

   SIMButton.Color=clrBlack;
   SIMButton.BackColor=clrGreen;
   SIMButton.BorderColor=clrWhite;
   
   SIMButton.Font="Arial";
   SIMButton.FontSize=10;
 
   SIMButton.Back = false;
   SIMButton.Selection = false;
   SIMButton.Hidden=true;
   SIMButton.Z_Order=1;
   
   SIMButton.Update();*/
   
   
   /*REALButton.Chart_ID = 0;
   REALButton.Name="B_REALTOGGLE";
   REALButton.SubWindow=0;
   REALButton.X=120;
   REALButton.Y=40;
   REALButton.Width=100;
   REALButton.Height=40;
   REALButton.Corner=CORNER_RIGHT_LOWER;
   
   REALButton.State = false;
   REALButton.Text="REAL";

   REALButton.Color=clrBlack;
   REALButton.BackColor=clrGreen;
   REALButton.BorderColor=clrWhite;
   
   REALButton.Font="Arial";
   REALButton.FontSize=10;
 
   REALButton.Back = false;
   REALButton.Selection = false;
   REALButton.Hidden=true;
   REALButton.Z_Order=1;
   
   REALButton.Update();*/
   
   //AVE_GUI.init_gui();
   //AVE_GUI.setPanel("OFF");
}
/*
void Bota_GUI::toggle_SimRealButton(bool sim){
   if(sim){
      REALButton.Color=clrDarkGray;
      REALButton.BackColor=clrGray;
      REALButton.BorderColor=clrWhite;
      REALButton.Update();
        
      SIMButton.Color=clrBlack;
      SIMButton.BackColor=clrGreen;
      SIMButton.BorderColor=clrWhite;
      SIMButton.Update();   
   }
   else{ 
      SIMButton.Color=clrDarkGray;
      SIMButton.BackColor=clrGray;
      SIMButton.BorderColor=clrWhite;
      SIMButton.Y = 10000;
      SIMButton.Update();
      
      REALButton.Color=clrBlack;
      REALButton.BackColor=clrGreen;
      REALButton.BorderColor=clrWhite;
      REALButton.Update();
   }
}
*/

void Bota_GUI::setPanel(string ps){
   if(ps == "STOP"){
      Panel_State="STOP";
      Main_Panel.set_BackColor(clrGold);
      Main_Panel.set_Y(220);
      StartButton.set_State(false);
      StartButton.set_Text("Start");
      StartButton.set_Color(clrGreen);
      StartButton.set_Y(90);
      //ResetButton.set_Y=90;
      //TickButton.Y=90;
      //FileButton.BackColor=clrGold;
      //FileButton.Text = "File";
      E_TimeFactor.set_Y(120);
      //E_StartTime.Y=180;
      //E_StopTime.Y=150;
      //L_StartTime.Y = 177;
      //L_StopTime.Y = 147;
      L_TimeFactor.set_Y(117);
      
      //FileReloadButton.Y=9000;
      //L_FileName.Y=17700;
      //E_FileName.Y=16000;
      //FileButton.Y=220;
      L_Main.set_Y(210);
   }
   if(ps == "RUN"){
      Panel_State="RUN";
      Main_Panel.set_BackColor(clrLightGreen);
      Main_Panel.set_Y(220);
      StartButton.set_State(true);
      StartButton.set_Text("Stop");
      StartButton.set_Color(clrRed);
      StartButton.set_Y(90);
      //ResetButton.Y=90;
      //TickButton.Y=90;
      //FileButton.Y=24000;
      L_Main.set_Y(210);
   }
   if(ps == "FILE"){
      Panel_State="FILE";  
      Main_Panel.set_BackColor(clrLightGray);
      Main_Panel.set_Y(220);
      StartButton.set_Y(9000);
      //ResetButton.set_Y(9000);
      //TickButton.Y=9000;
      //FileButton.BackColor=clrLightGray;
      //FileButton.Text = "Sim";
      //FileButton.Y = 220;
      E_TimeFactor.set_Y(12000);
      //E_StartTime.Y=18000;
      //E_StopTime.Y=15000;
      //L_StartTime.Y = 17700;
      //L_StopTime.Y = 14700;
      L_TimeFactor.set_Y(11700);
      
      L_Main.set_Y(210);
      
      //FileReloadButton.Y=90;
      //L_FileName.Y=177;
      //E_FileName.Y=160;
   }
   if(ps == "OFF"){
      Panel_State="OFF";  
      Main_Panel.set_Y(22000);
      StartButton.set_Y(9000);
      //ResetButton.Y=9000;
      //TickButton.Y=9000;
      E_TimeFactor.set_Y(12000);
      //E_StartTime.Y=18000;
      //E_StopTime.Y=15000;
      //L_StartTime.Y = 17700;
      //L_StopTime.Y = 14700;
      L_TimeFactor.set_Y(11700);
      
      //FileReloadButton.Y=9000;
      //L_FileName.Y=17700;
      //E_FileName.Y=16000;
      //FileButton.Y = 22000;
      
      L_Main.set_Y(21000);
      
      //AVE_GUI.setPanel(AVE_GUI.Panel_State);
   }
   else{
      //AVE_GUI.setPanel("OFF");
   }
   StartButton.Update();
   //ResetButton.Update();
   //TickButton.Update();
   Main_Panel.Update();
   //FileButton.Update();
   E_TimeFactor.Update();
   //E_StartTime.Update();
   //E_StopTime.Update();
   //L_StartTime.Update();
   //L_StopTime.Update();
   L_TimeFactor.Update();
   //FileReloadButton.Update();
   //E_FileName.Update();
   //L_FileName.Update();
   L_Main.Update();
}

void Bota_GUI::addTF(string name){
   int size = ArraySize(TF_Panel);
   ArrayResize(TF_Panel,size+1);
   //Print("POS X: ", 95 + 80*size );
   TF_Panel[size].set_pos_x(95 + 80*size);
   TF_Panel[size].set_pos_y(330);
   
   TF_Panel[size].set_Name(name);

   
   TF_Panel[size].init_gui();
}

