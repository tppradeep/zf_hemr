<?php

class Admin_Model_DbTable_Products extends Zend_Db_Table_Abstract
{

    protected $_name = 'products';

    public function products()
    {
    	$customerId = new Zend_Session_Namespace('customerId');
    	
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('products'),array('idproducts','product_name','product_sort_order','product_status','cost','setup_fee','payment_term','added_date','ProductType'))
    	->where('customer_id='.$customerId->customerId)
    	->order('product_sort_order');
    	
    	$row = $db->fetchAll($select);
    	
    	if (!$row)
    	{
    		//throw new Exception("Could not find row");
    	}
    	
    	return $row;
    }
    
    public function addProduct($product_name,$customer_id,$product_feature,$cost,$setup_fee,$payment_term,$product_sort_order,$product_status,$ProductType,$provider_cost_nature,$provider_setup_nature)
    {
        $customerId = new Zend_Session_Namespace('customerId');
         
        $db = Zend_Db_Table::getDefaultAdapter();
        
        $data = array(
                'product_name'=>$product_name,
                'customer_id'=>$customerId->customerId,
        		'product_feature' => $product_feature,
        		'cost' => $cost,
                'setup_fee'=>$setup_fee,
        		'payment_term' => $payment_term,
        		'product_sort_order'=>$product_sort_order,
        		'product_status'=>$product_status,
                'added_date'=>date('Y-m-d'),
                'ProductType'=>$ProductType,
                'provider_cost_nature'=>$provider_cost_nature,
                'provider_setup_nature'=>$provider_setup_nature
        );
        $numRows = $db->insert('products', $data);
        return $db->lastInsertId();
    }
    
    public function viewProducts($id)
    {
        $customerId = new Zend_Session_Namespace('customerId');
         
        $db = Zend_Db_Table::getDefaultAdapter();
        $select = $db->select()
        ->from(array('products'),array('idproducts','product_name','product_feature','product_sort_order','product_status','cost','setup_fee','payment_term','added_date','ProductType','provider_cost_nature','provider_setup_nature'))
        ->where('customer_id='.$customerId->customerId)
        ->where('idproducts='.$id);
         
        $row = $db->fetchRow($select);
         
        if (!$row)
        {
        	//throw new Exception("Could not find row");
        }
         
        return $row;
    }
    public function updateProduct($idproducts,$product_name,$customer_id,$product_feature,$cost,$setup_fee,$payment_term,$product_sort_order,$product_status,$ProductType,$provider_cost_nature,$provider_setup_nature)
    {
       $db = Zend_Db_Table::getDefaultAdapter();
        
        $data = array(
                'product_name'=>$product_name,
        		'product_feature' => $product_feature,
        		'cost' => $cost,
                'setup_fee'=>$setup_fee,
        		'payment_term' => $payment_term,
        		'product_sort_order'=>$product_sort_order,
        		'product_status'=>$product_status,
                'ProductType'=>$ProductType,
                'provider_cost_nature'=>$provider_cost_nature,
                'provider_setup_nature'=>$provider_setup_nature
        );
        $this->update($data,'idproducts='.(int)$idproducts);
        
    }
    public function deleteproduct($id)
    {
    	$this->delete('idproducts='.(int)$id);
    }
}

