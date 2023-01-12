;============================================================

;PROJECT BY:

;21L-1830
;21L-7642

;===========================================================

[org 0x0100]

        
;=====================================================================================

;HD INTRO SCREEN

;=====================================================================================

       
;=========================================

;orange

;=========================================

 mov ax, 0x000D ; set 320x200 graphics mode 
 int 0x10 ; bios video services 


 mov ax, 0x0C06 ; put pixel in white color 

 mov cx, 0 ; x position 200 
 mov dx, 0 ; y position 200 

l1_HD: int 0x10 ; bios video services 
add cx,1 ; decrease y position 
 cmp cx,32000 ; decrease x position and repeat 
 jne l1_HD

 
;=========================================

;blue

;=========================================

mov ax, 0x000D ; set 320x200 graphics mode 

 mov ax, 0x0C01 ; put pixel in white color 
 
 mov cx, 0 ; x position 200 
 mov dx, 100 ; y position 200 

l2_HD: int 0x10 ; bios video services 
add cx,1 ; decrease y position 
 cmp cx,32000 ; decrease x position and repeat 
 jne l2_HD
  

;=========================================

;fish body

;=========================================

mov si, 124

dm_HD: 
 add si, 1
 
mov ax, 0x000D ; set 320x200 graphics mode 

 mov ax, 0x0C0c ; put pixel in white color 

 mov cx, 140  ; x position 200 
 mov dx, si ; y position 200 

l3_HD: int 0x10 ; bios video services 
 add cx,1 ; decrease y position 
 cmp cx, 170 ; decrease x position and repeat 
jne l3_HD


cmp dx, 140 ;is fish fat enough?
jne dm_HD


;=========================================

;fish tail vertical

;=========================================

mov si, 126

dm1_HD: 
 add si, 1
 
mov ax, 0x000D ; set 320x200 graphics mode 

 mov ax, 0x0C0c ; put pixel in white color 

 mov cx, 183  ; x position 200 
 mov dx, si  ; y position 200 

l4_HD: int 0x10 ; bios video services 
 add cx,1 ; decrease y position 
 cmp cx, 186 ; decrease x position and repeat 
jne l4_HD


cmp dx, 138 ;is fish fat enough?
jne dm1_HD



;=========================================

;fish tail tail horizontal

;=========================================

 
mov ax, 0x000D ; set 320x200 graphics mode 

 mov ax, 0x0C0c ; put pixel in white color 

 mov cx, 170  ; x position 200 
 mov dx, 133  ; y position 200 

l5_HD: int 0x10 ; bios video services 
 add cx,1 ; decrease y position 
 cmp cx, 186 ; decrease x position and repeat 
jne l5_HD


;=========================================

;add some text

;=========================================

; Video Service # 13 http://www.delorie.com/djgpp/doc/rbinter/id/15/2.html
;Example 8.2 - print string using bios service
jmp start_HD2
message9_HD: db 'Welcome to Fish Game!'

start_HD2:  mov ah, 0x13        ; service 13 - print string
        
        mov al, 1           ; subservice 01 – update cursor 
        ;????????????????????????????????WHAT WILL BE THE OUTPUT IF AL = 0???

        ;Text video screen is in the form of pages which can be upto 32. At
        ;one time one page is visible which is by default the zeroth page
        ;unless we change it. 
        mov bh, 0           ; output on page 0
        
        mov bl, 01001010B   ; normal attrib
        mov cx, 21          ; length of string
        mov dx, 0x020A     ; row 10 column 3
        
        ;es:bp = ds:message
        push ds
        pop es              ; es=ds segment of string
        mov bp, message9_HD     ; bp = offset of string
        
        INT 0x10            ; call BIOS video service


jmp start_HD3
message8_HD: db 'Press Enter to Continue'

