<?php

class User_Model_DbTable_Profile extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function retriveuserdetails()
	{
		$sess = new Zend_Session_Namespace('user');
		$userid=$sess->duser;
		
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('hosted_facilities'),array('hf_facility_name','hf_speciality','hf_email','hf_phone','hf_address','hf_fax','hf_city','hf_zip','hf_state','hf_tax_id','hf_country','hf_npi'))
		->where('hf_email="'.$userid.'"');
		return $db->fetchRow($select);
	}
	
	public function updateuser($hf_facility_name,$hf_speciality,$hf_address,$hf_city,$hf_state,$hf_zip,$hf_country,$hf_phone,$hf_fax,$hf_tax_id,$hf_npi)
	{
		$sess = new Zend_Session_Namespace('user');
		$hf_id=$sess->hf_id;
		
		$db = Zend_Db_Table::getDefaultAdapter();
		$data = array(
				'hf_facility_name' => $hf_facility_name,
				'hf_speciality' => $hf_speciality,
				'hf_address' => $hf_address,
				'hf_city' => $hf_city,
				'hf_state' => $hf_state,
				'hf_zip' => $hf_zip,
				'hf_country' => $hf_country,
				'hf_phone' => $hf_phone,
				'hf_fax' => $hf_fax,
				'hf_tax_id' => $hf_tax_id,
				'hf_npi' => $hf_npi
		
		);
		$db->update('hosted_facilities', $data,'hf_id = '.$hf_id);
		return "y";
	}
}

