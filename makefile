clean:
	rm -rf build/ dist/ *.spec __pycache__/
setup:
	pip3 install pipreqs
	pip3 install pyinstaller
reqs:
	pipreqs --force .
build:
	pyinstaller main.py --onefile
