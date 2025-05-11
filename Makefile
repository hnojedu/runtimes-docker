TAG ?= latest

.PHONY: all image-tiericpc image-tier1 image-tier2 image-tier3 test-tiericpc test-tier1 test-tier2 test-tier3

all: image-tiericpc image-tier1 image-tier2 image-tier3

image-tiericpc:
	cd tiericpc && docker build -t hnoj/runtimes-tiericpc -t hnoj/runtimes-tiericpc:$(TAG) -t ghcr.io/hnojedu/runtimes-tiericpc:$(TAG) .

image-tier1:
	cd tier1 && docker build -t hnoj/runtimes-tier1 -t hnoj/runtimes-tier1:$(TAG) -t ghcr.io/hnojedu/runtimes-tier1:$(TAG) .

image-tier2: image-tier1
	cd tier2 && docker build -t hnoj/runtimes-tier2 -t hnoj/runtimes-tier2:$(TAG) -t ghcr.io/hnojedu/runtimes-tier2:$(TAG) .

image-tier3: image-tier2
	cd tier3 && docker build -t hnoj/runtimes-tier3 -t hnoj/runtimes-tier3:$(TAG) -t ghcr.io/hnojedu/runtimes-tier3:$(TAG) .

image-tiervnoj: image-tier1
	cd tiervnoj && docker build -t hnoj/runtimes-tiervnoj -t hnoj/runtimes-tiervnoj:$(TAG) -t ghcr.io/hnojedu/runtimes-tiervnoj:$(TAG) .

test: test-tiericpc test-tier1 test-tier2 test-tier3 test-tiervnoj

test-tiericpc:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE hnoj/runtimes-tiericpc

test-tier1:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE hnoj/runtimes-tier1

test-tier2:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE hnoj/runtimes-tier2

test-tier3:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE hnoj/runtimes-tier3

test-tiervnoj:
	docker run --rm -v "`pwd`/test-tier3":/code --cap-add=SYS_PTRACE hnoj/runtimes-tiervnoj
