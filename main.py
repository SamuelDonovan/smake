#!/usr/bin/env python3

import foo
import bar

##
# @file
#
# @brief Top level python code that calls the lower level packages

##
# @brief Main function called
def main():
	foo.foo.foo()
	bar.bar.bar()

if __name__=="__main__":
	main()
