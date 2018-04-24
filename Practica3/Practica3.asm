/*
 * Practica3.asm
 *
 *  Created on: 24/04/2018
 *      Author: usuario_local
 */

/*-----------------------------------------------------------------
**
**  Fichero:
**    pract3a.asm  10/6/2014
**
**    Fundamentos de Computadores
**    Dpto. de Arquitectura de Computadores y Automática
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Ordena de mayor a menor un vector de enteros positivos
**
**  Notas de diseño:
**    Utiliza una subrutina que devuelve la posición del valor
**    máximo de un vector de enteros positivos
**
**---------------------------------------------------------------*/

.global start

.EQU 	N, 8

.data
A: 		.word 7,3,25,4,75,2,1,1

.bss
max: 	.space 4
ind:	.space 4
B:		.space 4*N

.text
start:
		/*ldr sp, =_stack					@ Cargo pila*/
		mov fp, #0						@ Cargamos un 0 al frame
		mov r0, #0						@ Movemos un 0 a r0
		ldr r1, =max					@ Leo la dir. de max
		str r0, [r1]					@ Escribo 0 en max
		mov r2, #N						@ Tiene el valor de N
		mov r4, #0						@ Escribo 0 en j

for1:
		cmp r4, r2						@ Si se cumple
		bge fin							@ Salta a fin
		ldr r0, =A						@ Sino, cargame el puntero de A para la subrutina
		bl max_int						@ Subrutina, nos devuelve el valor maximo
		mov r7, r0						@ Pasamos el valor a ind
		ldr r6, =A						@ Cargamos el puntero otra vez, r0 sobreescrito :,(
		ldr r8, =B						@ Cargamos puntero de B
		ldr r9, [r6, r7, LSL #2]		@ Cargamos la posicion A[ind]
		str r9, [r8, r4, LSL #2]		@ Guardamos en B[j] A[ind]
		mov r10, #0						@ Cargamos un 0 a r9
		str r10, [r6, r7, LSL #2] 		@ Almacenamos un 0 a A[ind]
		add r4, r4, #1					@ Cago en dios dos putas horas porque se me ha olvidado suma un uno!!! Que mala ostia TT
		b for1							@ Salto a for1

		/* Comienzo subrutina max */

max_int:
		push {r5-r10, fp} 				@ Cargamos registros de la subrutina, no LR subrutina hoja
	/*	add fp, sp, #24					@ Desplazamos puntero de pila 4*7-4=24*/
		mov r5, r0						@ Movemos puntero de A para no perderlo
		mov r6, #0						@ Inicializamos i
		mov r7, r1						@ Cargamos max
		mov r8, #0						@ Movemos un 0
		str r8, [r7]					@ Para cargarlo en max
		ldr r9, =ind					@ Cargamos ind
		str r8, [r9]					@ Y le cargamos un fucking 0

for2:
		cmp r6, r2						@ Comparamos i con N
		bge fin_sub						@ Si cumple salta al final de la subrutina
		ldr r8, [r5, r6, LSL #2]		@ Si no me cargas A[i]
		ldr r10, [r7]					@ Cargamos a otro registro el valor de max
if:		cmp r8, r10						@ Y me comparas A[i] con max
		ble fin_if						@ Si no cumple salta al final del if
		str r8, [r7] 					@ Pero si se cumple, me pasas a max el valor de A[i]
		str r6, [r9]					@ Y me llevas i a ind

fin_if:
		add r6, r6, #1					@ Sumamos uno a i
		b for2							@ Saltamos al inicio del bucle

fin_sub:
		ldr r0, [r9]					@ Cargamos a r0 el resultado
		pop {r5-r10, fp}				@ Devolvemos pila
		mov pc, lr

fin:
		.end
