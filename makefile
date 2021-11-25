.ONESHELL:

.DEFAULT: all

clean:
	rm -rf build/ dist/ requirements.txt __pycache__/ *.spec
	for f in ../pkgs/*; do
		cd $$f && $(MAKE) clean
		cd ..
	done
setup:
	pip3 install pipreqs
	pip3 install pyinstaller
	sudo apt-get install doxygen
	# To create github pages open github
	# Go to setting and enable github pages
	# Set directory to the directory containing index.html
	# (In this case /docs after running make docs)
reqs:
	pipreqs --print --force
build:
	pyinstaller ../top/*.py --onefile
.PHONY: pkgs
pkgs:
	for f in ../pkgs/*; do
		cd $$f && $(MAKE) all
		cd ..
	done
.PHONY: docs
docs:
	doxygen doxyfile

install:
	if [ -d dist ]
	then
		cp dist/* /usr/local/bin
	else
		echo No binary to install!
		echo Run make all first
	fi

uninstall:
	if [ /usr/local/bin]
		rm -rf
	else
		echo Already uninstalled!
	fi

all: clean reqs docs pkgs build