start_HD3:  mov ah, 0x13        ; service 13 - print string
        
        mov al, 1           ; subservice 01 – update cursor 
       
        ;Text video screen is in the form of pages which can be upto 32. At
        ;one time one page is visible which is by default the zeroth page
        ;unless we change it. 
        mov bh, 0           ; output on page 0
        
        mov bl, 01001110B   ; normal attrib
        mov cx, 23          ; length of string
        mov dx, 0x0409     ; row 10 column 3
        
        ;es:bp = ds:message
        push ds
        pop es              ; es=ds segment of string
        mov bp, message8_HD     ; bp = offset of string
        
        INT 0x10            ; call BIOS video service


jmp start_HD
message10_HD: db 'Zaki Qasim 21L-7642'

start_HD:  mov ah, 0x13        ; service 13 - print string
        
        mov al, 1           ; subservice 01 – update cursor 
        ;????????????????????????????????WHAT WILL BE THE OUTPUT IF AL = 0???

        ;Text video screen is in the form of pages which can be upto 32. At
        ;one time one page is visible which is by default the zeroth page
        ;unless we change it. 
        mov bh, 0           ; output on page 0
        
        mov bl, 01000100B   ; normal attrib
        mov cx, 19          ; length of string
        mov dx, 0x1714      ; row 10 column 3
        
        ;es:bp = ds:message
        push ds
        pop es              ; es=ds segment of string
        mov bp, message10_HD     ; bp = offset of string
        
        INT 0x10            ; call BIOS video service



jmp start1_HD
message11_HD: db 'Fahad Mahmood 21L-1830'

start1_HD:  mov ah, 0x13        ; service 13 - print string
        
        mov al, 1           ; subservice 01 – update cursor 
        

        ;Text video screen is in the form of pages which can be upto 32. At
        ;one time one page is visible which is by default the zeroth page
        ;unless we change it. 
        mov bh, 0           ; output on page 0
        
        mov bl, 01010011B   ; normal attrib 01010011B 
        mov cx, 22          ; length of string
        mov dx, 0x1811      ; row 10 column 3
        
        ;es:bp = ds:message
        push ds
        pop es              ; es=ds segment of string
        mov bp, message11_HD    ; bp = offset of string
        
        INT 0x10            ; call BIOS video service

;=========================================

;take key and end video service

;=========================================

 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; bios keyboard services 
 mov ax, 0x0003 ; 80x25 text mode 
 int 0x10 ; bios video services 





;=====================================================================================

;THE GAME ITSELF

;=====================================================================================


jmp start

tempsky: times 30 db 0		;Two 20 size arrays with values set to 0
tempsea: times 30 db 0

score: dw 0

message: db 'Welcome to FISH GAME!!' ; string to be printed 
length: dw 22 ; length of the string 

message1: db 'Project By:' ; string to be printed 
length1: dw 11 ; length of the string 

message2: db 'Fahad Mahmood 21L-1830' ; string to be printed 
length2: dw 22 ; length of the string 

message3: db 'Zaki Qasim    21L-7642' ; string to be printed 
length3: dw 22 ; length of the string 

message4: db 'Press Enter to continue' ; string to be printed 
length4: dw 23 ; length of the string 





start:

call clrscr_welcome ; call the clrscr subroutine 
jmp print_welcome

;====================================================

;LIGHT BLUE SCREEN CODE (not really clearscreen)

;======================================================

; subroutine to clear the screen 
clrscr_welcome: push es 
 push ax 
 push di
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 0 ; point di to top left column 
nextloc_welcome: mov word [es:di], 0x3720 ; clear next char on screen 
 add di, 2 ; move to next screen location 
 cmp di, 4000 ; has the whole screen cleared 
 jne nextloc_welcome ; if no clear next position 
 pop di 
 pop ax 
 pop es 
 ret 



;====================================================

;PRINT STRING CODE 'WELCOME TO FINISH GAME'

;======================================================

print_welcome:

mov ax, message 
 push ax ; push address of message 
 push word [length] ; push message length 
 call printstr_welcome ; call the printstr subroutine 

jmp print1_welcome

;===

