import re
import sys

assert len(sys.argv) == 2, "Provide LLVM assembly file!"
filepath = sys.argv[1]

with open(filepath, 'r') as f:
	for line in f:
		if (line.startswith("attributes")):
			continue
		if (line.startswith("!")):
			continue

		line = re.sub('#.+ ', '', line)
		line = re.sub('#.+\n', '\n', line)
		line = re.sub('!.+ ', '', line)
		line = re.sub(', !.+\n', '\n', line)

		sys.stdout.write(line)
