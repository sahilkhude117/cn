# Step 1: Create simulator instance
set ns [new Simulator]

# Step 2: Open trace files for text and NAM
set tracefile [open out.tr w]
set namfile [open out.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

# Step 3: Create 3 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# Step 4: Create duplex links with bandwidth, delay, and queue type
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail

# Step 5: Limit queue size on link
$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 10

# Step 6: Setup UDP and Null agents
set udp [new Agent/UDP]
set null [new Agent/Null]
$ns attach-agent $n0 $udp
$ns attach-agent $n2 $null
$ns connect $udp $null

# Step 7: Create CBR traffic and attach to UDP
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.05
$cbr attach-agent $udp

# Step 8: Schedule simulation events
$ns at 1.0 "$cbr start"
$ns at 4.0 "$cbr stop"
$ns at 5.0 "finish"

# Step 9: Define finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Step 10: Run the simulation
$ns run