; subroutine to print a string at top left of screen 
; takes address of string and its length as parameters 
printstr_welcome: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 1650 ; point di to top left column 
 mov si, [bp+6] ; point si to string 
 mov cx, [bp+4] ; load length of string in cx 
 mov ah, 0xD7 ; normal attribute fixed in al 
nextchar_welcome: mov al, [si] ; load next char of string 
 mov [es:di], ax ; show this char on screen 
 add di, 2 ; move to next screen location 
 add si, 1 ; move to next char in string 
 loop nextchar_welcome ; repeat the operation cx times 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4 


 

;======================================================

;PRINT STRING CODE 'PROJECT BY:'

;======================================================

;-------
print1_welcome:
 mov ax, message1
 push ax ; push address of message 
 push word [length1] ; push message length 
 call printstr1_welcome ; call the printstr subroutine 

 jmp print2_welcome
;-----


; subroutine to print a string at top left of screen 
; takes address of string and its length as parameters 
printstr1_welcome: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 3314    ; point di to top left column 
 mov si, [bp+6] ; point si to string 
 mov cx, [bp+4] ; load length of string in cx 
 mov ah, 0x17 ; normal attribute fixed in al 
nextchar1_welcome: mov al, [si] ; load next char of string 
 mov [es:di], ax ; show this char on screen 
 add di, 2 ; move to next screen location 
 add si, 1 ; move to next char in string 
 loop nextchar1_welcome ; repeat the operation cx times 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4 


;======================================================

;PRINT STRING CODE 'FAHAD MAHMOOD'

;======================================================
;---
print2_welcome:
mov ax, message2
 push ax ; push address of message 
 push word [length2] ; push message length 
 call printstr2_welcome ; call the printstr subroutine 

 jmp print3_welcome
;---


; subroutine to print a string at top left of screen 
; takes address of string and its length as parameters 
printstr2_welcome: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 3474 ; point di to top left column 
 mov si, [bp+6] ; point si to string 
 mov cx, [bp+4] ; load length of string in cx 
 mov ah, 0x46 ; normal attribute fixed in al 
nextchar2_welcome: mov al, [si] ; load next char of string 
 mov [es:di], ax ; show this char on screen 
 add di, 2 ; move to next screen location 
 add si, 1 ; move to next char in string 
 loop nextchar2_welcome ; repeat the operation cx times 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4 




;======================================================

;PRINT STRING CODE 'ZAKI QASIM'

;======================================================

print3_welcome:
 mov ax, message3
 push ax ; push address of message 
 push word [length3] ; push message length 
 call printstr3_welcome ; call the printstr subroutine 

jmp print4_welcome


; subroutine to print a string at top left of screen 
; takes address of string and its length as parameters 
printstr3_welcome: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 3634 ; point di to top left column 
 mov si, [bp+6] ; point si to string 
 mov cx, [bp+4] ; load length of string in cx 
 mov ah, 0x64 ; normal attribute fixed in al 
nextchar3_welcome: mov al, [si] ; load next char of string 
 mov [es:di], ax ; show this char on screen 
 add di, 2 ; move to next screen location 
 add si, 1 ; move to next char in string 
 loop nextchar3_welcome ; repeat the operation cx times 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4 

;====================================================

;PRINT STRING CODE 'PRESS ENTER TO CONTINUE'

;======================================================

print4_welcome:

mov ax, message4
 push ax ; push address of message 
 push word [length4] ; push message length 
 call printstr4_welcome ; call the printstr subroutine 

jmp rec_welcome

;===

; subroutine to print a string at top left of screen 
; takes address of string and its length as parameters 
printstr4_welcome: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 1810 ;  
 mov si, [bp+6] ; point si to string 
 mov cx, [bp+4] ; load length of string in cx 
 mov ah, 0xC7 ; normal attribute fixed in al 
