import sys


my_file = open(sys.argv[2]+"-tput-time-graph.txt", "w");
if len(sys.argv) != 3:
	print "Usage: python %s [trace-file] [packet-size]" % (sys.argv[0])
	sys.exit()

trace_file = open(sys.argv[1], 'r')
trace = trace_file.readlines()
trace_file.close()

pkt_size = int(sys.argv[2])

pkt_count = 0
start_time = 99.0
end_time = -1

time_vals = []
tput_vals = []

for line in trace:
	line_data = line.split(' ')
	
	event = line_data[0]
	time = float(line_data[1])

	if (event=='s'):
		if (time < start_time): start_time = time

	if (event=='r'):
		pkt_count += 1
		if (time > end_time): end_time = time

		time_vals.append(time)
		tput = ((pkt_count*pkt_size*8)/(time-start_time))/1000.0
		tput_vals.append(tput)
		my_file.write(str(time)+" "+str(tput)+"\n")
transmission_time = end_time - start_time
avg_tput = ((pkt_count*pkt_size*8)/transmission_time)/1000.0
print avg_tput, start_time, end_time
