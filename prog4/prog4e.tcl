# create simulator ,open file
set ns [new Simulator]
set tf [open prog4.tr w]
$ns trace-all $tf
set nf [open prog4.nam w]
$ns namtrace-all $nf

# create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

# create a lan of n0 n1 n2 n3 -> n4 n5 n6 n7
$ns make-lan "$n0 $n1 $n2 $n3" 100Mb 300ms LL Queue/DropTail Mac/802_3
$ns make-lan "$n4 $n5 $n6 $n7" 100Mb 300ms LL Queue/DropTail Mac/802_3
# attach two lans with duplex link
$ns duplex-link $n3 $n4 100Mb 300ms DropTail

# set error rate. Here ErrorModel is a class and it is single word and space should not be
# given between Error and Model
# lossmodel is a command and it is single word. Space should not be given between loss and
# model
set err [new ErrorModel]
$ns lossmodel $err $n3 $n4
$err set rate_ 0.1
# error rate should be changed for each output like 0.1,0.3,0.5.... */

# protocol, application, sink
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set fid_ 0
$cbr set packetSize_ 1000
$cbr set interval_ 0.0001

set null [new Agent/Null]
$ns attach-agent $n7 $null

$ns connect $udp $null

proc finish { } {
global ns nf tf
$ns flush-trace
close $nf
close $tf
#exec nam lab5.nam &
exit 0
}

$ns at 0.1 "$cbr start"
$ns at 3.0 "finish"
$ns run