nextchar4_welcome: mov al, [si] ; load next char of string 
 mov [es:di], ax ; show this char on screen 
 add di, 2 ; move to next screen location 
 add si, 1 ; move to next char in string 
 loop nextchar4_welcome ; repeat the operation cx times 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4 



;================================================================

; PRINT THE BAORD BORDERS

;================================================================



;--------------------------

rec_welcome: ;  UP BORDER

    mov ax,0xb800
    mov es,ax
    mov di,1300

rect_welcome: 
    mov word[es:di],0x173D
    add di,2
    cmp di,1400
    jne rect_welcome

    je setdown_welcome

setdown_welcome: ;RIGHT BORDER
    mov di,1400

down_welcome:
    mov word[es:di],0x277C
    add di,160
    cmp di,2520
    jne down_welcome

seftleft_welcome: ;DOWN BORDER
    mov di,2358

left_welcome:
    mov word[es:di],0x743D
    sub di,2
    cmp di,2258
    jne left_welcome

setup_welcome: ;LEFT BORDER
    mov di,2258

up_welcome:
    mov word[es:di],0x277C

    sub di,160
    cmp di,1138
    jne up_welcome

setleftleg_welcome:
    mov di,2590
leftleg_welcome:
    mov word[es:di],0x477C
    add di,160
    cmp di,3710 
    jne leftleg_welcome

;print left and right LEG FOR board

setrightleg_welcome:
    mov di,2670
rightleg_welcome:
    mov word[es:di],0x477C
    add di,160
    cmp di,3950
    jne rightleg_welcome

;=======================================================

;PRINT THE BOARD LIGHTS BLINKING

;================================================================


rec_welcome1: ;top border


    mov ax,0xb800 ;top border
    mov es,ax
    mov di,1136

rect_welcome1:
    mov word[es:di],0xc73d
    add di,2
    cmp di,1244
    jne rect_welcome1

    je setdown_welcome1

setdown_welcome1:  ;do right border 
    mov di,1402 

down_welcome1:
    mov word[es:di],0xd77C
    add di,160
    cmp di,2522 ; 8 rows
    jne down_welcome1

setup_welcome1: ;do left border
    mov di,2256

up_welcome1: 
    mov word[es:di],0xd77C

    sub di,160
    cmp di,1136
    jne up_welcome1

setdownborder_welcome1:
    mov di,2416

downborder_welcome1:
    mov word[es:di],0xe73d
    add di,2
    cmp di,2524
    jne downborder_welcome1

    

;=======================================================

;PRINT THE GRASS FOR WELCOME SCREEN

;================================================================

setgrass_welcome:
    push es
    push ax
    push di
    
    mov ax,0xb800 ;Function for setting grass
    mov es,ax
    mov di,3680
    jmp grass_welcome

grass_welcome:

    mov word [es:di], 0x327C
    add di,2
    cmp di,4000
    jne grass_welcome
    
    pop di  
    pop ax
    pop es  






jmp start_welcome


kbsir_welcome:
	push ax
	push es
	
	mov ax,0xb800
	mov es,ax

	in al,0x60
	cmp al,0x1c
	je nomatch_welcome
	jne nomatch_welcome
	jmp nomatch_welcome
		
nomatch_welcome:
	mov al,0x20
	out 0x20,al

	pop es
	pop ax
	

	jmp setsky

	iret


start_welcome:
	xor ax,ax
	mov es,ax
	cli
	mov word[es:9*4],kbsir_welcome
	mov word[es:9*4+2],cs
	sti


loop_welcome:
	jmp loop_welcome


;===========================================================================


jmp setsky



movesky:
	push ax			;pushes al the registers
	push cx
	push dx
	push si
	push di
	push es	

;==============================================================================

	mov ax, 0xb800
	mov es, ax
	mov di, tempsky
	mov si, 0
	mov cx, 7	
	mov ax, 0
movskyl1:
	mov ax, [es:si]
	mov [cs:di], ax
	add di,2
	add si, 160
	loop movskyl1

	mov cx, 7
	mov di, 0
	mov dx, 158
	mov ax, 0

