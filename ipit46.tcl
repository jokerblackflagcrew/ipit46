proc error {} {
    puts "Usage: ipit46 -4 <IPv4> <minusIP> <plusIP>"
    puts "       ipit46 -6 <IPv6> <minusIP> <plusIP>"
    puts "Example: ipit46 -4 192.168.0.1 -10 +10"
    puts "         ipit46 -6 2001:db8::1 -10 +10"
    puts "For more info: ipit46 --help"
    exit 1
}

proc help {} {
    puts "\n"
    puts "  █████████████████████████████████████████████████"
    puts "  ██                                             ██"
    puts "  ██  ██ ████████ ██ ████████ ██    ██ ████████  ██"
    puts "  ██  ██ ██    ██ ██    ██    ██    ██ ██        ██"
    puts "  ██  ██ ████████ ██    ██    ████████ ████████  ██"
    puts "  ██  ██ ██       ██    ██          ██ ██    ██  ██"
    puts "  ██  ██ ██       ██    ██          ██ ████████  ██"
    puts "  ██                                             ██"
    puts "  █████████████████████████████████████████████████"
    puts "\n"
    puts "  I P  I T E R A T O R  4 6   (ipit46)"
    puts "  Developed by: joker (joker@blackflagcrew.net)"
    puts "  A simple tool to iterate through IPv4 and IPv6 ranges."
    puts "\n"
    puts "  Usage:"
    puts "  ipit46 -4 <IPv4> <minusIP> <plusIP>"
    puts "  ipit46 -6 <IPv6> <minusIP> <plusIP>"
    puts "\n"
    puts "  Example for IPv4:"
    puts "  ipit46 -4 192.168.0.1 -10 +10"
    puts "\n"
    puts "  Examples for IPv6:"
    puts "  ipit46 -6 2001:db8::1 -10 +10"
    puts "  ipit46 -6 2a02:8109:250d:a00:8aae:ddff:fe10:3e10 -10 +10"
    puts "\n"
    exit 0
}


proc init {} {
    global argv
    if {[llength $argv] == 1 && [lindex $argv 0] eq "--help"} { help }
    if {[llength $argv] < 4} { error }

    set option [lindex $argv 0]
    set ip [lindex $argv 1]
    set minusIP [expr {[lindex $argv 2] + 0}]
    set plusIP [expr {[lindex $argv 3] + 1}]

    if {$option eq "-4"} {
        processIPv4 $ip $minusIP $plusIP
    } elseif {$option eq "-6"} {
        processIPv6 $ip $minusIP $plusIP
    } else {
        error
    }
}

proc processIPv4 {ip minusIP plusIP} {
    set start_ip [get_start_ipv4 $ip $minusIP]

    set start_num [ipv4_to_int $start_ip]
    set end_num [expr {[ipv4_to_int $ip] + $plusIP - 1}]

    for {set num $start_num} {$num <= $end_num} {incr num} {
        puts [int_to_ipv4 $num]
    }
}

proc get_start_ipv4 {ip minusIP} {
    set ip_num [ipv4_to_int $ip]
    return [int_to_ipv4 [expr {$ip_num + $minusIP}]]
}

proc ipv4_to_int {ip} {
    set octets [split $ip .]
    return [expr {[lindex $octets 0] * 256**3 + [lindex $octets 1] * 256**2 + [lindex $octets 2] * 256 + [lindex $octets 3]}]
}

proc int_to_ipv4 {num} {
    return [format "%d.%d.%d.%d" \
        [expr {($num >> 24) & 255}] \
        [expr {($num >> 16) & 255}] \
        [expr {($num >> 8) & 255}] \
        [expr {$num & 255}]
    ]
}

proc processIPv6 {ip minusIP plusIP} {
    set start_ip [get_start_ipv6 $ip $minusIP]

    set start_num [ipv6_to_int $start_ip]
    set end_num [expr {[ipv6_to_int $ip] + $plusIP - 1}]

    for {set num $start_num} {$num <= $end_num} {incr num} {
        puts [int_to_ipv6 $num]
    }
}

proc get_start_ipv6 {ip minusIP} {
    set ip_num [ipv6_to_int $ip]
    return [int_to_ipv6 [expr {$ip_num + $minusIP}]]
}

proc ipv6_to_int {ip} {
    set expanded_ip [expand_ipv6 $ip]
    set groups [split $expanded_ip :]
    set int_val 0

    foreach group $groups {
        set hex_value [scan $group %x]
        set int_val [expr {($int_val << 16) + $hex_value}]
    }

    return $int_val
}

proc int_to_ipv6 {num} {
    set groups {}

    for {set i 0} {$i < 8} {incr i} {
        set groups [linsert $groups 0 [format "%x" [expr {($num >> (16 * $i)) & 0xFFFF}]]]
    }

    return [compress_ipv6 [join $groups ":"]]
}

proc expand_ipv6 {ip} {
    set parts [split $ip :]
    set expanded {}

    foreach part $parts {
        if {$part eq ""} {
            set zeros [lrepeat [expr {9 - [llength $parts]}] "0000"]
            set expanded [concat $expanded $zeros]
        } else {
            set expanded [concat $expanded [format "%04x" 0x$part]]
        }
    }

    return [join $expanded ":"]
}

proc compress_ipv6 {ip} {
    set ip [regsub -all {(^|:)0+([0-9a-fA-F]+)} $ip {\1\2}]
    set ip [regsub -all {(:0)+:} $ip "::"]
    return $ip
}

init
