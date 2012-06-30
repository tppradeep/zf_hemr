<?php /* CLASSES $Id: libmail.class.php 6035 2010-10-02 03:34:00Z ajdonnison $ */
/**
 *  @package dotproject
 *  @subpackage utilites
 */

if (!defined('DP_BASE_DIR')) {
	die('You should not access this file directly.');
}

/**
 *  This class encapsulates the PHP mail() function.
 *  
 *  implements CC, Bcc, Priority headers
 *  @version 1.3
 *  <ul>
 *  <li>added ReplyTo($address) method
 *  <li>added Receipt() method - to add a mail receipt
 *  <li>added optionnal charset parameter to Body() method. this should fix charset problem on some mail clients
 *  </ul>
 *  Example
 *  <code>
 *  include "libmail.php";
 *  
 *  $m= new Mail; // create the mail
 *  $m->From("leo@isp.com");
 *  $m->To("destination@somewhere.fr");
 *  $m->Subject("the subject of the mail");
 *  
 *  $message= "Hello world!\nthis is a test of the Mail class\nplease ignore\nThanks.";
 *  $m->Body($message); // set the body
 *  $m->Cc("someone@somewhere.fr");
 *  $m->Bcc("someoneelse@somewhere.fr");
 *  $m->Priority(4) ; // set the priority to Low
 *  $m->Attach("/home/leo/toto.gif", "image/gif") ; // attach a file of type image/gif
 *  $m->Send(); // send the mail
 *  echo "the mail below has been sent:<br><pre>", $m->Get(), "</pre>";
 *  </code>
  
  LASTMOD
  Fri Aug 03 17:03:25 UTC 2007
  
 *  @author Leo West - lwest@free.fr
 *  @author Emiliano Gabrielli - emiliano.gabrielli@dearchitettura.com
 */
class Mail
{
	/**
	 *  list of To addresses
	 *  @var array
	 */
	var $ato = array();
	/**
	 *  @var array
	 */
	var $acc = array();
	/**
	 *  @var array
	 */
	var $abcc = array();
	/**
	 *  paths of attached files
	 *  @var array
	 */
	var $aattach = array();
	/**
	 *  list of message headers
	 *  @var array
	 */
	var $xheaders = array();
	/**
	 *  string version of message headers in the form
	 *  "HeaderName: header content\r\n"
	 *  @var string
	 */
	var $headers = '';
	/**
	 *  message priorities referential
	 *  @var array
	 */
	var $priorities = array('1 (Highest)', '2 (High)', '3 (Normal)', '4 (Low)', '5 (Lowest)');
	/**
	 *  character set of message
	 *  @var string
	 */
	var $charset;
	var $ctencoding;
	var $receipt = 0;
	
	var $useRawAddress = TRUE;
	