movskyl2:
	mov ax, [es: di + 2]
	mov [es:di], ax
	add di, 2
	cmp di, dx
	jne movskyl2
	add di, 2
	add dx, 160
	loop movskyl2
	
	mov di, 158
	mov si, tempsky
	mov cx, 7
	mov ax, 0xb800
	mov es, ax
	mov ax, 0
movskyl3:
	mov ax, [cs:si]
	mov [es:di], ax
	add si, 2
	add di, 160
	loop movskyl3
;==============================================
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop ax
	ret
;================================================

movesea:
	push ax
	push cx
	push dx
	push si
	push di
	push es

;==================================================
	mov di, tempsea
	mov si, 1758
	mov cx, 8
	mov ax, 0xb800
	mov es, ax
	mov ax, 0
movseal4:
	mov ax, [es:si]
	mov [cs:di], ax
	add di, 2
	add si, 160
	loop movseal4

	mov cx,8
	mov di, 2718
	mov dx, di
	sub dx, 158
	mov ax, 0

movseal5:
	mov ax, [es: di - 2]
	mov [es:di], ax
	sub di, 2
	cmp di, dx
	jne movseal5
	sub di, 2
	sub dx, 160
	loop movseal5

	mov di, 1600
	mov si, tempsea
	mov cx, 8
	mov ax, 0xb800
	mov es, ax
	mov ax, 0
movseal6:
	mov ax, [cs:si]
	mov [es:di], ax
	add si, 2
	add di, 160
	loop movseal6
;==============================================
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop ax
	ret
;===============================================
sleep: 
	push cx
	mov cx, 0xFFFF

delay: 
	loop delay
	pop cx
	ret









;===============================================


setsky: 
	push ax
	push es
	push di
	
	mov ax,0xb800 		;These 2 functions Set sky
	mov es,ax
	mov di,0
	jmp sky

sky:
	mov word [es:di], 0x3E20
	add di, 2
	cmp di, 960
	jne sky

	pop di
	pop es
	pop ax


;===============================================


setmiddlesky: 
	push ax
	push es
	push di
	
	mov ax,0xb800 		;These 2 functions Set sky
	mov es,ax
	mov di,1400
	jmp middlesky

middlesky:
	mov word [es:di], 0x7F20
	add di, 2
	cmp di, 4000
	jne middlesky

	pop di
	pop es
	pop ax
;=================================================

setsea:
	
	mov ax,0xb800 ;Function for setting sea
	mov es,ax
	mov di,2720
	jmp sea

sea: 
	mov word [es:di], 0x1F20
	add di, 2
	cmp di, 4000
	jne sea
	je setmountain


;=============================================================

setmountain: 
	
	push ax
	push es
	push di
	push cx

	mov ax,0xb800 		;Function for setting mountains
	mov es,ax
	mov di,20
	mov word [es:di], 0x3E2F
	mov cx,25

mountain:
	add di, 40 		;Distance between top of 2 mountains is set as 40.
	mov word [es:di], 0x3E2F
	cmp di,140
	jne mountain
	je mountainloop1

mountainloop1:	
	add di,38
	mov word [es:di], 0x3E2F
	loop mountainloop1
	jmp setmountainloop2

setmountainloop2:
	mov di,20
	mov cx,10 ;Various loop are used for the setting
			;of right and left side of mountains
	jmp mountainloop2

mountainloop2:
	add di,42
	mov word [es:di], 0x3E5C
	loop mountainloop2

	pop cx
	pop di
	pop es
	pop ax

	jmp setgrass

;=======================================================

setgrass:
	push es
	push ax
	push di
	
	mov ax,0xb800 ;Function for setting grass
	mov es,ax
	mov di,1120
	jmp grass
grass:

	mov word [es:di], 0x7A7C
	add di,2
	cmp di,1440
	jne grass
	
	pop di
	pop ax
	pop es	

	jmp setship

;=============================================================

