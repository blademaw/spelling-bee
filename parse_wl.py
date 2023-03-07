#!/usr/bin/env python3

import sys, os

def out_wl(filename):
    with open(filename, 'r') as f:
        contents = f.read().split()
    
    # TODO: add word normalization -- strip accents & punctuation. 
    contents = [word for word in contents if len(word) >= 4]
    with open('out.txt', 'w+') as f_o:
        f_o.write("\n".join(contents))
    return 0

if __name__ == "__main__":
    if sys.argv[1] is not None and os.path.exists(sys.argv[1]):
        out_wl(sys.argv[1])
    else:
        raise ValueError("No/missing file provided to function.")

