ARCH_ARM=arm64
ARCH_X86=amd64
NAME=xlsx2csv
OS_WINDOWS=windows
OS_MAC=darwin

clean:
	cd build && rm *

mac_arm64: 
	GOOS=$(OS_MAC) GOARCH=$(ARCH_ARM) go build -o build/$(OS_MAC)-$(ARCH_ARM)-$(NAME)

mac_amd64:
	GOOS=$(OS_MAC) GOARCH=$(ARCH_X86) go build -o build/$(OS_MAC)-$(ARCH_X86)-$(NAME)

windows_amd64:
	GOOS=$(OS_WINDOWS) GOARCH=$(ARCH_X86) go build -o build/$(OS_WINDOWS)-$(ARCH_X86)-$(NAME)

mac_universal: mac_arm64 mac_amd64 
	cd build && lipo -create $(OS_MAC)-$(ARCH_ARM)-$(NAME) $(OS_MAC)-$(ARCH_X86)-$(NAME) -o $(OS_MAC)-$(NAME)

all: clean mac_universal windows_amd64