setship: 
	mov ax,0xb800
	mov es,ax
	mov di,1940
	jmp ship

ship: 
	mov word [es:di], 0x7E5F ;Functions for setting 1st left side of
	add di, 2 ;ship
	cmp di, 1982
	jne ship
	je shiploop1

shiploop1: 
	mov ax,0xb800
	mov es,ax
	mov di,2100

	mov word [es:di], 0x7E5C
	add di, 2
	cmp di, 2102
	jne shiploop1
	jmp shiploop2

shiploop2:

	add di,160
	mov word [es:di], 0x7E5C
	cmp di,2582
	jne shiploop2
	je setbottomplank

setbottomplank: ;this sets the first bottom plank of the big ship
	mov di,2584
	

shiploop3:

	mov word [es:di], 0x7E5F
	add di,2
	cmp di,2610
	jne shiploop3
	je shiploop4

shiploop4:
	mov ax,0xb800
	mov es,ax
	mov di,2138

	mov word [es:di], 0x7E2F
	add di, 2
	cmp di,2140
	je shiploop5

shiploop5:
	add di,156
	mov word [es:di],0x7E2F
	cmp di,2608
	jne shiploop5
	jmp setchimneywidth
;=========================================================================


setchimneywidth: ;Function used for setting chimney width and height

	mov di,1472
	jmp chimneywidth

chimneywidth:
	mov word[es:di],0x7E5F
	add di,2
	cmp di,1484
	jne chimneywidth
	jmp setchimneyheight

setchimneyheight:

	mov di,1632
	jmp chimneyheight

chimneyheight:
	mov word[es:di],0x7E7C
	add di,10
	mov word[es:di],0x7E7C

	cmp di,1962
	je setship2

	add di,150
	cmp di,1962
	jne chimneyheight

;===============================================================

setship2:
	mov ax,0xb800
	mov es,ax ;Functions for setting 2nd ship
	mov di,2500

ship2:
	mov word [es:di], 0x7E5F
	add di, 2
	cmp di,2530
	jne ship2



ship2rhs: 
	add di,130
	mov word [es:di], 0x7E5C


ship2bottom:
	add di,2
	mov word [es:di], 0x7E5F
	cmp di,2684
	jne ship2bottom
	add di,2
	mov word [es:di], 0x7E2F
;=========================================================================
setship2chimneywidth: ;Functions for setting 2nd ship chimney and width
	mov di,2190


ship2chimney:
	mov word [es:di], 0x7E5F
	add di,2
	cmp di,2198
	jne ship2chimney


setship2chimneyheight:

	mov di,2350
	mov word [es:di], 0x7E7C

	add di,6
	mov word [es:di], 0x7E7C

	add di,154
	mov word [es:di], 0x7E7C

	add di,6
	mov word [es:di], 0x7E7C

;====================================================================


jmp start1


kbsir:
	push ax
	push es
	
	mov ax,0xb800
	mov es,ax

	in al,0x60			;takes input as char
	

left:
	cmp al,0x4b
	je temp
	jmp up
temp:
	mov word [es:di], 0x01F20
	sub di,2

	mov word [es:di], 0x3E20

	mov bx,di	

	cmp si,bx
	je RANDGEN2
	jne near nomatch

RANDGEN2:         ; generate a rand no using the system time
add word [cs:score], 10
RANDSTART2:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 640    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

   shl dx,1

   add dx,2720
  
   mov si,dx

   mov word[es:si],0x4F20

	add ax,10
   jmp printnum1_l

;code is for printing score on specific location on screen
;--------------------------------------------------------------------
printnum1_l:

push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

mov ax, 0xb800
mov es, ax

add ax,10
mov ax, [cs:score] ; point ax to score where you add points of coins
add ax,10
mov bx, 10
mov cx, 0

nextdigit1_l: mov dx, 0
div bx
add dl, 0x30
push dx

inc cx
cmp ax, 0
jnz nextdigit1_l


