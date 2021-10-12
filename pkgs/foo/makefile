clean:
	rm -rf build/ dist/ *.egg-info
reqs:
	pipreqs --force .

inst: clean
	pip3 uninstall foo -y
	pip3 install -e . --user
	python3 setup.py sdist bdist_wheel
