# create simulator ,open nam, trace file for write and connect it to simulator
set ns [new Simulator]
set nf [open prog3.nam w]
$ns namtrace-all $nf
set tf [open prog3.tr w]
$ns trace-all $tf

# to clear up files after running 
proc finish {} {
    global ns nf tf 
    $ns flush-trace
    close $nf
    close $tf
    exit 0
}

# create  6 nodes n0 to n5
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#Connect the nodes with five links 
$ns duplex-link $n1 $n0 0.2Mb 10ms DropTail
$ns duplex-link $n2 $n0 0.5Mb 10ms DropTail
$ns duplex-link $n3 $n0 1Mb 10ms DropTail
$ns duplex-link $n4 $n0 10Kb 10ms DropTail
$ns duplex-link $n5 $n0 1Mb 10ms DropTail

#Define a 'recv' function for the class 'Agent/Ping'
Agent/Ping instproc recv {from rtt} {
	$self instvar node_
	puts "node [$node_ id] received ping answer from \
              $from with round-trip-time $rtt ms."
}

#Create two ping agents and attach them 
set p1 [new Agent/Ping]
set p2 [new Agent/Ping]
set p3 [new Agent/Ping]
set p4 [new Agent/Ping]
set p5 [new Agent/Ping]

$ns attach-agent $n1 $p1
$ns attach-agent $n2 $p2
$ns attach-agent $n3 $p3
$ns attach-agent $n4 $p4
$ns attach-agent $n5 $p5

# queue limit
$ns queue-limit $n0 $n4 3
$ns queue-limit $n0 $n5 2

#Connect the two agents
$ns connect $p1 $p4
$ns connect $p2 $p5

#Schedule events
$ns at 0.2 "$p1 send"
$ns at 0.4 "$p1 send"
$ns at 0.6 "$p1 send"
$ns at 0.8 "$p1 send"
$ns at 1.0 "$p1 send"
$ns at 0.2 "$p2 send"
$ns at 0.4 "$p2 send"
$ns at 0.6 "$p2 send"
$ns at 0.8 "$p2 send"
$ns at 1.0 "$p2 send"
$ns at 1.2 "$p5 send"

$ns at 2.0 "finish"	

#Run the simulation
$ns run
