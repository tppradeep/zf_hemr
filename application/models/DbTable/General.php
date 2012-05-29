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

}

