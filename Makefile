all: opencode

.PHONY: opencode
opencode:
	docker build . -f ./opencode/Dockerfile -t hbmo-opencode
