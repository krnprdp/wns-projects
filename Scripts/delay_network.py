

import sys
my_file = open("delay-time-graph.txt", "w");

if len(sys.argv) != 2:
	print "Usage: python %s [trace-file]" % (sys.argv[0])
	sys.exit()


trace_file = open(sys.argv[1], 'r')
trace = trace_file.readlines()
trace_file.close()

send = {}
recv = {}

time_vals = []
delay_vals = []

for line in trace:
	line_data = line.split(' ')
	
	event = line_data[0]
	time = float(line_data[1])
	packet_id = line_data[6]
	
	if (event=='s'):
		send[packet_id] = time

	if (event=='r'):
		recv[packet_id] = time

		time_vals.append(time)
		delays = [recv[pkt] - send[pkt] for pkt in recv.keys()]
		delay_vals.append(sum(delays)/len(delays))
		my_file.write(str(time)+" "+str(sum(delays)/len(delays))+"\n")
delays = [recv[pkt] - send[pkt] for pkt in recv.keys()]
avg_delay = sum(delays)/len(delays)
print avg_delay
