
import sys

import bisect


my_file = open("tput-graph.txt", "w");

if len(sys.argv) != 3:
	print "Usage: python %s [trace-file] [packet-size]" % (sys.argv[0])
	sys.exit()

flows = [
#(1,8)
#(8,9),
(17,10),
#(10,11),
#(11,12),
# (5,12),
# (14,21),
# (13,14),
# (9,16)
]

flow_x = []
flow_y = []

for flow in flows:

	trace_file = open(sys.argv[1], 'r')
	trace = trace_file.readlines()
	trace_file.close()

	src_node = '_'+str(flow[0]-1)+'_'
	dst_node = '_'+str(flow[1]-1)+'_'
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
		node_id = line_data[2]
		packet_id = line_data[6]

		if ((event=='s') and (node_id==src_node)):
			if (time < start_time): start_time = time
			sent_packet = packet_id

		if ((event=='r') and (node_id==dst_node) and (packet_id==sent_packet)):
			pkt_count += 1
			if (time > end_time): end_time = time
			
			time_vals.append(time)
			tput = ((pkt_count*pkt_size*8)/(time-start_time))/1000.0
			tput_vals.append(tput)
			my_file.write(str(tput)+" "+str(time)+"\n")
	transmission_time = end_time - start_time
	avg_tput = ((pkt_count*pkt_size*8)/transmission_time)/1000.0
	print flow, avg_tput, start_time, end_time

	flow_x.append(time_vals)
	flow_y.append(tput_vals)

#plt.rc('font', family='serif')
#plt.rc('xtick.major', size=5, pad=7)
#plt.rc('ytick.major', size=5, pad=7)
#plt.rc('ytick', labelsize=45)
#plt.rc('xtick', labelsize=45)

sym = ['r+', 'g*', 'bs', 'yx', 'ko', 'c+', 'm*', 'rs', 'gx']
plts = []
labels = []
#for index in range(len(flows)):
#	plts.append(plt.scatter(flow_x[index], flow_y[index], marker=sym[index][1], s=100, c=sym[index][0]))
#	labels.append(str(flows[index]))

#plt.legend(tuple(plts),
#           tuple(labels),
#           scatterpoints=1,
#           ncol=3,
#           fontsize=25)

#plt.xlim([0,60])
#plt.ylim([0,120])
#plt.xlabel('Simulation Time', weight='bold', size=45)
#plt.ylabel('Throughput (Kbps)', weight='bold', size=45)
#plt.subplots_adjust(left=0.12, right=0.96, top=0.95, bottom=0.17)
#plt.show()
