<?php

class Admin_Model_DbTable_Bkpdbserver extends Zend_Db_Table_Abstract
{

    protected $_name = 'backup_db_server';

    public function listserver()
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$sql = 'select id,db_name,status from backup_db_server order by db_name asc';
    	return $db->fetchAll($sql);
    }
    public function adddbserver($formData)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$sql = 'insert into backup_db_server(db_name,status)values("'.$formData['db_name'].'",'.$formData['status'].')';
    	$db->query($sql);
    	 
    }
    public function viewdb($id)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$sql ='select id,db_name,status from backup_db_server where id='.$id;
    	return $db->fetchRow($sql);
    }
    public function editserver($formdata)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	echo  $sql ='update backup_db_server set db_name="'.$formdata['db_name'].'",status='.$formdata['status'].' where id='.$formdata['id'];
    	//die;
    	$db->query($sql);
    }
    public function deleteserver($id)
    {
    	$this->delete('id='.$id);
    }
}

