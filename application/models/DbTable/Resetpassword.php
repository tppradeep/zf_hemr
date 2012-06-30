<?php

class Application_Model_DbTable_Resetpassword extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function resetpassword($hf_id,$temppass,$newpass,$confirmnewpass)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql = 'select count(hf_id) as rd from hosted_facilities where hf_id='.$hf_id.' and temp_password="'.$temppass.'"';
	    
	   
	    if($db->fetchOne($sql)==1)
	    {
	        if(sha1($newpass)==sha1($confirmnewpass))
	        {
	            $sql='update hosted_facilities set dashboard_password="'.sha1($newpass).'",temp_password=null,temp_password_date=null where hf_id='.$hf_id;
	            $db->query($sql);
	            return "success";
	        }
	        else
	        {
	            return "passwordnotmatch";
	        }
	    }
	    else
	    {
	        return "tempfail";
	    }
	}
}

