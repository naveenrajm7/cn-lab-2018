 # create new Simulator
set ns [new Simulator]
 # open a nam trace file in write mode
set namfile1 [open prog1.nam w]
# to channel where traces will go
$ns namtrace-all $namfile1
 # open a trace file in write mode
set tracefile1 [open prog1.tr w]
# all traces goes to file pointed by $tracefile1
$ns trace-all $tracefile1

# to flush all traces files
proc finish {} {
    global ns namfile1 tracefile1
    $ns flush-trace
    close $namfile1
    close $tracefile1
    # exec nam prog1.nam &
    exit 0
}

# create 3 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# establish links & queue limit
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns queue-limit $n0 $n1 10

# attaching transport layer protocol
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

# attaching application layer protocol
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

# creating sink(destination) node
set sink [new Agent/Null]
$ns attach-agent $n2 $sink

# finally makes udp connection btw source and destination
$ns connect $udp0 $sink

# when to start simulation
$ns at 0.2 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run
