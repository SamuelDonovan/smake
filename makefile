setup:
	pip3 install pipreqs
	pip3 install pyinstaller
reqs:
	pipreqs --force .
build:
	pyinstaller 
