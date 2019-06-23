EXTERN	HvmSubvertCpu:PROC

.CODE

GetCpuIdInfo PROC
   push   rbp
   mov      rbp, rsp
   push   rbx
   push   rsi

   mov      [rbp+18h], rdx
   mov      eax, ecx      ;//input
   cpuid
   mov      rsi, [rbp+18h]
   mov      [rsi], eax
   mov      [r8], ebx
   mov      [r9], ecx
   mov      rsi, [rbp+30h]
   mov      [rsi], edx

   pop      rsi
   pop      rbx
   mov      rsp, rbp
   pop      rbp
   ret
GetCpuIdInfo ENDP

CmSubvert PROC
	;���ݿͻ����Ĵ���
	push	rax
	push	rcx
	push	rdx
	push	rbx
	push	rbp
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	push	r14
	push	r15;��������Щ�Ĵ����е�ֵ�ŵ�GuestRsp����ṹ���У�Rsp���ǽṹ��ĵ�ַ

	sub	rsp, 28h;fastcall ����Լ����rcx,rdx,r8,r9,rip��5���Ĵ�����5*8=40=28h

	mov	rcx, rsp           ; __fastcall��rcx���ݵ�һ������GuestRsp
	                       ; x64ͳһΪ__fastcall: ǰ�ĸ�������RCX,RDX,R8,R9���δ���
	call	HvmSubvertCpu  ; VmxSubvertCpuҪ��һ������GuestRsp defined in hvm.c,���Ǳ�����Щ�Ĵ���

CmSubvert ENDP

CmGuestEip PROC

	add	rsp, 28h
	;�ָ��ͻ����Ĵ���������host����guest��ִ��,�ѽ���VMM֮ǰ��register�ָ���Guest��
	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	r11
	pop	r10
	pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rbp
	pop	rbx
	pop	rdx
	pop	rcx
	pop	rax

	ret

CmGuestEip ENDP

END
