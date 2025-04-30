# Accept input from the user
puts -nonewline "Enter a number: "
flush stdout
gets stdin num

# Convert to integer (safety)
set num [expr int($num)]

# Initialize factorial
set fact 1

# Loop from 1 to num
for {set i 1} {$i <= $num} {incr i} {
    set fact [expr $fact * $i]
}

# Print the result
puts "Factorial of $num is $fact"








 
#!usr/bin/tclsh 
puts "Enter a number : " 
set num [gets stdin] 
set f 1 
for {set i $num} {$i > 0} {incr i -1} { 
set f [expr {$f * $i}] 
} 
puts "The factorial of $num is $f” 
