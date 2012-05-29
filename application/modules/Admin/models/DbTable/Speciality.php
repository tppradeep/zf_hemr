<?php

class Admin_Model_DbTable_Speciality extends Zend_Db_Table_Abstract
{

    protected $_name = 'speciality';

	public function listspeciality()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select id,sp_name,listing_order,status from speciality order by listing_order asc';
	    return $db->fetchAll($sql);
	}
	public function specialitydtd($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select id,sp_name,listing_order,status from speciality where id='.$id;
	    return $db->fetchRow($sql);
	}
	public function updatespeciality($formData)
	{
	    echo "<pre>";
	    print_r($formData);
	    
	    $sp_name = addslashes($formData['sp_name']);
	    $listing_order = $formData['listing_order'];
	    $st=$formData['sp_status'];
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='update speciality set sp_name="'.$sp_name.'",listing_order='.$listing_order.',status='.$st.' where id='.$formData['id'];
	    $db->query($sql);
	}
}

