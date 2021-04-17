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
