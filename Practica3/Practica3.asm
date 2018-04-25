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
		mov fp, #0						@ Cargamos un 0 al frame
		mov r0, #0						@ Movemos un 0 a r0
		ldr r1, =max					@ Leo la dir. de max
		str r0, [r1]					@ Escribo 0 en max
		mov r1, #N						@ Tiene el valor de N
		mov r4, #0						@ Escribo 0 en j

for1:
		cmp r4, r1					@ Si se cumple
		bge for3							@ Salta a fin
		ldr r0, =A						@ Sino, cargame el puntero de A para la subrutina
		bl max_int						@ Subrutina, nos devuelve el valor maximo
		mov r7, r0						@ Pasamos el valor a ind
		ldr r6, =A						@ Cargamos el puntero otra vez, r0 sobreescrito :,(
		ldr r8, =B						@ Cargamos puntero de B
		ldr r9, [r6, r7, LSL #2]		@ Cargamos la posicion A[ind]
		str r9, [r8, r4, LSL #2]		@ Guardamos en B[j] A[ind]
		mov r10, #0						@ Cargamos un 0 a r10
		str r10, [r6, r7, LSL #2] 		@ Almacenamos un 0 a A[ind]
		add r4, r4, #1					@ Sumo 1
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
		cmp r6, r1						@ Comparamos i con N
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

for3:
		cmp r10, r1						@ R10 es nuestra i, comparamos con tamaño
		bge	fin							@ Si se cumple salta a fin
		ldr r9, [r8, r10, LSL #2]		@ Me cargas B[i]
		str r9, [r6, r10, LSL #2]		@ Me almacenas B[i] a A[i]
		add r10, r10, #1				@ Sumame uno a la i
		b for3


/*sub3:
		push {r4-r8, fp}
		mov r4, r0						@ Puntero de A
		mov r5, r1						@ Tamaño puntero
		mov r6, r2						@ Puntero de B
		mov r7, #0						@ Inicializamos i
for4:	cmp r7, r5
		bge fin_sub1
		ldr r8, [r6, r7, LSL #2]
		str r8, [r4, r7, LSL #2]
		add r7, r7, #1
		b for4

fin_sub1:
		pop {r4-r8, fp}
*/

fin:

		.end
