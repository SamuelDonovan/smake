.ONESHELL:

clean:
	rm -rf build/ dist/ requirements.txt __pycache__/ *.spec
setup:
	pip3 install pipreqs
	pip3 install pyinstaller
reqs:
	pipreqs --print --force
build:
	pyinstaller main.py --onefile
.PHONY: pkgs
pkgs:
	for f in pkgs/*; do
		cd $$f && $(MAKE) inst
	done
