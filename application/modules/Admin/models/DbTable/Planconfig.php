<?php

class Admin_Model_DbTable_Planconfig extends Zend_Db_Table_Abstract
{

   // protected $_name = 'hosted_site_content';
    public function hp_plan_name($id) //retriving plan name passing hp_id as encoded value
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('h' => 'hosted_plans'),array('h.hp_name'))
    	->where('h.hp_id='.$id);
    	$row = $db->fetchOne($select);
    	
    	if (!$row)
    	{
    		throw new Exception("Could not find row");
    	}
    	return $row;
    }
    public function products()
    {
    	$customerId = new Zend_Session_Namespace('customerId');
    	 
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('products'),array('idproducts','product_name','product_sort_order','product_status','cost','payment_term','added_date'))
    	->where('customer_id='.$customerId->customerId)
    	->where('product_status=1')
    	->where('ProductType in (1,3)')
    	->order('product_sort_order');
    	 
    	$row = $db->fetchAll($select);
    	 
    	if (!$row)
    	{
    		//throw new Exception("Could not find row");
    	}
    	return $row;
    }
    public function AddProduct($formData,$id)
    {
        /*
         * Adding selected products into the plan
         */
      
        $db = Zend_Db_Table::getDefaultAdapter();
        $db->delete('plan_products','idplan='.$id); // Deleting Existing and Adding new feature
      //  die;
        foreach($formData as $pid)
        {
            $select = $db->select()
            ->from(array('plan_products'),array('count(idplanproducts)'))
            ->where('idproducts='.$pid)
            ->where('idplan='.$id);
             
            $row = $db->fetchOne($select);
            if($row==0)
            {
				 $data = array(
	                'idplan'=>$id,
	                'idproducts'=>$pid,
	        	    'added_date'=>date('Y-m-d')
	       			 );
	        	$numRows = $db->insert('plan_products', $data);
	
	        	// Compulsory Product (Subproduct adding)
	        	
	        	$select = $db->select()
	        	->from(array('sub_product_list'),array('sub_idproducts'))
	        	->where('idproducts='.$pid);
	        	$SubProductId = $db->fetchAll($select);
	        	foreach($SubProductId as $SPI)
	        	{
	        	    
	        	    $select = $db->select()
	        	    ->from(array('plan_products'),array('count(idplanproducts)'))
	        	    ->where('idproducts='.$SPI['sub_idproducts'])
	        	    ->where('idplan='.$id);
	        	    
	        	    $row = $db->fetchOne($select);
	        	    if($row==0)
	        	    {
		        	    $data = array(
		        	    		'idplan'=>$id,
		        	    		'idproducts'=>addslashes($SPI['sub_idproducts']),
		        	    		'added_date'=>date('Y-m-d')
		        	    );
		        	    $numRows = $db->insert('plan_products', $data);
	        	    }
	        	}
            }
        }
        
        // Recalculating the Plan Cost and Updating the plan cost
        $select = $db->select()
        ->from(array('hosted_plans'),array('bundle_discount_type','bundle_discount_per_cost','bundle_discount_per_setup'))
        ->where('hp_id='.$id);
        $row = $db->fetchRow($select);
        $bundle_discount_type = $row['bundle_discount_type'];
        $bundle_discount_per_cost = $row['bundle_discount_per_cost'];
        $bundle_discount_per_setup = $row['bundle_discount_per_setup'];
        
        //select sum(cost),sum(setup_fee) from products,plan_products where idplan=17 and products.idproducts=plan_products.idproducts
        $select = $db->select()
        -> from(array('p'=>'products'),array('sum(p.cost) as pcost','sum(p.setup_fee) as setupcost'))
        ->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
        -> where('pp.idplan='.$id);
        
        $PlanCost = $db->fetchRow($select);
        if($bundle_discount_type==0)// no discount
        {
            $setupcost = $PlanCost['setupcost'];
            $productcost = $PlanCost['pcost'];
        }
        if($bundle_discount_type==1)// % discount
        {
            $setupcost = $PlanCost['setupcost'] - (($PlanCost['setupcost']*$bundle_discount_per_setup)/100);
            $productcost = $PlanCost['pcost'] - (($PlanCost['pcost']*$bundle_discount_per_cost)/100);
        }
        if($bundle_discount_type==2)// Flat Discount 
        {
        	$setupcost = $PlanCost['setupcost'] - $bundle_discount_per_setup;
        	$productcost = $PlanCost['pcost'] - $bundle_discount_per_cost;
        }
        
        $data = array('bundle_cost' =>$productcost,
        		'bundle_setup_cost' => $setupcost
        );
        $db->update('hosted_plans', $data,'hp_id = '.$id); // Updating plan cost
        
    }
    public function AddedProducts($id)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $select = $db->select()
        ->from(array('plan_products'),array('idproducts'))
        ->where('idplan='.$id);
        
        $row = $db->fetchAll($select);
        if (!$row)
        {
        	//throw new Exception("Could not find row");
        }
        return $row;
    }
}

