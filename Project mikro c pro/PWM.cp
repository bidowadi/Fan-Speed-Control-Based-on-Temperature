#line 1 "C:/Users/CompuSoft/Desktop/College/Microcontrollers/Project/PWM.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;


 unsigned int val;
 unsigned int lval=0;
 float temp;
 float speed;
 char txt1[12],txt2[12];

void main() {
 ADCON1 = 0x80;
 TRISA.f0 = 1;
 TRISC.f2 = 0;

 LCD_Init();
 PWM1_Init(5000);
 ADC_Init();
 PWM1_Start();
 PWM1_Set_Duty(0);
 while(1) {

 val = ADC_Read(0);


 lval=val;
 temp = val *0.09775171;


 if (temp<28.0)speed =0.0;
 if (temp<35.0 && temp>28.0)speed =50.;
 if (temp<40.0 && temp>35.0)speed =75.0;
 if (temp>40.0)speed =100.0;

 FloatToStr (temp,txt1);
 FloatToStr (speed,txt2);
 LCD_Out(1,1,"Temp:");
 LCD_Out(1,6,txt1);
 LCD_Chr_CP('C');

 LCD_Out(2,1,"Speed:");
 LCD_Out(2,7,txt2);
 LCD_Chr_CP('%');

 if (temp<28.0)
 {
 PWM1_Set_Duty(0);
 }
 if (temp<35.0 && temp>28.0)
 {
 PWM1_Set_Duty(127);
 }
 if (temp<40.0 && temp>35.0)
 {
 PWM1_Set_Duty(175);
 }
 if (temp>40.0)
 {
 PWM1_Set_Duty(255);
 }

 Delay_ms(650);
 }
}
