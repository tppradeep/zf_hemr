<?php

class Application_Model_DbTable_General extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function countrylist()
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('country'),array('Code','Name'))
		->order('Name');
		return $db->fetchAll($select);
	}
	public function resize($image, $width, $height)
	{
		$origWidth = imagesx($image);
		$origHeight = imagesy($image);
	
		$rWidth = ceil($origWidth / $width);
		$rHeight = ceil($origHeight / $height);
	
		if($rWidth > $rHeight) {
			$ratio = $rWidth;
		} else {
			$ratio = $rHeight;
		}
	
		$newWidth = $origWidth / $ratio;
		$newHeight = $origHeight / $ratio;
	
		$resized = imagecreatetruecolor($newWidth, $newHeight);
		imagecopyresampled($resized, $image, 0, 0, 0, 0, $newWidth, $newHeight, $origWidth, $origHeight);
	
		return $resized;
	}
	public function emptycartjunk()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	     
	    $row = $db->query("CALL empty_cart_junk()"); // Its a procedure call
	}
	public function userdetails($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('h'=>'hosted_facilities'),array('h.hf_facility_name','hf_email',))
	    ->where('h.hf_id='.$hf_id);
	    return $row = $db->fetchRow($select);
	}
	public function Resellername($cusid)// Retriving Reseller Name
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = "select Name from reseller_details where id='.$cusid.'";
	    return $db->fetchOne($sql);
	}
	public function SpecialityList()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ="select sp_name from speciality where status=1 order by listing_order asc";
	    return $db->fetchAll($sql);
	}
	public function listprice($idplan)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='call listprice('.$idplan.')';
	    return $db->fetchOne($sql);
	}
	public function statelist($countrycode)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select State_name from state where Country_Code="'.$countrycode.'"';
	    return $db->fetchAll($sql);
	}
	public function emailtemplate($template_sec)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select Subject,content from email_template where template_sec="'.$template_sec.'"';
	    return $db->fetchRow($sql);
	}
	public function ProductDetails($pid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = "select product_feature from products where idproducts=".$pid;
	    return $db->fetchRow($sql);
	}
	public function emailchecking($eid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select count(hf_id) as hf_id from hosted_facilities where hf_email="'.$eid.'"';
	    if($db->fetchone($sql)==0)
	    {
	        // check admin side
	        $sql ='select count(AdminId) as hf_id from admin_details where AdminEmail="'.$eid.'"';
	        if($db->fetchone($sql)==0)
	        {
	        	return 1;
	        }
	        else
	        {
	            return 0;
	        }
	    }
	    else
	    {
	        return 0;
	    }
	}
	public function identifierchecking($identifier)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select count(hf_id) as hf_id from hosted_facilities where hf_facility_identifier="'.$identifier.'"';
	    if($db->fetchone($sql)==0)
	    {
    		return 1;
	    }
	    else
	    {
	    	return 0;
	    }
	}
	public function facilityidentifier($userid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
   
	    $sql ='select hf_facility_identifier from hosted_facilities where hf_id='.$userid;
	    return $db->fetchOne($sql);
	}
	public function facilityemail($hfid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select hf_email from hosted_facilities where hf_id='.$hfid;
	    return $db->fetchOne($sql);
	}
	public function identifierdetails($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql ='select hf_facility_suffix,hf_facility_name,hf_facility_lname,hf_email,hf_address,hf_state,hf_city,hf_zip,hf_country,reg_date from hosted_facilities where hf_id='.$hf_id;
	    return $db->fetchRow($sql);
	}
	
	public function messageadd($hf_id,$subject,$message)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $ddate = date('Y-m-d');
	    $sql = 'insert into messages (hf_id,pk_id,Subject,message,status,date)values('.$hf_id.',0,"'.$subject.'","'.$message.'",1,"'.$ddate.'")';
	    $db->query($sql);
	    
	}
	
	public function userdeatils_email($hfemail)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		 
		$sql ='select hf_id,hf_facility_suffix,hf_facility_name,hf_facility_lname,hf_address,hf_state,hf_city,hf_zip,hf_country,reg_date from hosted_facilities where hf_email="'.$hfemail.'"';
		return $db->fetchRow($sql);
	}
	public function emrfeature()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    	
	    $sql ='select id,module_name,short_tag from emr_modules order by module_name asc';
	    return $db->fetchAll($sql);
	}
	public function dbname($hfemail)// to find out in which server the user database is located
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql ='select db_server from hosted_facilities where hf_email="'.$hfemail.'"';
	    return $db->fetchOne($sql);
	}
	
	public function generatepassword()
	{
		return substr(md5(rand().rand()), 0, 8);
	}
	public function checkautonumer($no)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select count(autonumber) from autonumber where autonumber="'.$no.'"';
	    $nocount = $db->fetchOne($sql);
	    if($nocount==0)
	    {
	        $sql = 'insert into autonumber (autonumber) values ("'.$no.'")';
	        $db->query($sql);
	    }
	    return $nocount;
	}
	public function customer_tranid($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select transaction_id from customer_invoice where hf_id='.$hf_id;
	    return $db->fetchOne($sql);
	}
	public function sendmail($tomail,$toname,$subject,$message)
	{
	    $mailconfig = new Zend_Session_Namespace('mail');
	     
	    $config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' =>  $mailconfig->userid, 'password' => $mailconfig->password);
	    
	    $transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
	    
	    $mail = new Zend_Mail();
	    $mail->setType(Zend_Mime::MULTIPART_RELATED);
	    $mail->setBodyHtml($message);
	    $mail->setFrom($mailconfig->userid, 'ZH Healthcare');
	    $mail->addTo($tomail, $toname);
	    $mail->setSubject($subject);
	     
	    try
	    {
	    	$mail->send($transport);
	    
	    }
	    catch(Zend_Exception $e)
	    {
	    
	    }
	}
}

