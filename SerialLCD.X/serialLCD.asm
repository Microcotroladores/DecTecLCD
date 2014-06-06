 #INCLUDE<P16F873A.INC>
			__CONFIG _XT_OSC & _WDT_OFF & _CP_OFF & _PWRTE_ON &_BODEN_OFF & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
            LIST P=16F873A
;-----------DEFINICIONES---------------------------------------------------
			#DEFINE RS PORTC,0
			#DEFINE E PORTC,1
			#DEFINE BUS PORTB
;-----------REGISTROS------------------------------------------------------
			CBLOCK  20H
			CMD
			DATO
			CNN
			ROOST
			TUPAC
			TROOPER0
			TROOPER1
            TROOPER2
            TROOPER3
			V0
            V1
            V2
            N
			N1
			N2
			ENDC
;-----------INICIO--------------------------------------------------------
			ORG 000H

            BCF     STATUS,RP1
			BSF     STATUS,RP0

			CLRF    TRISA
			MOVLW   0F0H
			MOVWF   TRISB
            CLRF    TRISC
            BSF     TRISC,7

            MOVLW 07H
			MOVWF OPTION_REG
            MOVLW   19H
            MOVWF   SPBRG           ;Configura la velocidad a 9600bps
            CLRF    TXSTA
            BSF     TXSTA,2
            BSF     TXSTA,5

			BCF     STATUS,RP0
			CLRF    PORTA
			CLRF    PORTB
            CLRF    PORTC
            clrf    RCSTA
            BSF     RCSTA,4
            BSF     RCSTA,7

;-----------INICIALIZACION Y CONF DE LCD---------------------------------
			CALL    LCD_INI
			CALL    LCD_CONF
			MOVLW   01H
			CALL    LCD_CMD
			CALL    T5MS
			;CALL    CYC
 ;----------PRINCIPAL-----------------------------------------------------
MAIN:		MOVLW   01H
			CALL    LCD_CMD
			CALL    T5MS
			MOVLW   01H
			CALL    LCD_CMD
			CALL    T5MS
            MOVLW 82H
			CALL LCD_CMD
CICLO:      CALL Get_Serial
            CALL   SEP
            MOVF    N1,0
            CALL    TABLA
			CALL LCD_DATO
            MOVF    N2,0
            CALL TABLA
            CALL LCD_DATO
            GOTO    CICLO
            #INCLUDE<TIEMPOS.INC>
			#INCLUDE<LCD.INC>
			;#INCLUDE<CARACTERES.INC>
			;#INCLUDE<TEXTOS.INC>
            #INCLUDE<COMSERIAL.INC>
SEP:        MOVWF	N
			SWAPF	N,W
			ANDLW	0FH
			MOVWF   N1
			MOVF	N,W
			ANDLW	0FH
            MOVWF   N2
			RETURN
TABLA:      ADDWF   PCL,1
            RETLW   '0'
            RETLW   '1'
            RETLW   '2'
            RETLW   '3'
            RETLW   '4'
            RETLW   '5'
            RETLW   '6'
            RETLW   '7'
            RETLW   '8'
            RETLW   '9'
            RETLW   'A'
            RETLW   'B'
            RETLW   'C'
            RETLW   'D'
            RETLW   'E'
            RETLW   'F'
            END





