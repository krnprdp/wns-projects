# Project1a
# This file has been created after referring from the ns2-simulator-presentation, 
# Mark Greis tutorial for ns and
# Examples in tcl/ex/

# Pradeep Kiran C
# Venkat Karthik G
# Bhanu Teja C

set val(chan)           Channel/WirelessChannel    ;# Channel Type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         500                        ;# max packet in ifq
set val(nn)             21                         ;# number of mobilenodes
set val(rp)             AODV                       ;# routing protocol
set val(x)			   	490						   ;# X-dimension
set val(y)				210						   ;# Y-dimension

# Initialize Global Variables
set ns		[new Simulator]


set tracefile     [open project1a_trace.tr w]
$ns trace-all $tracefile

set namtrace [open project1a.nam w]
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

proc stop {} {
    global ns tracefile namtrace
    $ns flush-trace
    close $tracefile
    close $namtrace
}

# set up topography object
set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

# Create God
create-god $val(nn)

# Create channel
set chan_ [new $val(chan)]

# Create node(0) and node(1)

# configure node, please note the change below.
$ns node-config -adhocRouting $val(rp) \
		-llType $val(ll) \
		-macType $val(mac) \
		-ifqType $val(ifq) \
		-ifqLen $val(ifqlen) \
		-antType $val(ant) \
		-propType $val(prop) \
		-phyType $val(netif) \
		-topoInstance $topo \
		-agentTrace ON \
		-routerTrace ON \
		-macTrace ON \
		-movementTrace ON \
		-channel $chan_

#For enabling/disabling RTS/CTS
Mac/802_11 set RTSThreshold_ 4000

for {set i 1} {$i <= $val(nn)} {incr i} {
    set node_($i) [$ns node]
    $node_($i) random-motion 0
    $ns initial_node_pos $node_($i) 20
}

#
# Provide initial co-ordinates for mobilenodes
#

$node_(1) set X_ 70.0
$node_(1) set Y_ 70.0
$node_(1) set Z_ 0.0
$node_(1) color "black"

$node_(2) set X_ 140.0
$node_(2) set Y_ 70.0
$node_(2) set Z_ 0.0
$node_(2) color "black"

$node_(3) set X_ 210.0
$node_(3) set Y_ 70.0
$node_(3) set Z_ 0.0
$node_(3) color "black"

$node_(4) set X_ 280.0
$node_(4) set Y_ 70.0
$node_(4) set Z_ 0.0
$node_(4) color "black"

$node_(5) set X_ 350.0
$node_(5) set Y_ 70.0
$node_(5) set Z_ 0.0
$node_(5) color "black"

$node_(6) set X_ 420.0
$node_(6) set Y_ 70.0
$node_(6) set Z_ 0.0
$node_(6) color "black"

$node_(7) set X_ 490.0
$node_(7) set Y_ 70.0
$node_(7) set Z_ 0.0
$node_(7) color "black"

$node_(8) set X_ 70.0
$node_(8) set Y_ 140.0
$node_(8) set Z_ 0.0
$node_(8) color "black"

$node_(9) set X_ 140.0
$node_(9) set Y_ 140.0
$node_(9) set Z_ 0.0
$node_(9) color "black"

$node_(10) set X_ 210.0
$node_(10) set Y_ 140.0
$node_(10) set Z_ 0.0
$node_(10) color "black"

$node_(11) set X_ 280.0
$node_(11) set Y_ 140.0
$node_(11) set Z_ 0.0
$node_(11) color "black"

$node_(12) set X_ 350.0
$node_(12) set Y_ 140.0
$node_(12) set Z_ 0.0
$node_(12) color "black"

$node_(13) set X_ 420.0
$node_(13) set Y_ 140.0
$node_(13) set Z_ 0.0
$node_(13) color "black"

$node_(14) set X_ 490.0
$node_(14) set Y_ 140.0
$node_(14) set Z_ 0.0
$node_(14) color "black"

$node_(15) set X_ 70.0
$node_(15) set Y_ 210.0
$node_(15) set Z_ 0.0
$node_(15) color "black"

$node_(16) set X_ 140.0
$node_(16) set Y_ 210.0
$node_(16) set Z_ 0.0
$node_(16) color "black"

