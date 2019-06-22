HOST=bitnami@52.29.133.143
ROOT=htdocs
TARGET=$(ROOT)/seal

.PHONY: build

all: clean build 

init:
	npm install

build:
	npm run build

deploy: dist
	ssh $(HOST) mkdir -p $(TARGET)
	scp -r dist/* $(HOST):$(TARGET)

clean:
	rm -fr dist

remote-clean:
	ssh $(HOST) rm -fr $(TARGET) 