mov di, 2722 ; SAVE value of di where do you want to print number on screen
nextpos1_l: pop dx
mov dh, 0xAF
mov [es:di], dx
add di, 2
loop nextpos1_l

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp

;-------------------------------------------------------------------

	jmp nomatch
;================================================================
up:
	cmp al,0x48
	jne near down

	cmp di,2878
				;if the fish tries to move above water then print current location without movement
        jg temp1
	jmp dontmovup
temp1:
	mov word [es:di], 0x1F20	
	sub di,160
		
	mov word [es:di], 0x3E20
	
	mov bx,di
	
	cmp si,bx
	je RANDGEN3
	jne dontmovup

RANDGEN3:         ; generate a rand no using the system time
add word [cs:score], 10
RANDSTART3:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 640    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

  shl dx,1

   add dx,2720
  
   mov si,dx

   mov word[es:si],0x4F20
add ax,10
   jmp printnum1_u

;code is for printing score on specific location on screen
;--------------------------------------------------------------------
printnum1_u:

push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

mov ax, 0xb800
mov es, ax
add ax,10
mov ax, [cs:score] ; point ax to score where you add points of coins
add ax,10
mov bx, 10
mov cx, 0

nextdigit1_u: mov dx, 0
div bx
add dl, 0x30
push dx

inc cx
cmp ax, 0
jnz nextdigit1_u


mov di, 2722 ; SAVE value of di where do you want to print number on screen
nextpos1_u: pop dx
mov dh, 0xAF
mov [es:di], dx
add di, 2
loop nextpos1_u

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp

;-------------------------------------------------------------------

dontmovup:
					;Program has to pass this function at any cost.So a check is added to ensure that sound does not always beep.
	cmp di,2878			
	jle SOUNDup
	jge NOsoundup
SOUNDup:
	jmp sound

	delay1: push cx
	mov cx,0xffff
	l1: loop l1
	pop cx
	ret

sound:  mov cx, 1
	loop1:        
 	mov al, 0b6h
	out 43h, al

	;load the counter 2 value for d3
	mov ax, 1fb4h
	out 42h, al
	mov al, ah
	out 42h, al

	;turn the speaker on
	in al, 61h
	mov ah,al
	or al, 3h
	out 61h, al
	call delay1
	mov al, ah
	out 61h, al

	call delay1

	;load the counter 2 value for a3
	mov ax, 152fh
	out 42h, al
	mov al, ah
	out 42h, al

	;turn the speaker on
	in al, 61h
	mov ah,al
	or al, 3h
	out 61h, al
	call delay1
	mov al, ah
	out 61h, al

	call delay1
	
	;load the counter 2 value for a4
	mov ax, 0A97h
	out 42h, al
	mov al, ah
	out 42h, al
	
	;turn the speaker on
	in al, 61h
	mov ah,al
	or al, 3h
	out 61h, al
	call delay1
	mov al, ah
	out 61h, al

	call delay1
 
	loop loop1

NOsoundup:
	mov word [es:di], 0x3E20

	jmp nomatch	
;==============================================================

down:
	cmp al,0x50
	jne near right

	cmp di,3840
			;if the fish tries to move below water then print current location without movement
	jl temp2
	jmp dontmovdown
	
temp2:
	mov word [es:di], 0x1F20 
	add di,160	
	
	mov word [es:di], 0x3E20

	mov bx,di
	
	cmp si,bx
	je RANDGEN4
	jne dontmovdown

RANDGEN4:         ; generate a rand no using the system time
add word [cs:score], 10
RANDSTART4:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 640    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

   shl dx,1

   add dx,2720
  
   mov si,dx

   mov word[es:si],0x4F20
add ax,10
   jmp printnum1_d

;code is for printing score on specific location on screen
;--------------------------------------------------------------------
printnum1_d:

push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

mov ax, 0xb800
mov es, ax
add ax,10
mov ax, [cs:score] ; point ax to score where you add points of coins
add ax,10
mov bx, 10
mov cx, 0

