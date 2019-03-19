#!/usr/bin/expect

set VERIFICATION_CODE [lindex $argv 0]

spawn ssh tiger

expect {
    -timeout 300
    "Verification code" { send "$VERIFICATION_CODE\r\n"; exp_continue ; }
    "*wangyajun*" {
        send "clear\r";
    }
    timeout { puts "Expect was timeout."; return }
}
interact
