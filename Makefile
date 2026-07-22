all: opencode pi

.PHONY: opencode
opencode:
	docker build . -f ./opencode/Dockerfile -t hbmo-opencode

.PHONY: pi
pi:
	docker build . -f ./pi/Dockerfile -t hbmo-pi --no-cache
