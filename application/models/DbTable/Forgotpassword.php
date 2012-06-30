<?php

class Application_Model_DbTable_Forgotpassword extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';
	
    public function generatepassword($pass_len = 8, $pass_num = true, $pass_alpha = true, $pass_mc = true, $pass_exclude = '')
    {
    	// Create the salt used to generate the password
    	$salt = '';
    	if ($pass_alpha) { // a-z
    		$salt .= 'abcdefghijklmnopqrstuvwxyz';
    		if ($pass_mc) { // A-Z
    			$salt .= strtoupper($salt);
    		}
    	}
    
    	if ($pass_num) { // 0-9
    		$salt .= '0123456789';
    	}
    
    	// Remove any excluded chars from salt
    	if ($pass_exclude) {
    		$exclude = array_unique(preg_split('//', $pass_exclude));
    		$salt = str_replace($exclude, '', $salt);
    	}
    	$salt_len = strlen($salt);
    
    	// Seed the random number generator with today's seed & password's unique settings for extra randomness
    	mt_srand ((int) date('y')*date('z')*($salt_len+$pass_len));
    
    	// Generate today's random password
    	$pass = '';
    	for ($i=0; $i<$pass_len; $i++) {
    		$pass .= substr($salt, mt_rand() % $salt_len, 1);
    	}
    
    	return $pass;
    }
    
	public function sendtemppassword($email)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select count(hf_id) as hf_id from hosted_facilities where hf_email= "'.$email.'"';
	   
	    
	    if($db->fetchOne($sql)==1)
	    {
	        
	        // Configure Password
	        
	        // Passwords length
	        $pass_len = 8;
	        // Use numbers?
	        $pass_num = true;
	        // Use letters? (e.g. abcde)
	        $pass_alpha = true;
	        // Use mixed case? (e.g. AbcaBc)
	        $pass_mc = true;
	        // Exclude any chars from password? (e.g. oO0iI1l)
	        $pass_exclude = 'oO0iI1l';
	        
	        // Generate password
	        $pass = $this->generatepassword($pass_len, $pass_num, $pass_alpha, $pass_mc, $pass_exclude);
	        $ddate = date('Y-m-d');
	        $sql='update hosted_facilities set temp_password="'.$pass.'",temp_password_date="'.$ddate.'" where hf_email="'.$email.'"';
	        
	        $db->query($sql);
	        
	        return $pass;
	    }
	    else
	    {
	        return "0";
	    }
	}
	
	
}

