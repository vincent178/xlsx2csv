ARCH_ARM=arm64
ARCH_X86=amd64
NAME=xlsx2csv

clean:
	rm -f $(NAME)-$(ARCH_ARM) $(NAME)-$(ARCH_X86) $(NAME)

arm64: 
	GOOS=darwin GOARCH=$(ARCH_ARM) go build -o $(NAME)-$(ARCH_ARM)

amd64:
	GOOS=darwin GOARCH=$(ARCH_X86) go build -o $(NAME)-$(ARCH_X86)

universal: arm64 amd64
	lipo -create $(NAME)-$(ARCH_ARM) $(NAME)-$(ARCH_X86) -o $(NAME)

all: clean universal

