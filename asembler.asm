.386
.model flat, stdcall
option casemap:none

includelib msvcrt.lib
includelib kernel32.lib
includelib legacy_stdio_definitions.lib
includelib ucrt.lib
includelib vcruntime.lib

printf PROTO C :PTR SBYTE, :VARARG
scanf PROTO C :PTR SBYTE, :VARARG
ExitProcess PROTO :DWORD

.data
	inputFmt db "%d", 0
	outputFmt db "%d ", 0
	pr db " ", 10, 0
	brojevi DWORD 5 dup(?)
	veci0 DWORD 5 dup(?)
	manji0 DWORD 5 dup(?)
	brojveci dd 0
	brojmanji dd 0
	msg1 db "Veci: ", 10, 0
	msg2 db "Manji: ", 10, 0

.code
main PROC
	
	mov esi, OFFSET brojevi
	mov ebx, 5

	unos:
		INVOKE scanf, ADDR inputFmt, esi
		add esi, 4
		dec ebx
		cmp ebx, 0
		jg unos

	
	mov esi, OFFSET brojevi
	mov ebx, 5

	petlja:
		mov eax, [esi]
		cmp eax, 0
		jg veci
		jl manji
		jmp kraj

		veci:
			mov edx, brojveci
            mov veci0[edx*4], eax
			inc brojveci
			jmp kraj
		
		manji:
			mov edx, brojmanji
            mov manji0[edx*4], eax
			inc brojmanji
			jmp kraj

		kraj:
			add esi, 4
			dec ebx
			cmp ebx, 0
			jg petlja
		
	
	INVOKE printf, ADDR msg1
	izlazv:
		cmp brojveci, 0
		je van1
		dec brojveci
		mov edx, brojveci
		INVOKE printf, ADDR outputFmt, veci0[edx*4]
		cmp brojveci, 0
		jg izlazv

	van1:

	INVOKE printf, ADDR pr
	INVOKE printf, ADDR msg2
	izlazm:
		cmp brojmanji, 0
		je van2
		dec brojmanji
		mov edx, brojmanji
		INVOKE printf, ADDR outputFmt, manji0[edx*4]
		cmp brojmanji, 0
		jg izlazm
	
	van2:

	INVOKE ExitProcess, 0

main ENDP
END main