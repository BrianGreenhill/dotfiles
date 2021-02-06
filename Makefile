UNAME_S := $(shell uname -s)
.PHONY: mac
mac:
ifeq ($(UNAME_S),Darwin)
	@echo "Provisioning macos configuration (sorry for your loss)..."
	@./macos/bootstrap.sh
else
	@echo "This isn't a mac. Try make linux"
endif

.PHONY: linux
linux:
ifeq ($(UNAME_S),Linux)
	@echo "Provisioning linux system..."
	@./linux/install
else
	@echo "This isn't linux. Try make mac"
endif
