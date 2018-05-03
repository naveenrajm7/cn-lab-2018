# create simulator ,open nam, trace file for write and connect it to simulator
set ns [new Simulator]
set nf [open prog2.nam w]
$ns namtrace-all $nf
set tf [open prog2.tr w]
$ns trace-all $tf

# to clear up files after running 
proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exit 0
}

# create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# connections
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

# now protocol , application and route
# n0-n3 TCP
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n3 $tcpsink
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns connect $tcp0 $tcpsink

# n1-n3 UDP
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set udpsink [new Agent/Null]
$ns attach-agent $n3 $udpsink
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

$ns connect $udp1 $udpsink

$ns at 4.5 "$cbr1 start"
$ns at 0.2 "$ftp0 start"
$ns at 5.0 "finish"

$ns run