$node_(17) set X_ 210.0
$node_(17) set Y_ 210.0
$node_(17) set Z_ 0.0
$node_(17) color "black"

$node_(18) set X_ 280.0
$node_(18) set Y_ 210.0
$node_(18) set Z_ 0.0
$node_(18) color "black"

$node_(19) set X_ 350.0
$node_(19) set Y_ 210.0
$node_(19) set Z_ 0.0
$node_(19) color "black"

$node_(20) set X_ 420.0
$node_(20) set Y_ 210.0
$node_(20) set Z_ 0.0
$node_(20) color "black"

$node_(21) set X_ 490.0
$node_(21) set Y_ 210.0
$node_(21) set Z_ 0.0
$node_(21) color "black"

# Pair 1
set udp1 [new Agent/UDP]
$ns attach-agent $node_(1) $udp1
set null1 [new Agent/Null]
$ns attach-agent $node_(3) $null1
$ns connect $udp1 $null1
$udp1 set fid_ 2

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$cbr1 set packet_size_ 200
$cbr1 set rate_ 50Kb
$cbr1 set random_ false

#Pair 2
set udp2 [new Agent/UDP]
$ns attach-agent $node_(2) $udp2
set null2 [new Agent/Null]
$ns attach-agent $node_(16) $null2
$ns connect $udp2 $null2
$udp2 set fid_ 2

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set type_ CBR
$cbr2 set packet_size_ 200
$cbr2 set rate_ 50Kb
$cbr2 set random_ false

#Pair 3
set udp3 [new Agent/UDP]
$ns attach-agent $node_(4) $udp3
set null3 [new Agent/Null]
$ns attach-agent $node_(6) $null3
$ns connect $udp3 $null3
$udp3 set fid_ 2

set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3
$cbr3 set type_ CBR
$cbr3 set packet_size_ 200
$cbr3 set rate_ 50Kb
$cbr3 set random_ false

#Pair 4
set udp4 [new Agent/UDP]
$ns attach-agent $node_(10) $udp4
set null4 [new Agent/Null]
$ns attach-agent $node_(12) $null4
$ns connect $udp4 $null4
$udp4 set fid_ 2

set cbr4 [new Application/Traffic/CBR]
$cbr4 attach-agent $udp4
$cbr4 set type_ CBR
$cbr4 set packet_size_ 200
$cbr4 set rate_ 50Kb
$cbr4 set random_ false

#Pair 5
set udp5 [new Agent/UDP]
$ns attach-agent $node_(7) $udp5
set null5 [new Agent/Null]
$ns attach-agent $node_(21) $null5
$ns connect $udp5 $null5
$udp5 set fid_ 2

set cbr5 [new Application/Traffic/CBR]
$cbr5 attach-agent $udp5
$cbr5 set type_ CBR
$cbr5 set packet_size_ 200
$cbr5 set rate_ 50Kb
$cbr5 set random_ false

#Pair 6
set udp6 [new Agent/UDP]
$ns attach-agent $node_(18) $udp6
set null6 [new Agent/Null]
$ns attach-agent $node_(20) $null6
$ns connect $udp6 $null6
$udp6 set fid_ 2

set cbr6 [new Application/Traffic/CBR]
$cbr6 attach-agent $udp6
$cbr6 set type_ CBR
$cbr6 set packet_size_ 200
$cbr6 set rate_ 50Kb
$cbr6 set random_ false

$ns at 5.0 "$cbr1 start"
$ns at 7.0 "$cbr2 start"
$ns at 5.0 "$cbr3 start"
$ns at 6.0 "$cbr4 start"
$ns at 5.0 "$cbr5 start"
$ns at 1.0 "$cbr6 start"

$ns at 25.0 "$cbr1 stop"
$ns at 15.0 "$cbr2 stop"
$ns at 25.0 "$cbr3 stop"
$ns at 10.0 "$cbr4 stop"
$ns at 25.0 "$cbr5 stop"
$ns at 29.0 "$cbr6 stop"

for {set i 1} {$i <= $val(nn) } {incr i} {
    $ns at 30.0 "$node_($i) reset";
}

$ns at 30.0 "stop"
$ns at 30.01 "puts \"NS EXITING...\" ; $ns halt"

puts "Starting Simulation..."
$ns run
