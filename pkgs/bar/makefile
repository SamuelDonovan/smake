clean:
	rm -rf build/ dist/ *.egg-info __pycache__/
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
reqs:
	pipreqs --print --force

inst: clean
	pip3 uninstall bar -y
	pip3 install -e . --user
	python3 setup.py sdist bdist_wheel

all: inst
