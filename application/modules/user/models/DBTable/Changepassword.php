<?php

class User_Model_DbTable_Changepassword extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function changepassword($c_pwd,$n_pwd,$cn_pwd)
	{
		$c_pwd = sha1($c_pwd);
		$n_pwd = sha1($n_pwd);
		$db = Zend_Db_Table::getDefaultAdapter();
		
		$sess = new Zend_Session_Namespace('user');
    	$userid=$sess->duser;
    			
				
		$select = $db->select()
		->from(array('h'=>'hosted_facilities'),array("hf_email"=>"COUNT(h.hf_email)"))
		->where('h.hf_email="'.$userid.'"')
		->where('h.dashboard_password="'.$c_pwd.'"');
		$row = $db->fetchOne($select);
		if($row==1) // Updating new password
		{
			$data = array('dashboard_password' =>$n_pwd
			);
			$db->update('hosted_facilities', $data,'hf_email = "'.$userid.'" and dashboard_password="'.$c_pwd.'"');
			return "y";
		}
		else
		{
			return "n";
		}
		
	}
}