nextdigit1_d: mov dx, 0
div bx
add dl, 0x30
push dx

inc cx
cmp ax, 0
jnz nextdigit1_d


mov di, 2722 ; SAVE value of di where do you want to print number on screen
nextpos1_d: pop dx
mov dh, 0xAF
mov [es:di], dx
add di, 2
loop nextpos1_d

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp

;-------------------------------------------------------------------


dontmovdown:
				;Program has to pass this function at any cost.So a check is added to ensure that sound does not always beep.
	cmp di,3840
	jge SOUNDdown
	jle NOsounddown

SOUNDdown:
	jmp sound2

	delay2: push cx
	mov cx,0xffff
	l2: loop l2
	pop cx
	ret

	sound2: mov cx, 1
	loop2:        
 	mov al, 0b6h
	out 43h, al

;load the counter 2 value for d3
	mov ax, 1fb4h
	out 42h, al
	mov al, ah
	out 42h, al

;turn the speaker on
	in al, 61h
	mov ah,al
	or al, 3h
	out 61h, al
	call delay2
	mov al, ah
	out 61h, al

	call delay2

;load the counter 2 value for a3
	mov ax, 152fh
	out 42h, al
	mov al, ah
	out 42h, al

;turn the speaker on
	in al, 61h
	mov ah,al
	or al, 3h
	out 61h, al
	call delay1
	mov al, ah
	out 61h, al

	call delay2
	
;load the counter 2 value for a4
	mov ax, 0A97h
	out 42h, al
	mov al, ah
	out 42h, al
	
;turn the speaker on
	in al, 61h
	mov ah,al
	or al, 3h
	out 61h, al
	call delay2
	mov al, ah
	out 61h, al

	call delay2
 
 	loop loop2

NOsounddown:

	mov word [es:di], 0x3E20

	jmp nomatch
;=================================================================

right:
	cmp al,0x4d
	jne exit
	mov word [es:di], 0x1F20
	add di,2	
	
	mov word [es:di], 0x3E20

	mov bx,di

	cmp si,bx
	je RANDGEN5
	jne nomatch

RANDGEN5:         ; generate a rand no using the system time
add word [cs:score], 10
RANDSTART5:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 640    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

   shl dx,1

   add dx,2720
  
   mov si,dx

   mov word[es:si],0x4F20

   jmp printnum1_r

;code is for printing score on specific location on screen
;--------------------------------------------------------------------
printnum1_r:

push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di



mov ax, 0xb800
mov es, ax

mov ax, [cs:score] ; point ax to score where you add points of coins
add ax,10
mov bx, 10
mov cx, 0

nextdigit1_r: mov dx, 0
div bx
add dl, 0x30
push dx

inc cx
cmp ax, 0
jnz nextdigit1_r


mov di, 2722 ; SAVE value of di where do you want to print number on screen
nextpos1_r: pop dx
mov dh, 0xAF
mov [es:di], dx
add di, 2
loop nextpos1_r

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp

;-------------------------------------------------------------------


	jmp nomatch

exit:	
	cmp al,0x01
	je exit1
	
	jmp nomatch

exit1:
	mov ah,0
	int 0x16
	
	jmp end


nomatch:
	mov al,0x20
	out 0x20,al

	pop es
	pop ax
	iret

start1:
mov ax,0xb800
mov es,ax

RANDGEN1:         ; generate a rand no using the system time
RANDSTART1:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 640    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

   shl dx,1

   add dx,2720
  
   mov si,dx

   mov word[es:si],0x4F20

	xor ax,ax
	mov es,ax
	cli
	mov word[es:9*4],kbsir
	mov word[es:9*4+2],cs
	sti
	mov di,3440
	mov word [es:di], 0x3E20

inf:
	call movesea
	call sleep
	call movesky
	call sleep
	jmp inf
;========================================================================



end: 
	mov ax, 0x4c00 ; terminate program
	int 0x21