	var $host;
	var $port;
	var $sasl;
	var $tls;
	var $username;
	var $password;
	var $transport;
	var $defer;
	var $response;
	var $err = false;
	var $last_error = false;

/**
 *  Mail constructor
 */
function Mail() {
	$this->autoCheck(TRUE);
	$this->boundary = '--' . md5(uniqid('dPboundary'));
	// Grab the current mail handling options
	$this->transport = dPgetConfig('mail_transport', 'php');
	$this->host = dPgetConfig('mail_host', 'localhost');
	$this->port = dPgetConfig('mail_port', '25');
	$this->sasl = dPgetConfig('mail_auth', FALSE);
	$this->tls = dPgetConfig('mail_smtp_tls', FALSE);
	$this->username = dPgetConfig('mail_user');
	$this->password = dPgetConfig('mail_pass');
	$this->defer = dPgetConfig('mail_defer');
	$this->timeout = dPgetConfig('mail_timeout', 0);
	$this->charset = ((isset($GLOBALS['locale_char_set'])) 
	                  ? mb_strtolower($GLOBALS['locale_char_set']) : 'us-ascii');
	$this->ctencoding = $this->charset != 'us-ascii' ? '8bit' : '7bit';
	$this->canEncode = 'us-ascii' != $this->charset;
	$this->hasMbStr = function_exists('mb_substr');
}


/**
 *  activate or desactivate the email addresses validator
 *  
 *  ex: autoCheck(TRUE) turn the validator on
 *  by default autoCheck feature is on
 *  
 *  @param boolean $bool set to TRUE to turn on the auto validation
 *  @access public
 */
function autoCheck($bool) {
	$this->checkAddress = (bool) $bool;
}


/**
 *  Define the subject line of the email
 *  @param string $subject any monoline string
 *  @param string $charset encoding to be used for Quoted-Printable encoding of the subject 
 */
function Subject($subject, $charset='') {
	global $AppUI;
	if (!empty($charset)) {
		$this->charset = mb_strtolower($charset);
	}
	
	$subject = dPgetConfig('email_prefix').' '.$subject;
	$subject = strtr($subject, "\x0B\0\t\r\n\f" , '      ');
	$subject = $this->_wordEncode($subject, mb_strlen('Subject: '));
	
	$this->xheaders['Subject'] = $subject;
}


/**
 *  set the sender of the mail
 *  @param string $from should be an email address
 */
function From($from) {
	if (!is_string($from)) {
		return FALSE;
	}
	$from = strtr($from, "\x0B\0\t\r\n\f" , '      ');
	$this->xheaders['From'] = $this->_addressEncode($from, mb_strlen('From: '));
}

/**
 *  set the Reply-to header
 *  @param string $email should be an email address
 */
function ReplyTo($address) {
	if (!is_string($address)) {
		return FALSE;
	}
	$address = strtr($address, "\x0B\0\t\r\n\f" , '      ');
	$this->xheaders['Reply-To'] = $this->_addressEncode($address, mb_strlen('Reply-To: '));
}

/**
 *  add a receipt to the mail ie.  a confirmation is returned to the "From" address 
 *  (or "ReplyTo" if defined) when the receiver opens the message.
 *  @warning this functionality is *not* a standard, thus only some mail clients are compliants.
 */
function Receipt() {
	$this->receipt = 1;
}

/**
 *  set the mail recipient
 *  
 *  The optional reset parameter is useful when looping through records to send individual mails.
 *  This prevents the 'to' array being continually stacked with additional addresses.
 *  
 *  @param string $to email address, accept both a single address or an array of addresses
 *  @param boolean $reset resets the current array
 */
function To($to, $reset=FALSE) {
	if (is_array($to)) {
		$to = array_map(create_function('$s', 'return strtr($s, "\x0B\0\t\r\n\f", "      ");'), $to);
		$this->ato = $to;
	} else {
		$to = strtr($to, "\x0B\0\t\r\n\f", '      ');
		if ($this->useRawAddress) {
		   if (preg_match("/^(.*)\<(.+)\>$/D", $to, $regs)) {
			  $to = $regs[2];
		   }
		}
		if ($reset) {
			unset($this->ato);
			$this->ato = array();
		}
		$this->ato[] = $to;
	}
	
	if ($this->checkAddress == TRUE) {
		$this->CheckAdresses($this->ato);
	}
}

/**
 *  Cc()
 *  set the CC headers (carbon copy)
 *  $cc : email address(es), accept both array and string
 */
function Cc($cc) {
	if (is_array($cc)) {
		$cc = array_map(create_function('$s', 'return strtr($s, "\x0B\0\t\r\n\f", "      ");'), $cc);
		$this->acc = $cc;
	} else {
		$cc = strtr($cc, "\x0B\0\t\r\n\f", '      ');
		$this->acc = explode(',', $cc);
	}
	
	if ($this->checkAddress == TRUE) {
		$this->CheckAdresses($this->acc);
	}
}

/**
 *  set the Bcc headers (blank carbon copy).
 *  $bcc : email address(es), accept both array and string
 */
function Bcc($bcc) {
	if (is_array($bcc)) {
		$bcc = array_map(create_function('$s', 'return strtr($s, "\x0B\0\t\r\n\f", "      ");'), $bcc);
		$this->abcc = $bcc;
	} else {
		$bcc = strtr($bcc, "\x0B\0\t\r\n\f", '      ');
		$this->abcc = explode(',', $bcc);
	}
	
	if ($this->checkAddress == TRUE) {
		$this->CheckAdresses($this->abcc);
	}
}

/**
 *  set the body (message) of the mail
 *  define the charset if the message contains extended characters (accents)
 *  default to us-ascii
 *  $mail->Body("m?l en fran?ais avec des accents", "iso-8859-1");
 */
function Body($body, $charset='') {
	$this->body = $body;
	
	if (!empty($charset)) {
		$this->charset = mb_strtolower($charset);
		if ($this->charset != 'us-ascii') {
			$this->ctencoding = '8bit';
		}
	}
}

/**
 *  set the Organization header
 */
function Organization($org) {
	if (trim($org) != '') {
		$this->xheaders['Organization'] = $this->_wordEncode($org, mb_strlen('Organization: '));
	}
}

/**
 *  set the mail priority
 *  $priority : integer taken between 1 (highest) and 5 (lowest)
 *  ex: $mail->Priority(1) ; => Highest
 */
function Priority($priority) {
	if (! intval($priority)) {
		return FALSE;
	}
	
	if (! isset($this->priorities[$priority-1])) {
		return FALSE;
	}
	
	$this->xheaders['X-Priority'] = $this->priorities[$priority-1];
	return TRUE;
}

/**
 *  Attach a file to the mail
 *  
 *  @param string $filename : path of the file to attach
 *  @param string $filetype : MIME-type of the file. default to 'application/x-unknown-content-type'
 *  @param string $disposition : instruct the Mailclient to display the file if possible ("inline") 
 *                               or always as a link ("attachment") possible values are "inline", 
 *                               "attachment"
 */
function Attach($filename, $filetype='', $disposition='inline') {
	// TODO : si filetype="", alors chercher dans un tablo de MT connus / extension du fichier
	if (empty($filetype)) {
		$filetype = 'application/x-unknown-content-type';
	}
	$this->aattach[] = $filename;
	$this->actype[] = $filetype;
	$this->adispo[] = $disposition;
}

/**
 *  Build the email message
 *  @access protected
 */
function BuildMail() {
	global $AppUI;
	
	// build the headers
	if (count($this->ato) > 0) {
		$this->_addressesEncode($this->ato, 'To');
	}
	if (count($this->acc) > 0) {
		$this->_addressesEncode($this->acc, 'CC');
	}
	if (count($this->abcc) > 0) {
		$this->_addressesEncode($this->abcc, 'BCC');
	}
	
	if ($this->receipt) {
		if (isset($this->xheaders['Reply-To'])) {
			$this->xheaders['Disposition-Notification-To'] = $this->xheaders['Reply-To'];
		} else {
			$this->xheaders['Disposition-Notification-To'] = $this->xheaders['From'];
		}
	}
	
	if (! empty($this->charset)) {
		$this->xheaders['Mime-Version'] = '1.0';
		$this->xheaders['Content-Type'] = 'text/plain; charset=' . $this->charset;
		$this->xheaders['Content-Transfer-Encoding'] = $this->ctencoding;
	}
	
	$this->xheaders['X-Mailer'] = 'dotProject v' . $AppUI->getVersion();
	$this->headers = '';
	foreach ($this->xheaders as $h=>$v) {
		$this->headers .= $h . ': ' . trim($v) . "\r\n";
	}
	
	// include attached files
	if (count($this->aattach) > 0) {
		$this->_build_attachement();
	} else {
		$sep = "\r\n";
		$arr = preg_split("/(\r?\n)|\r/", $this->body);
		$this->fullBody = implode($sep, $arr);
	}
}

/**
 *  format and send the mail
 *  @access public
*/
function Send() {
	$this->BuildMail();
	
	if ($this->defer) {
		return $this->QueueMail();
	} else if ($this->transport == 'smtp') {
		return $this->SMTPSend();
	} else {
		$headers = '';
		foreach ($this->xheaders as $k => $v) {
			if ($k == 'To' || $k == 'Subject') {
				continue;
			}
			$headers .= $k . ': ' . trim($v) . "\r\n";
		}
		return @mail($this->xheaders['To'], $this->xheaders['Subject'], $this->fullBody, $headers);
	}
}

/**
 *  Send email via an SMTP connection.
 *  
 *  Work based loosly on that of Bugs Genie, which appears to be in turn based on something from 'Ninebirds'
 *  
 *  @access public
 */
function SMTPSend() {
	global $AppUI;
	
	// Start the connection to the server
	$error_number = 0;
	$error_message = '';
	$headers =& $this->xheaders;

	$this->socket = fsockopen($this->host, $this->port, $error_number, $error_message, $this->timeout);
	if (! $this->socket) {
		dprint(__FILE__, __LINE__, 1, ('Error on connecting to host ' . $this->host . ' at port ' 
		                               . $this->port . ': ' . $error_message . ' (' 
									   . $error_number . ')'));
		$AppUI->setMsg('Cannot connect to SMTP Host: ' . $error_message 
		               . ' (' . $error_number . ')');
		return FALSE;
	}
	// Read the opening stuff;
	$this->socketReadPattern(220, 300);
	
	
	// Send the ESMTP protocol "hello"
	$this->socketSend('EHLO ' . $this->getHostName());
	$reply = $this->socketReadPattern(250, 300, 500, 502, 503);
	
	// If ESMTP fails and TLS not needed, try the standard SMTP protocol "hello"
	if ($reply[0] == '5' && !($this->tls)) {
		$this->err = FALSE;
		$this->socketSend('HELO ' . $this->getHostName());
		$this->socketReadPattern(250, 300);
	}
	
	if ($this->err) {
		dprint(__FILE__, __LINE__, 1, 
		       ('Failed to initiate connection to server: ' . implode("\n", $this->response)));
		$AppUI->setMsg('Failed to initiate connection to SMTP server: ' . $this->last_error);
		fclose($this->socket);
		return FALSE;
	}
	
	if ($this->tls) {
		$this->socketSend('STARTTLS');
		$this->socketReadPattern(220);
		if ($this->err) {
			dprint(__FILE__, __LINE__, 1, 
			       ('TLS Initialization failed on server: ' . implode("\n", $this->response)));
			$AppUI->setMsg('Failed to login to SMTP server: ' . $this->last_error);
			fclose($this->socket);
			return FALSE;
		}
		$tries = 0;
		do {
			if ($tries) {
				sleep($tries);
			}
			$tls_connection = stream_socket_enable_crypto($this->socket, $this->tls, 
			                                              STREAM_CRYPTO_METHOD_TLS_CLIENT);
		} while ($tls_connection === 0 && (($tries * ($tries + 1)) / 2) < $this->timeout);
		
		if (! $tls_connection) {
			dprint(__FILE__, __LINE__, 1, 
			       ('TLS Connection failed on server: ' . implode("\n", $this->response)));
			$AppUI->setMsg('Failed to login to SMTP server: ' . $this->last_error);
			fclose($this->socket);
			return FALSE;
		}
	}
	if ($this->sasl && $this->username) {
		$this->socketSend('AUTH LOGIN');
		$this->socketReadPattern(334);
		if (! $this->err) {
			$this->socketSend(base64_encode($this->username));
			$this->socketReadPattern(334);
		}
		if (! $this->err) {
			$this->socketSend(base64_encode($this->password));
			$rcv = $this->socketReadPattern(235);
		}
		if ($this->err) {
			dprint(__FILE__, __LINE__, 1, 
			       ('Authentication failed on server: ' . implode("\n", $this->response)));
			$AppUI->setMsg('Failed to login to SMTP server: ' . $this->last_error);
			fclose($this->socket);
			return FALSE;
		}
	}
	
	// Determine the mail from address.
	if (! isset($headers['From'])) {
		$from = dPgetConfig('admin_user') . '@' . dPgetConfig('site_domain');
	} else {
		// Search for the parts of the email address
		$from = ((preg_match('/.*<([^@]+@[a-z0-9\._-]+)>/i', $headers['From'], $matches)) 
		         ? $matches[1] : $headers['From']);
	}
	$this->socketSend("MAIL FROM: <$from>");
	$rcv = $this->socketReadPattern(250, 300);
	if ($this->err) {
		$AppUI->setMsg('Failed to send email: ' . $this->last_error, UI_MSG_ERROR);
		return FALSE;
	}
	foreach ($this->ato as $to_address) {
		if (mb_strpos($to_address, '<') !== FALSE) {
			preg_match('/^.*<([^@]+\@[a-z0-9\._-]+)>/i', $to_address, $matches);
			if (isset($matches[1]))
				$to_address = $matches[1];
		}
		$this->socketSend("RCPT TO: <$to_address>");
		$rcv = $this->socketReadPattern(array(250,251), 300);
		if ($this->err) {
			$AppUI->setMsg('Failed to send email: ' . $this->last_error, UI_MSG_ERROR);
			return FALSE;
		}
	}
	$this->socketSend('DATA');
	$rcv = $this->socketReadPattern(354, 120);
	if ($this->err) {
		$AppUI->setMsg('Failed to send email: ' . $this->last_error, UI_MSG_ERROR);
		return FALSE;
	}
	foreach ($headers as $hdr => $val) {
			$this->socketSend("$hdr: $val");
	}
	// Now build the To Headers as well.
	$this->socketSend('Date: ' . date('r'));
	$this->socketSend('');
	$this->socketSend($this->fullBody);
	$this->socketSend('.');
	$result = $this->socketReadPattern(250, 600);
	if ($this->err) {
		dprint(__FILE__, __LINE__, 1, ('Failed to send email from ' . $from . ' to ' . $to_address 
									   . ': ' . implode("\n", $this->response)));
		$AppUI->setMsg('Failed to send email: ' . $this->last_error);
		return FALSE;
	}
	
	$this->socketSend('QUIT');
	$this->socketReadPattern(221, 300);
	// Don't error at this stage, but return regardless.
	return true;
}

function socketRead($timeout = null) {
	if ($timeout !== null) {
		stream_set_timeout($this->socket, $timeout);
	}
	$result = fgets($this->socket, 4096);
	dprint(__FILE__, __LINE__, 12, 'server said: ' . $result);
	$info = stream_get_meta_data($this->socket);
	if (!empty($info['timed_out'])) {
	$this->err = true;
		return false;
	}
	if ($result === false) {
		$this->err = true;
	}
	return $result;
}

/**
 *  Using the method used by Zend_Mail to handle the SMTP protocol
 */
function socketReadPattern($pattern, $timeout = null) {
	$this->response = array();
	$this->last_error = '';
	$cmd = '';
	$msg = '';
	
	if (!is_array($pattern)) {
		$pattern = array($pattern);
	}
	do {
		$this->response[] = $result = $this->socketRead($timeout);
		sscanf($result, '%d%s', $cmd, $msg);
		if ($cmd === null || ! in_array($cmd, $pattern)) {
			$this->err = true;
			$this->last_error = $result;
			return false;
		}
	} while (mb_strpos($msg, '-') === 0);
	return $msg;
}

function socketSend($msg, $rcv = FALSE) {
	dprint(__FILE__, __LINE__, 12, 'sending: ' . $msg);
	$this->err = false;
	$sent = fputs($this->socket, $msg . "\r\n");
	return (($rcv) ? $this->socketRead() : $sent);
}

function getHostName() {
	// Grab the server address, return a hostname for it.
	return (($host = gethostbyaddr($_SERVER['SERVER_ADDR'])) ? $host : 'localhost');
}

/**
 *  Queue mail to allow the queue manager to trigger
 *  the email transfer.
 *  
 *  @access private
 */
function QueueMail() {
	global $AppUI;
	
	require_once $AppUI->getSystemClass('event_queue');
	$ec = new EventQueue;
	$vars = get_object_vars($this);
	return $ec->add(array('Mail', 'SendQueuedMail'), $vars, 'libmail', TRUE);
}

/**
 *  Dequeue the email and transfer it. Called from the queue manager.
 *  
 *  @access private
 */
function SendQueuedMail($mod, $type, $originator, $owner, &$args) {
	foreach ($args as $k => $v) {
		// Only set variables we know about.
		if (isset($this->$k) || property_exists($this, $k)) { # See PHP manual.
			$this->$k = $v;
		}
	}
	if ($this->transport == 'smtp') {
		return $this->SMTPSend();
	} else {
		$headers = '';
		foreach ($this->xheaders as $k => $v) {
			if ($k == 'To' || $k == 'Subject') {
				continue;
			}
			$headers .= $k . ': ' . trim($v) . "\r\n";
		}
		return @mail($this->xheaders['To'], $this->xheaders['Subject'], $this->fullBody, $headers);
	}
}

/**
 *  Returns the whole e-mail , headers + message
 *  can be used for displaying the message in plain text or logging it
 *  
 *  @return string
 */
function Get() {
	$this->BuildMail();
	$mail = $this->headers . "\r\n\r\n";
	$mail .= $this->fullBody;
	return $mail;
}

/**
 *  check an email address validity
 *  @access public
 *  @param string $address : email address to check
 *  @return TRUE if email adress is ok
 */
function ValidEmail($address) {
	if (preg_match('/^(.*)\<(.+)\>$/D', $address, $regs)) {
		$address = $regs[2];
	}
	return (bool) preg_match('/^[^@ ]+@([-a-zA-Z0-9..]+)$/D', $address);
}

/**
 *  check validity of email addresses
 *  @param array $aad -
 *  @return if unvalid, output an error message and exit, this may -should- be customized
 */

function CheckAdresses($aad) {
	foreach ($aad as $ad ) {
		if (! $this->ValidEmail($ad)) {
			echo ('Class Mail, method Mail : invalid address ' . $ad);
			exit;
		}
	}
	return TRUE;
}
/**
 *  alias for the mispelled CheckAdresses
 */
function CheckAddresses($aad) {
	return $this->CheckAdresses($aad);
}

/**
 *  check and encode attach file(s) . internal use only
 *  @access private
 */
function _build_attachement() {
	$this->xheaders['Content-Type'] = "multipart/mixed;\r\n boundary=\"" . $this->boundary .'"';

	$this->fullBody = "This is a multi-part message in MIME format.\r\n--".$this->boundary."\r\n";
	$this->fullBody .= ('Content-Type: text/plain; charset=' . $this->charset 
						."\r\nContent-Transfer-Encoding: " . $this->ctencoding . "\r\n\r\n");
	
	$sep= "\r\n";
	$body = preg_split("/\r?\n/", $this->body);
	$this->fullBody .= implode($sep, $body) ."\r\n";
	
	$ata= array();
	$k=0;
	
	// for each attached file, do...
	for ($i=0, $cnt = count($this->aattach); $i < $cnt; $i++) {
		$filename = $this->aattach[$i];
		$basename = basename($filename);
		$ctype = $this->actype[$i]; // content-type
		$disposition = $this->adispo[$i];

		if (! file_exists($filename)) {
			echo "Class Mail, method attach : file $filename can't be found";
			exit;
		}
		$subhdr = ('--' . $this->boundary . "\r\nContent-type: " . $ctype . ";\r\n" 
				   . ' name="' . $basename . '"' . "\r\n" 
				   . "Content-Transfer-Encoding: base64\r\n" 
				   . "Content-Disposition: " . "$disposition" . ";\r\n" 
				   . '  filename="' . "$basename" . '"' . "\r\n");
		$ata[$k++] = $subhdr;
		// non encoded line length
		$linesz= filesize($filename)+1;
		$fp= fopen($filename, 'rb');
		$ata[$k++] = chunk_split(base64_encode(fread($fp, $linesz)));
		fclose($fp);
	}
	$this->fullBody .= implode($sep, $ata);
}

/**
 *  Encode an email address as RFC2047 wants
 *  @author "Emiliano 'AlberT' Gabrielli" <emiliano.gabrielli@dearchitettura.com>
 *  @access private
 *   
 *  @param string $addr: the string to be encoded
 *  @param int $offset: an optional offset to be counted for the first line
 *  @return string the encoded string
 */
function _addressEncode($addr, $offset=0) {
	if (!$this->canEncode) {
		return $addr;
	}
	
	$matches = NULL;
	$mail = '';
	$txt = '';
	if (!@preg_match('/^(.*)(\?<[^@]+@[a-z0-9\._-]+>)$/Di', $addr, $matches)) {
		return $addr;
	}
	
	$txt  = $matches[1];
	$mail = $matches[2];
	$txt = $this->_wordEncode($txt, $offset);
	
	return (($offset + $this->_mb_strlen($txt . $mail) > 76) 
	        ? ($txt . "\r\n " . $mail) : ($txt . $mail));
}

/**
 *  Encode a string making it an encoded word as RFC2047 wants
 *  @author "Emiliano 'AlberT' Gabrielli" <emiliano.gabrielli@dearchitettura.com>
 *  @access private
 *  
 *  @param string $str: the string to be encoded
 *  @param int $offset: an optional offset to be counted for the first line
 *  @return string the encoded string, made of N encoded words, ignore length limits.
 */
function _wordEncode($str, $offset=0) {
	if (!$this->canEncode) {
		return $str;
	}
	
	$cs = $this->charset;
	$qstr = $this->_utfToQuotedPrintable($str, $offset);
	$start_sentinel = "=?$cs?Q?";
	$end_sentinel = "?=";
	return ($start_sentinel . implode($end_sentinel . "\r\n\t" . $start_sentinel, $qstr) 
	        . $end_sentinel);
}

/**
 *  Convert a UTF8 string into a quoted printable string, making sure
 *  that the first line is a known number of characters long and subsequent
 *  lines are <= 72 characters, and that utf8 characters are always encoded
 *  completely on the one line.
 *  
 *  @author Adam Donnison <ajdonnison@dotproject.net>
 *  @param string $str
 *  @param integer $offset
 *  @return array of lines of required length.
 */
function _utfToQuotedPrintable($str, $offset=0) {
	$l = 72 - $offset;
	$result = array();
	$x = 0;
	$s = '';
	for ($i = 0, $len = mb_strlen($str); $i<$len; $i++) {
		$ord = ord($str[$i]);
		if ($ord > 32 && $ord < 127 && $str[$i] != '?' && $str[$i] != '=') {
			$s .= $str[$i];
			$x++;
		} else if (($ord & 0xE0) == 0xC0) {
			$s .= sprintf('=%02x=%02x', $ord, ord($str[++$i]));
			$x+=6;
		} else if (($ord & 0xF0) == 0xE0) {
			$s .= sprintf('=%02x=%02x=%02x', $ord, ord($str[++$i]), ord($str[++$i]));
			$x += 9;
		} else if (($ord & 0xF8) == 0xF0) {
			$s .= sprintf('=%02x=%02x=%02x=%02x', $ord, ord($str[++$i]), ord($str[++$i]), 
			              ord($str[++$i]));
			$x += 12;
		} else if (($ord & 0xFC) == 0xF8) {
			$s .= sprintf('=%02x=%02x=%02x=%02x=%02x', $ord, ord($str[++$i]), ord($str[++$i]), 
			              ord($str[++$i]), ord($str[++$i]));
			$x += 15;
		} else if (($ord & 0xFE) == 0xFC) {
			$s .= sprintf('=%02x=%02x=%02x=%02x=%02x=%02x', $ord, ord($str[++$i]), ord($str[++$i]), 
			              ord($str[++$i]), ord($str[++$i]), ord($str[++$i]));
			$x += 18;
		} else {
			$s .= sprintf('=%02x', $ord);
			$x += 3;
		}
		if ($x >= $l) {
			$result[] = $s;
			$s ='';
			$x = 0;
			$l = 72;
		}
	}
	if ($x) {
		$result[] = $s;
	}
	return $result;
}

function _addressesEncode(&$aaddr, $hdr) {
	$n = count($aaddr);
	$this->xheaders[$hdr] = $this->_addressEncode($aaddr[0], mb_strlen("$hdr: "));
	for ($i=1 /*skip first one*/; $i<$n; ++$i) {
		$val = $this->_addressEncode($aaddr[$i], 8);
		$val = trim($val);
		if ($val) {
			$this->xheaders[$hdr] .= (",\r\n" . $val);
		}
	}
}

function _strpos($str, $start, $offset=0){
	return (($this->hasMbStr) 
	        ? mb_strpos($str, $start, $offset, $this->charset) : strpos($str, $start, $offset));
}

function _substr($str, $start, $len=null) {
	if (NULL===$len) {
		$len = $this->_strlen($str);
	}
	return (($this->hasMbStr) 
	        ? mb_substr($str, $start, $len, $this->charset) : substr($str, $start, $len));
}

function _strlen($str) {
	return (($this->hasMbStr) ? mb_strlen($str, $this->charset) : strlen($str));
}

} // class Mail

?>
