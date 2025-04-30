# Create a simulator object
set ns [new Simulator]

# Open trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

# Create nodes
set n0 [$ns node]
set n1 [$ns node]

# Create a duplex link between n0 and n1
$ns duplex-link $n0 $n1 10Mb 10ms DropTail

# Create a UDP agent and attach it to n0
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

# Create a Null agent (acts as sink) and attach to n1
set null [new Agent/Null]
$ns attach-agent $n1 $null

# Connect UDP to Null
$ns connect $udp $null

# Create a CBR traffic source and attach to UDP
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.01
$cbr attach-agent $udp

# Schedule events
$ns at 0.5 "$cbr start"
$ns at 4.5 "$cbr stop"
$ns at 5.0 "finish"

# Finish procedure to close trace and exit
proc finish {} {
    global ns tracefile
    $ns flush-trace
    close $tracefile
    exec nam out.nam &
    exit 0
}

# Run the simulation
$ns run
