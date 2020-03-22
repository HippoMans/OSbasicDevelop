# 64bit 멀티코어 OS 제작하기
한승훈 저자님의 "64비트 멀티코어 OS 원리와 구조" 책을 학습하면서 OS와 코드를 정리하였습니다.
한승훈 저자님 감사합니다.

## 멀티코어 환경설정
OS : Ubuntu 16.04.06 LTS
editor : vim

### 1. 필수 패키지 설치
ubuntu에서 작업을 실행하면 gcc 패키지와 g++패키지는 기본 패키지로 설치되어 있습니다. 우리가 지금 사용하고 있는 운영체제는 64bit로 gcc패키지와 g++패키지 또한 64bit로 되어있습니다. 그래서 32bit로 된 gcc패키지와 g++패키지가 필요합니다. 이때 크로스 컴파일링을 위한 gcc-multilib패키지와 g++-multilib, 크로스 컴파일을 위한 패키지 등을 설치해야 합니다.

**필수 패키지 종류**
	1. binutils : 여러 종류의 오브젝트 파일들을 핸들링하기 위한 바이너리들입니다. 주로 make패키지, gcc패키지, gdb 패키지 등과 함께 사용됩니다.
	2. bison : Parser의 일종으로, LALR(Lock-Ahead LR)로 이루어진 문법을 해석하여 C코드로 작성해줍니다.
	3. flex : lex(구문분석기)의 향상된 버전으로 bison과 함께 구문분석을 위해서 사용합니다. 
	4. gcc-multilib : C의 크로스 컴파일을 위해 설치합니다. 
	5. g++-multilib : C++의 크로스 컴파일을 위해 설치합니다.
	6. libc6-dev : libiconv(인코딩 변환 라이브러리)를 사용하기 위해 설치합니다.
	7. libtool : Portable library를 만들기 위한 도구입니다.
	8. make : 프로그램 그룹 유지를 위한 유틸리티로, 컴파일이 필요한 부분을 읽어서 gcc컴파일로 컴파일한다.
	9. patchutils : 패치 파일을 핸들링하기 위한 유틸리티입니다.
	10. libgmp-dev : GNU MP(GNU Multiple Precision Arithmetic Library) 라이브러리를 사용하기 위해 설치합니다.
	11. libmpfr-dev : GNU MPFR(GNU Multiple Precision Floating-Point Reliably Library) 라이브러리를 사용하기 위해 설치합니다.
	12. libmpc-dev : MPC(Music Player Daemon) 라이브러리를 사용하기 위해 설치합니다.

**패키지 설치 과정**
미리 패키지를 설치했다면, 설치한 패키지는 건너띄고 명령어를 입력합니다.
```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install gcc-multilib
$ sudo apt-get install g++-multilib
$ sudo apt-get install binutils
$ sudo apt-get install bison
$ sudo apt-get install flex
$ sudo apt-get install libc6-dev
$ sudo apt-get install libtool
$ sudo apt-get install make
$ sudo apt-get install patchutils
$ sudo apt-get install libgmp-dev
$ sudo apt-get install libmpfr-dev
```

**크로스 컴파일링 라이브러리가 설치되어 있는지 적용**
[test.c]
```
#include <stdio.h>
int main(int argv, char* argc[]){
	printf("Hello World\n");
	return 0;
}
```
설치한 크로스 컴파일 gcc 컴파일로 test.c 파일을 32비트와 64비트 컴파일합니다.
```
$ gcc -m32 -o test32 test.c
$ gcc -m64 -o test64 test.c
```

[test.cpp]
```
#include <iostream>
int main(int argv, char* argc[]){
	std::cout << "Hello World" << std::endl;
	return 0;
}
```
설치한 크로스 컴파일 gcc 컴파일로 test.c 파일을 32비트와 64비트 컴파일합니다.
```
$ g++ -m32 -o test32 test.c
$ g++ -m64 -o test64 test.c
```

### 2. NASM 설치
NASM(The Netwide Assembler)은 윈도우와 리눅스 등 다양한 플랫폼을 지원하는 우수한 어셈블러입니다. NASM은 32비트와 64비트 환경에서 모두 지원한다. 
**NASM 설치**
```
$ sudo apt-get install nasm
```

### 3. QEMU 설치
QEMU는 오픈 소스 프로세서 에뮬레이터로 다양한 종류의 프로세서를 소프트웨어적으로 구현한 프로그램입니다. QEMU는 하드웨어 가상화의 기능을 갖춘것으로 KVM(keyboard, Video Monitor, Mouse)을 적용할 수 있으며, 리눅스에서 사용하는 가상 머신의 표준이다. 하이퍼바이저에서 채택하고 있다.
```
$ sudo apt-get install qemu-kvm
```

## 부팅과 부트 로더






