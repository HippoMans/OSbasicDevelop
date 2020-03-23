[ORG 0x00]	; 코드의 시작 어드레스를 0x00으로 설정
[BITS 16]       ; 이하의 코드는 16비트 코드로 설정

SECTION .text   ; text 섹션(세그먼트)를 정의

jmp 0x07C0:START	;CS 세그먼트 레지스터에 0x07C0을 복사하면서 START 레이블로 이동

START:
	mov ax, 0x07C0	;루트 로더의 시작 어드레스(0x07C0)를 세그먼트 레지스터 값으로 변환
	mov ds, ax	;DS 세그먼트 레지스터에 설정
	mov ax, 0xB800	;AX 레지스터에 0xB800을 세그먼트 레지스터 값으로 변환
	mov es, ax	;ES 세그먼트 레지스터에 설정
	
	mov si, 0	; SI 레지스터(문자열 우너본 인덱스 레지스터)를 초기화

.SCREENCLEARLOOP:
	mov byte [es:si], 0
	mov byte [es:si + 1], 0x0A
	add si, 2
	cmp si, 80 * 25 *2
	jl .SCREENCLEARLOOP

	mov si, 0
	mov di, 0

.MESSAGELOOP:
	mov cl, byte [si + MESSAGE1]

	cmp cl, 0
	je .MESSAGEEND

	mov byte [es:di], cl

	add si, 1
	add di, 2

	jmp .MESSAGELOOP

.MESSAGEEND:
	jmp $

MESSAGE1: db 'MINT64 OS Boot Loader Start~~~!!', 0;

times 510 - ($ - $$)    db      0x00    ; $ : 현재 라인의 어드레스
                                        ; $$ : 현재 섹션(.text)의 시작 어드레스
                                        ; $ - $$ : 현재 섹션을 기준으로 하는 오프셋
                                        ; 510 - ($ - $$) : 현재부터 어드레스 510까지
                                        ; db 0x00 : 1바이트를 선언하고 값은 0x00
                                        ; time : 반복 수행
                                        ; 전체적 풀이 : 현재 위치에서 어드레스 510까지 0x00으로 채움

db 0x55                                 ; 1바이트를 선언하고 값은 0x55
db 0xAA                                 ; 1바이트를 선언하고 값은 0xAA
                                        ; 전체적 풀이 : 어드레스 511, 512에 0x55, 0xAA를 써서 부트 섹터로 표기함~
