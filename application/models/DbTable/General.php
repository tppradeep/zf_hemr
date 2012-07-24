<?php
/*
 * 	  	@copyright Copyright (C) 2012  ZH Healthcare LCC
 * 	  	Programmer : Pradeep.T.P
 * 		Date of Coding : 20-July-2012
 * 
 * 		INFORMATION
 * 
 * 		following functions are general functions and using all over the project as per its requirements.
 * 		Deleting a function may cause Error or malfunctioning in the project.
 */
class Application_Model_DbTable_General extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function countrylist()// return all Code and Name of Country from country table
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('country'),array('Code','Name'))
		->order('Name');
		return $db->fetchAll($select);
	}
	/*
	 * resize function using for image resizing. 
	 * have to pass image full phyaical path, required width and height to resize
	 */
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
	public function emptycartjunk() // Removing the junk entries of cart. this is for non completing invoices. 
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	     
	    $row = $db->query("CALL empty_cart_junk()"); // Its a procedure call
	}
	public function userdetails($hf_id) // Retrive User name and email based on hf_id
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
	public function SpecialityList() // to list speciality name from db (for drop box etc)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ="select sp_name from speciality where status=1 order by listing_order asc";
	    return $db->fetchAll($sql);
	}
	public function listprice($idplan) 
	{
	    /*
	     * This function return the price of a plan. the listprice is a procedure.
	     * Please check database to get the defenition
	     */
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='call listprice('.$idplan.')';
	    return $db->fetchOne($sql);
	}
	public function statelist($countrycode) // retriving state list based on country.
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select State_name from state where Country_Code="'.$countrycode.'"';
	    return $db->fetchAll($sql);
	}
	public function emailtemplate($template_sec)// selecting the required email template to send email
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select Subject,content from email_template where template_sec="'.$template_sec.'"';
	    return $db->fetchRow($sql);
	}
	public function ProductDetails($pid) // function to retrive product details
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = "select product_feature from products where idproducts=".$pid;
	    return $db->fetchRow($sql);
	}
	public function emailchecking($eid) // checking the entered email is existing or not
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
	public function identifierchecking($identifier) // function checking the to find duplicate indentifier. Short name is the related field in the registration section
	{
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select count(hf_id) as hf_id from hosted_facilities where hf_facility_identifier="'.$identifier.'"';
	    if($db->fetchone($sql)==0)
	    {
    		//return 1;
    		
	        // Checking in patient portal
	        $gndb=new Application_Model_DbTable_General();

	        $userid = 'hostedopenemrinstaller';
	        $randomvalue = $gndb->generatepassword();
	        $password = sha1('hostedopenemrinstaller@123'.gmdate("Y-m-d H").$randomvalue);
	         
	        $credentials = array($userid,$password,$randomvalue);
	         
	        Zend_Loader::loadClass('Zend_Soap_Client');
	         
	        // initialize SOAP client
	        $options = array(
	        		'location' => 'https://www.mydocsportal.com/myservices/soap_service/server_side.php',
	        		'uri'      => 'urn://portal/res'
	        );
	         
	      		
	        	
	        	$validarr = array($credentials,$identifier);
	       
	        	$client = new Zend_Soap_Client(null, $options);
	        	$result = $client->check_existing($validarr);

	       
        	if($result=='absent')
        	{
        		return 1;
        		exit;
        	}
        	if($result==false)
        	{
        		return 0;
        		exit;
        	}	
	        if($result=='present')
	        {
	        	return 0;
	        	exit;
	        }
	        
	    }
	    else
	    {
	       
	    	return 1;
	    	exit;
	    }
	}
	/*
	 * retrive facility identifier by passing user id
	 */
	public function facilityidentifier($userid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
   
	    $sql ='select hf_facility_identifier from hosted_facilities where hf_id='.$userid;
	    return $db->fetchOne($sql);
	}
	/*
	 * retrive facility email by passing id (hf_id) field
	 */
	public function facilityemail($hfid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select hf_email from hosted_facilities where hf_id='.$hfid;
	    return $db->fetchOne($sql);
	}
	/*
	 * retrive full identifier details by passing id
	 */
	public function identifierdetails($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql ='select hf_facility_suffix,hf_facility_name,hf_facility_lname,hf_email,hf_address,hf_state,hf_city,hf_zip,hf_country,reg_date from hosted_facilities where hf_id='.$hf_id;
	    return $db->fetchRow($sql);
	}
	/*
	 * This function is used to add indication message to user section. for example
	 * if we send email, this detail requried to list in the message section of user dashboard.
	 * so, once send the email, the details has to update to this section. for this the following function is using
	 * passing facility id, message subject and content of message as parameters.
	 */
	public function messageadd($hf_id,$subject,$message)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $ddate = date('Y-m-d');
	    $sql = 'insert into messages (hf_id,pk_id,Subject,message,status,date)values('.$hf_id.',0,"'.$subject.'","'.$message.'",1,"'.$ddate.'")';
	    $db->query($sql);
	    
	}
	
	/*
	 * This function return the facility details by passing the email (user id)
	 */
	public function userdeatils_email($hfemail)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		 
		$sql ='select hf_id,hf_facility_suffix,hf_facility_name,hf_facility_lname,hf_address,hf_state,hf_city,hf_zip,hf_country,reg_date from hosted_facilities where hf_email="'.$hfemail.'"';
		return $db->fetchRow($sql);
	}
	/*
	 * return all products related emr details to view
	 */
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
	
	/*
	 * Generating unique password which is not generated earlier.
	 */
	public function generatepassword()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $i=0;
	    do
	    {
	        $randkey = substr(md5(rand().rand()), 0, 8);
	        $sql = 'select count(autonumber) as id from autonumber where autonumber="'.$randkey.'"';
	        $i=$db->fetchOne($sql);
	         
	    }while($i>0);
		return $randkey;
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
	public function addotherspeciality($hf_speciality)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select max(listing_order)as lval from speciality';
	    $lval = $db->fetchOne($sql) + 1 ;
	    $sql ='insert into speciality (sp_name,listing_order,status) values ("'.$hf_speciality.'",'.$lval.',0)';
	    $db->query($sql);
	}
	public function activedbserver()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select db_name from db_server where status=1';
	    return $db->fetchOne($sql);
	}
	public function activebackupdbserver()
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$sql ='select db_name from backup_db_server where status=1';
		return $db->fetchOne($sql);
	}
}

