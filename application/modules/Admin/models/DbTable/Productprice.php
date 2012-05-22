<?php

class Admin_Model_DbTable_Productprice extends Zend_Db_Table_Abstract
{

    protected $_name = 'product_price';

	public function productprice($idproducts)
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	     
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('product_price'),array('idproduct_feature','idproducts','user_from','user_to','cost','sortorder','status','added_date'))
		    ->where('idproducts='.$idproducts)
	    ->order('sortorder');
	     
	    $row = $db->fetchAll($select);
	     
	  
	    if (!$row)
	    {
	    	//throw new Exception("Could not find row");
	    }
	     
	    return $row;
	}
	
	public function productname($idproducts)
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('products'),array('product_name'))
	    ->where('customer_id='.$customerId->customerId)
	    ->where('idproducts='.$idproducts);
	    
	    $row = $db->fetchOne($select);
	    
	    if (!$row)
	    {
	    	//throw new Exception("Could not find row");
	    }
	    
	    return $row;
	}
	public function addProductprice($idproducts,$user_from,$user_to,$cost,$sortorder,$status,$added_date)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $data = array(
	    		'idproducts'=>$idproducts,
	    		'user_from' => $user_from,
	            'user_to' => $user_to,
	    		'cost' => $cost,
	    		'sortorder'=>$sortorder,
	    		'status'=>$status,
	    		'added_date'=>date('Y-m-d')
	    );
	    $numRows = $db->insert('product_price', $data);
	    return $db->lastInsertId();
	}
	public function retriveproductprice($idproduct_feature)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('product_price'),array('idproduct_feature','idproducts','user_from','user_to','cost','sortorder','status'))
	    ->where('idproduct_feature='.$idproduct_feature);
	     
	   return $row = $db->fetchRow($select);
	}
	public function updateProductprice($idproduct_feature,$idproducts,$user_from,$user_to,$cost,$sortorder,$status)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	     
	    $data = array(
	    		'user_from' => $user_from,
	    		'user_to' => $user_to,
	    		'cost' => $cost,
	    		'sortorder'=>$sortorder,
	    		'status'=>$status
	    );

	    $this->update($data,'idproduct_feature='.$idproduct_feature);
	}
	public function deleteproductprice($id)
	{
	    $this->delete('idproduct_feature='.$id);
	}
}	


