<?php

class Admin_Model_DbTable_Cms extends Zend_Db_Table_Abstract
{

    protected $_name = 'cms';
	
    public function listcms()
    {
        $customerId = new Zend_Session_Namespace('customerId');
        $cust_id=$customerId->customerId;
        $db = Zend_Db_Table::getDefaultAdapter();
        $sql ='select cms_id,cms_sec,cms_title,cms_details,status from cms where customer_id='.$cust_id;
        return $db->fetchAll($sql);
    }
    public function viewcms($cms_id)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $sql = 'select cms_id,cms_sec,cms_title,cms_details,status from cms where cms_id='.$cms_id;
        return $db->fetchRow($sql);
    }
    public function updatecms($formData)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        
        $cms_id = addslashes($formData['cms_id']);
        $cms_title = addslashes($formData['cms_title']);
        $cms_details = addslashes($formData['cms_details']);
        $status = addslashes($formData['status']);
        
        $sql ='update cms set cms_title="'.$cms_title.'",cms_details="'.$cms_details.'",status="'.$status.'" where cms_id='.$cms_id.'';
        
        $db->query($sql);
    }

}

