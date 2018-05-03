# create simulator , open files
set ns [ new Simulator ]
set nf [ open pdf3.nam w ]
$ns namtrace-all $nf
set tf [ open pdf3.tr w ]
$ns trace-all $tf

# create nodes from n0 to n5
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# create links between those nodes n(0,5)->n4, congestion in n4
$ns duplex-link $n0 $n4 1005Mb 1ms DropTail
$ns duplex-link $n1 $n4 50Mb 1ms DropTail
$ns duplex-link $n2 $n4 2000Mb 1ms DropTail
$ns duplex-link $n3 $n4 200Mb 1ms DropTail
$ns duplex-link $n5 $n4 1Mb 1ms DropTail

# add ping agents(p0-p5) to all nodes except n4
# p0 and p2 are source ,so give packetSize_ & interval_
set p0 [new Agent/Ping] 
# letters A and P should be capital
$ns attach-agent $n0 $p0
$p0 set packetSize_ 50000
$p0 set interval_ 0.0001

set p1 [new Agent/Ping]
# letters A and P should be capital
$ns attach-agent $n1 $p1

set p2 [new Agent/Ping] 
# letters A and P should be capital
$ns attach-agent $n2 $p2
$p2 set packetSize_ 30000
$p2 set interval_ 0.00001

set p3 [new Agent/Ping]
# letters A and P should be capital
$ns attach-agent $n3 $p3

set p5 [new Agent/Ping]
# letters A and P should be capital
$ns attach-agent $n5 $p5

# queue limit for nodes except n1
$ns queue-limit $n0 $n4 5
$ns queue-limit $n2 $n4 3
$ns queue-limit $n4 $n5 2

#Define a 'recv' function for the class 'Agent/Ping'
Agent/Ping instproc recv {from rtt} {
    $self instvar node_
    puts "node [$node_ id] received answer from $from with round trip time $rtt msec"
}
#please provide space between $node_ and id. No space between $ and from. No space between and $ and rtt

$ns connect $p0 $p5
$ns connect $p2 $p3

proc finish { } {
global ns nf tf
$ns flush-trace
close $nf
close $tf
#exec nam lab4.nam &
exit 0
}

$ns at 0.1 "$p0 send"
$ns at 0.2 "$p0 send"
$ns at 0.3 "$p0 send"
$ns at 0.4 "$p0 send"
$ns at 0.5 "$p0 send"
$ns at 0.6 "$p0 send"
$ns at 0.7 "$p0 send"
$ns at 0.8 "$p0 send"
$ns at 0.9 "$p0 send"
$ns at 1.0 "$p0 send"
$ns at 1.1 "$p0 send"
$ns at 1.2 "$p0 send"
$ns at 1.3 "$p0 send"
$ns at 1.4 "$p0 send"
$ns at 1.5 "$p0 send"
$ns at 1.6 "$p0 send"
$ns at 1.7 "$p0 send"
$ns at 1.8 "$p0 send"
$ns at 1.9 "$p0 send"
$ns at 2.0 "$p0 send"
$ns at 2.1 "$p0 send"
$ns at 2.2 "$p0 send"
$ns at 2.3 "$p0 send"
$ns at 2.4 "$p0 send"
$ns at 2.5 "$p0 send"
$ns at 2.6 "$p0 send"
$ns at 2.7 "$p0 send"
$ns at 2.8 "$p0 send"
$ns at 2.9 "$p0 send"
$ns at 0.1 "$p2 send"
$ns at 0.2 "$p2 send"
$ns at 0.3 "$p2 send"
$ns at 0.4 "$p2 send"
$ns at 0.5 "$p2 send"
$ns at 0.6 "$p2 send"
$ns at 0.7 "$p2 send"
$ns at 0.8 "$p2 send"
$ns at 0.9 "$p2 send"
$ns at 1.0 "$p2 send"
$ns at 1.1 "$p2 send"
$ns at 1.2 "$p2 send"
$ns at 1.3 "$p2 send"
$ns at 1.4 "$p2 send"
$ns at 1.5 "$p2 send"
$ns at 1.6 "$p2 send"
$ns at 1.7 "$p2 send"
$ns at 1.8 "$p2 send"
$ns at 1.9 "$p2 send"
$ns at 2.0 "$p2 send"
$ns at 2.1 "$p2 send"
$ns at 2.2 "$p2 send"
$ns at 2.3 "$p2 send"
$ns at 2.4 "$p2 send"
$ns at 2.5 "$p2 send"
$ns at 2.6 "$p2 send"
$ns at 2.7 "$p2 send"
$ns at 2.8 "$p2 send"
$ns at 2.9 "$p2 send"
$ns at 3.0 "finish"
$ns run
