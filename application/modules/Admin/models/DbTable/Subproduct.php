<?php

class Admin_Model_DbTable_Subproduct extends Zend_Db_Table_Abstract
{

    protected $_name = 'sub_product_list';

	public function productlist($idproduct)
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    //select * from products where ProductType in (1,3) and product_status='1' and idproducts != 1
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('products'),array('idproducts','product_name'))
	    ->where('customer_id='.$customerId->customerId)
	    ->where('product_status=1')
	    ->where('ProductType in (1,3)')
	    ->where('idproducts !='.$idproduct)
	    ->order('product_sort_order ASC');
	    
	    $row = $db->fetchAll($select);
	    	    
	    return $row;
	    
	}
	public function addsubproducts($products)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $idproduct = $products['idproduct'];
	    $select = $db->delete('sub_product_list','idproducts='.$idproduct);
	    forEach($products as $key => $value) 
	    {
	    	if($key!="idproduct")
	    	{
	    	    $data = array(
	    	    		'idproducts' => $idproduct,
	    	    		'sub_idproducts' => $value
	    	    );
	    	    $numRows = $db->insert('sub_product_list', $data);
	    	}
	    }
	    return $idproduct;
	}
	public function selectedsubproducts($idproducts)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('sub_product_list'),array('sub_idproducts'))
	    ->where('idproducts='.$idproducts);
	     
	    $row = $db->fetchAll($select);
	    
	    return $row;
	}
}

