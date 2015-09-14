

import sys

my_file = open("delay-graph.txt", "w");
if len(sys.argv) != 2:
	print "Usage: python %s [trace-file]" % (sys.argv[0])
	sys.exit()

flows = [
#(1,8),
#(8,9),
(17,10),
#(10,11),
#(11,12),
#(5,12),
#(14,21),
#(13,14),
#(9,16)
]

flow_x = []
flow_y = []

for flow in flows:

	trace_file = open(sys.argv[1], 'r')
	trace = trace_file.readlines()
	trace_file.close()

	src_node = '_'+str(flow[0]-1)+'_'
	dst_node = '_'+str(flow[1]-1)+'_'

	send = {}
	recv = {}

	time_vals = []
	delay_vals = []

	for line in trace:
		line_data = line.split(' ')
		
		event = line_data[0]
		time = float(line_data[1])
		node_id = line_data[2]
		packet_id = line_data[6]
		
		if ((event=='s') and (node_id==src_node)):
			send[packet_id] = time
			sent_packet = packet_id

		if ((event=='r') and (node_id==dst_node) and (packet_id==sent_packet)):
			recv[packet_id] = time

			time_vals.append(time)
			delays = [recv[pkt] - send[pkt] for pkt in recv.keys()]
			delay_vals.append(sum(delays)/len(delays))
			my_file.write(str(time)+" "+str(sum(delays)/len(delays))+"\n")
	delays = [recv[pkt] - send[pkt] for pkt in recv.keys()]
	avg_delay = sum(delays)/len(delays)
	print flow, avg_delay

	flow_x.append(time_vals)
	flow_y.append(delay_vals)

# plt.rc('font', family='serif')
# plt.rc('xtick.major', size=5, pad=7)
# plt.rc('ytick.major', size=5, pad=7)
# plt.rc('ytick', labelsize=45)
# plt.rc('xtick', labelsize=45)
# 
# sym = ['r+', 'g*', 'bs', 'yx', 'ko', 'c+', 'm*', 'rs', 'gx']
# plts = []
# labels = []
# for index in range(len(flows)):
# 	plts.append(plt.scatter(flow_x[index], flow_y[index], marker=sym[index][1], s=100, c=sym[index][0]))
# 	labels.append(str(flows[index]))
# 
# plt.legend(tuple(plts),
#            tuple(labels),
#            scatterpoints=1,
#            ncol=3,
#            fontsize=25)
# 
# plt.xlim([0,60])
# plt.ylim([0,0.030])
# plt.xlabel('Simulation Time', weight='bold', size=45)
# plt.ylabel('End-to-end Delay', weight='bold', size=45)
# plt.subplots_adjust(left=0.17, right=0.96, top=0.95, bottom=0.17)
# plt.show()
