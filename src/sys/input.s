;;
;; INPUT SYSTEMS
;;
.include "cpctelera.h.s"
.include "man/entity.h.s"
.include "cmp/entity.h.s"
.include "cpct_functions.h.s"
;.include "sys/colisions.h.s"
.include "physics.h.s"
.include "man/game.h.s"



;; //////////////////
;; SYS_Input Init
sys_input_init::
	ret


;; //////////////////
;; Sys_Input update
;; Input: IX -> pointer to entity[0]
;; Destroy: AF, BC, DE, HL, IX
sys_input_update::
	;; Reset velocities
	ld	e_vx(ix), #0
	ld 	e_vy(ix), #0

	call cpct_scanKeyboard_f_asm


	ld	hl, #Key_O
	call cpct_isKeyPressed_asm
	jr	z, O_NotPressed
O_Pressed:
	call get_hero_jump_right   ;; colisionamos por la derecha
		ld	b, a
		or	a
		jr	z, O_NotPressed   ;; si da 0, estamos haciendo el salto lateral con la jump talbr
			ld	e_vx(ix), #-1
O_NotPressed:

	ld	hl, #Key_P
	call cpct_isKeyPressed_asm
	jr	z, P_NotPressed
P_Presed:
	call get_hero_jump_left   ;; colisionamos por la derecha
		ld	b, a
		or	a
		jr	z, P_NotPressed   ;; si da 0, estamos haciendo el salto lateral con la jump talbr
			ld	e_vx(ix), #1
P_NotPressed:

	ld 	e_ai_aim_x(ix), #0		;; comprueba si se ha pulsado el espacio para cambiar la IA
	ld	hl, #Key_Space
	call cpct_isKeyPressed_asm
	jr	z, Space_NotPressed
Space_Pressed:
	ld 	e_ai_aim_x(ix), #1
Space_NotPressed:



	ld	hl, #Key_W
	call cpct_isKeyPressed_asm
	jr	z, W_NotPressed
W_Pressed:
	call start_jump
	jr	jumping
W_NotPressed:
	call not_jump
jumping:



ld	hl, #Key_M
	call cpct_isKeyPressed_asm
	jr	z, M_NotPressed
M_Pressed:
	call abrir_cerrar_menuIngame
M_NotPressed:


	ret