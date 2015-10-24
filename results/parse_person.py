import os, sys, argparse

parser = argparse.ArgumentParser()
parser.add_argument("filedir", help="directory to scan for CSV files", type=str)
parser.add_argument("--outfile", help="output CSV file", default="output.csv")
parser.add_argument("--sep", help="separator in CSV file", default=";")
parser.add_argument("--nopts", help="replace point in numbers to comma", action="store_true", default=False)
args = parser.parse_args()

outfilename = args.filedir + "/" + args.outfile
print "sep=",args.sep
try:
	# remove output file if exists
	os.unlink(outfilename)
except:
	pass

names = []
data = []
k = 0

for fname in os.listdir(args.filedir):
	fname = args.filedir + "/" + fname
	if not fname.endswith(".csv"): 
		continue
	
	print
	print ">>>>>> opening:",fname
			
	for i,line in enumerate(file(fname)): # average all file data
		if i == 0: continue # skip separator line
		
		print "parsing:",line.strip()
		mas = line.split(args.sep)
		
		if k == 0: # init data line
			data.append([])
			names.append(mas[0])
		
		mas = mas[1:-1] # -1 to remove average and 1 to remove name
		
		print "\t",
		for j, m in enumerate(mas): # convert all numbers to floats
			num = float(m.replace(",","."));
				
			if k==0: # first file being parsed initializes all data
				print "*",num,
				data[i-1].append(num)
			else:
				# not first file - sum the numbers (averaged in the end)
				data[i-1][j] += num
				print "+",num,"=",data[i-1][j],
		print
	
	k += 1 # one more file parsed
		
print k,"files processed!"
print "saving to:", outfilename

fp = open(outfilename, "w")
fp.write("sep="+args.sep+"\n")
fp.write("Classifier;T1;T2;T3;T4;T5;T6;T7;T8;T9\n")
for i,line in enumerate(data):
	fp.write(names[i]+args.sep)
	for num in line:
		avrg = str(num/k)
		if args.nopts:
			avrg = avrg.replace(".",",")
		fp.write(avrg+args.sep)
	fp.write("\n")
fp.close()

print "complete!"