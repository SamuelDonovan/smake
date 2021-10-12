.ONESHELL:

clean:
	rm -rf build/ dist/ requirements.txt __pycache__/ *.spec
setup:
	pip3 install pipreqs
	pip3 install pyinstaller
	sudo apt-get install doxygen
reqs:
	pipreqs --print --force
build:
	pyinstaller main.py --onefile
.PHONY: pkgs
pkgs:
	for f in pkgs/*; do
		cd $$f && $(MAKE) all
		cd ../..
	done
.PHONY: docs
docs:
	doxygen doxyfile
all: clean reqs pkgs build
