#!/bin/sh
help(){
echo "Usage: email [options...]
Log in specified email and send massage from it to specified address.

 -f, --from   	Email to send from
 -t, --to       Email to send to
 -p, --pass 	Password for sender's email
 -s, --subject  Subject of the email
 -b, --body  	Body of the email
 -h, --help   	Get help message"
}

#default values
from='email.from@gmail.com'
to='email.to@gmail.com'
pass='12345678'
subject='test'
body='test'

#arguments handling
while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
	    -f|--from)
	    from="$2"
	    shift 2
	    ;;
	    -t|--to)
	    to="$2"
	    shift 2
	    ;;
	    -p|--pass)
	    pass="$2"
	    shift 2
	    ;;
	    -s|--subject)
	    subject="$2"
	    shift 2
	    ;;
	    -b|--body)
	    body="$2"
	    shift 2
	    ;;
	    -h|--help)
	    help
	    exit
	    ;;
	    *)
		echo Invalid argument $1
		echo Try \'email --help\' for more information.
		exit
		;;
	esac
done

python -c "
import smtplib
with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
	try:
		smtp.login('$from', '$pass')
		smtp.sendmail('$from', '$to', 'Subject: $subject\n\n$body')
		print('send successfully', 'from $from to $to', sep='\n')
	except Exception as ex:
		print(ex)
"