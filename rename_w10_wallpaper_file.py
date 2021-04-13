import os
from os.path import isfile, join
import argparse


def change_ext(path, extension, count, is_recursive):
	# loop on all items from the path
	for f in os.listdir(path):
		if isfile(join(path, f)):
			ext = f.rsplit('.', 1)
			# no extension
			if len(ext) == 1:
				os.rename(
					join(path, f),
					join(path, '%s.%s' % (f, extension))
				)
				count += 1
		# is directory (isdir)
		elif is_recursive:
			count = change_ext(join(path, f), extension, count, is_recursive)

	return count


def main():
	# get parser
	parser = argparse.ArgumentParser()
	parser.add_argument("-p", "--path", help="Path of the folder to look into", type=str)
	parser.add_argument("-e", "--extension", help="Extension to complete with", type=str, default='jpeg')
	parser.add_argument("-r", "--recursive", help="Check into sub-folders", action="store_true")
	args = parser.parse_args()

	# set up arguments
	path = args.path
	extension = args.extension
	is_recursive = args.recursive

	# loop on path
	count = change_ext(path, extension, 0, is_recursive)

	# result
	print('Add extension ".%s" to %s files in "%s"%s.' % (extension, count, path, ' (recursively)' if is_recursive else ''))


if __name__ == '__main__':
	main()
