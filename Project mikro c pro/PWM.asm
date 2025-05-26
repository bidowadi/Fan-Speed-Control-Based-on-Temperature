
_main:

;PWM.c,22 :: 		void main() {
;PWM.c,23 :: 		ADCON1 = 0x80;  // Right justified, Vref = Vdd
	MOVLW      128
	MOVWF      ADCON1+0
;PWM.c,24 :: 		TRISA.f0 = 1; // LM35 input
	BSF        TRISA+0, 0
;PWM.c,25 :: 		TRISC.f2 = 0; // PWM output
	BCF        TRISC+0, 2
;PWM.c,27 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;PWM.c,28 :: 		PWM1_Init(5000);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;PWM.c,29 :: 		ADC_Init();
	CALL       _ADC_Init+0
;PWM.c,30 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;PWM.c,31 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWM.c,32 :: 		while(1) {
L_main0:
;PWM.c,34 :: 		val = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _val+0
	MOVF       R0+1, 0
	MOVWF      _val+1
;PWM.c,37 :: 		lval=val;     // Read from LM35
	MOVF       R0+0, 0
	MOVWF      _lval+0
	MOVF       R0+1, 0
	MOVWF      _lval+1
;PWM.c,38 :: 		temp = val *0.09775171;   // Convert to °C (assuming 10mV/°C)
	CALL       _word2double+0
	MOVLW      12
	MOVWF      R4+0
	MOVLW      50
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      123
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
	MOVF       R0+2, 0
	MOVWF      _temp+2
	MOVF       R0+3, 0
	MOVWF      _temp+3
;PWM.c,41 :: 		if (temp<28.0)speed =0.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      96
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
	CLRF       _speed+0
	CLRF       _speed+1
	CLRF       _speed+2
	CLRF       _speed+3
L_main2:
;PWM.c,42 :: 		if (temp<35.0 && temp>28.0)speed =50.;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
	MOVF       _temp+0, 0
	MOVWF      R4+0
	MOVF       _temp+1, 0
	MOVWF      R4+1
	MOVF       _temp+2, 0
	MOVWF      R4+2
	MOVF       _temp+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      96
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
L__main22:
	MOVLW      0
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
	MOVLW      72
	MOVWF      _speed+2
	MOVLW      132
	MOVWF      _speed+3
L_main5:
;PWM.c,43 :: 		if (temp<40.0 && temp>35.0)speed =75.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _temp+0, 0
	MOVWF      R4+0
	MOVF       _temp+1, 0
	MOVWF      R4+1
	MOVF       _temp+2, 0
	MOVWF      R4+2
	MOVF       _temp+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      12
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
L__main21:
	MOVLW      0
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
	MOVLW      22
	MOVWF      _speed+2
	MOVLW      133
	MOVWF      _speed+3
L_main8:
;PWM.c,44 :: 		if (temp>40.0)speed =100.0;
	MOVF       _temp+0, 0
	MOVWF      R4+0
	MOVF       _temp+1, 0
	MOVWF      R4+1
	MOVF       _temp+2, 0
	MOVWF      R4+2
	MOVF       _temp+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      32
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVLW      0
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
	MOVLW      72
	MOVWF      _speed+2
	MOVLW      133
	MOVWF      _speed+3
L_main9:
;PWM.c,46 :: 		FloatToStr (temp,txt1);
	MOVF       _temp+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _temp+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _temp+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _temp+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt1+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;PWM.c,47 :: 		FloatToStr (speed,txt2);
	MOVF       _speed+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _speed+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _speed+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _speed+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt2+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;PWM.c,48 :: 		LCD_Out(1,1,"Temp:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_PWM+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM.c,49 :: 		LCD_Out(1,6,txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM.c,50 :: 		LCD_Chr_CP('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;PWM.c,52 :: 		LCD_Out(2,1,"Speed:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_PWM+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM.c,53 :: 		LCD_Out(2,7,txt2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM.c,54 :: 		LCD_Chr_CP('%');
	MOVLW      37
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;PWM.c,56 :: 		if (temp<28.0)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      96
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;PWM.c,58 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWM.c,59 :: 		}
L_main10:
;PWM.c,60 :: 		if (temp<35.0 && temp>28.0)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _temp+0, 0
	MOVWF      R4+0
	MOVF       _temp+1, 0
	MOVWF      R4+1
	MOVF       _temp+2, 0
	MOVWF      R4+2
	MOVF       _temp+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      96
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main13
L__main20:
;PWM.c,62 :: 		PWM1_Set_Duty(127);
	MOVLW      127
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWM.c,63 :: 		}
L_main13:
;PWM.c,64 :: 		if (temp<40.0 && temp>35.0)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _temp+0, 0
	MOVWF      R4+0
	MOVF       _temp+1, 0
	MOVWF      R4+1
	MOVF       _temp+2, 0
	MOVWF      R4+2
	MOVF       _temp+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      12
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main16
L__main19:
;PWM.c,66 :: 		PWM1_Set_Duty(175);
	MOVLW      175
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWM.c,67 :: 		}
L_main16:
;PWM.c,68 :: 		if (temp>40.0)
	MOVF       _temp+0, 0
	MOVWF      R4+0
	MOVF       _temp+1, 0
	MOVWF      R4+1
	MOVF       _temp+2, 0
	MOVWF      R4+2
	MOVF       _temp+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      32
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main17
;PWM.c,70 :: 		PWM1_Set_Duty(255);
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWM.c,71 :: 		}
L_main17:
;PWM.c,73 :: 		Delay_ms(650);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      153
	MOVWF      R12+0
	MOVLW      73
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
;PWM.c,74 :: 		}
	GOTO       L_main0
;PWM.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
