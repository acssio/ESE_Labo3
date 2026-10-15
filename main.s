	AREA    |.text|, CODE, READONLY

      EXPORT  asm_main
      IMPORT  Ext_Debug_Init
      IMPORT  SystemClock_Config
	  IMPORT  memcpy
		  
rData0 RN 10
rData1 RN 11
regODR RN 9

asm_main PROC
	bl 	Ext_Debug_Init
	
	
	;to increase system clock
	bl 		SystemClock_Config ; set speed @ 216MHz
	ldr 	r0,=0xE000E010 ; systick control register address
	mov 	r1,#0 ; value to stop systick
	str 	r1,[r0] ; stop systick
	
	ldr		regODR, =ODR
	ldr		regODR,[regODR]	; save the ODR value in a register
	
	mov		rData0, #0x000	; Register value 0 for the pin 9
	mov		rData1, #0x200 	; Register value 1 for the pin 9

loop
	; ----------------- BASE -------------
	;ldr    	r4,=TableA
	;ldr    	r5,=TableB
	;mov    	r6,#TableB-TableA
	; ------------------------------------
	
	; ----------------- Opti -------------
	;ldr 	sp, =TableA ; Set the adress of table A
	;ldr		r9, =TableB	; Set the adress of table B
	; ------------------------------------
	
	ldr    	r0,=TableA
	ldr    	r1,=TableB
	mov    	r2,#TableB-TableA 
	
	
	
	str		rData1, [regODR] ; Write '1' to the pin 9 of the 26 pins

copy
	bl memcpy ; Copy with memcpy
	
	str		rData0, [regODR]
	
	b    loop
	
	; ----------------- Opti -------------
	;LDMIA	sp!,{r0-r8} ; Copy and paste first
	;STMIA	r9!,{r0-r8}
	
	;LDMIA	SP,{r0-r8}	; Copy and paste second part
	;STMIA	r9,{r0-r8}
	; ------------------------------------
	
	; ----------------- BASE -------------
	;ldr   	r7,[r4],#4
	;str   	r7,[r5],#4
	;subs   	r6,r6,#4
	;bne    	copy
	; ------------------------------------
	
	ENDP

;-------------------------------------------------------------------
; Data section
;-------------------------------------------------------------------
	AREA  |.data|, DATA, READWRITE, ALIGN=4
		
TableA		DCB 	"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
			DCB 	"abcdefghijklmnopqrstuvwxyz+-.,<>()/#"
			
endTableA
TableB		SPACE   endTableA-TableA
ODR			DCD		0x40021414

	END