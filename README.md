# Description
### email:
    Usage: email [options...]
    Log in specified email and send massage from it to specified address.
     -f, --from   	Email to send from
     -t, --to       Email to send to
     -p, --pass 	Password for sender's email
     -s, --subject  Subject of the email
     -b, --body  	Body of the email
     -h, --help   	Get help message

### process:
    Usage: process [options...]
    Displays information about first 10 processes and kills the process with specified PID.
     -k, --kill  PID 	terminates the process with corresponding PID
     -h, --help 		show brief description of the command

### countfiles:
    Usage: countfiles [source] [destination] [extensions]
    Count files with specified extensions into spesified output file
    ARGUMENTS
        source        directory for file counting
     	destination   result output directory and file name
     	extensions    file extensions to count
    EXAMPLES
     	countfiles c:/users/user1/desktop/ c:/users/user1/desktop/res.txt png txt pdf
     	countfiles . ./result.txt pdf txt bat sh

### dict:
    Usage: dict [word] [options...]
    Displays a couple of definitions for a given word in english divided by # sign.
     -h, --help 	Get help message
     
### stats:
    stats [/h] [/d]
    Output information about the current network connection to a file.
    1. Network adapter information
    2. Physical address information of the network card
    3. DHCP, DNS availability
    4. Default Gateway, %host% availability
    5. Network adapter speed
    6. Traceroute
    7. Traceroute and search for underperforming routers on the way to the %host%
    8. Address Resolution Protocol table
    9. Current connections
    10. Maximum Transmission Unit - Refers to the maximum packet size that can be transmitted over the network without fragmentation
 	ARGUMENTS
	    /h 		Remote host name to process.
        /d 		The path to the report file for information to be saved to.
        /help 	Print this help message.
	EXAMPLE
	   stats microsoft.com ./stats.txt
