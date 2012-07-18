<?php

class Admin_Model_DbTable_Plandb extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_plans';
    
	
	public function plans()
	{
		$customerId = new Zend_Session_Namespace('customerId');
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('h' => 'hosted_plans'),array('h.hp_id','h.hp_name','h.hp_caption','h.hp_sortorder','h.hp_status','h.bundle_discount_type','h.bundle_discount_per_cost','h.bundle_discount_per_setup','h.bundle_cost','h.bundle_setup_cost','h.Imagename'))
		->where('h.customer_id='.$customerId->customerId)
		->order('h.hp_sortorder');
		$row = $db->fetchAll($select);
		
		if (!$row)
		{
			throw new Exception("Could not find row");
		}
		return $row;
	}
	
	public function addPlan($hp_name,$hp_caption,$hp_sortorder,$hp_status,$discount,$discount_start_date,$discount_end_date,$Imagename)
	{
		$customerId = new Zend_Session_Namespace('customerId');
		$db = Zend_Db_Table::getDefaultAdapter();
		
		if($discount_start_date!='')
		{
			$fstartdate=explode("/",$discount_start_date);
			$discount_start_date=$fstartdate[2]."/".$fstartdate[0]."/".$fstartdate[1];
			
			$fenddate=explode("/",$discount_end_date);
			$discount_end_date=$fenddate[2]."/".$fenddate[0]."/".$fenddate[1];
		}
		
		$data = array(
				'customer_id'=>$customerId->customerId,
				'hp_name' => addslashes($hp_name),
				'hp_caption' => addslashes($hp_caption),
				'hp_sortorder' => $hp_sortorder,
				'hp_status'=>$hp_status,
				'discount'=>$discount,
				'discount_start_date'=>$discount_start_date,
				'discount_end_date'=>$discount_end_date,
		        'Imagename'=>$Imagename
		
		);
		$numRows = $db->insert('hosted_plans', $data);
		return $db->lastInsertId();
	}
	
	public function RetrivePlanValues($id)// Retriving the selected plan values to list in edit form
	{
		$customerId = new Zend_Session_Namespace('customerId');
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
					->from(array('p'=>'hosted_plans'),array('p.hp_id','p.hp_name','p.hp_caption','p.hp_sortorder','p.hp_status','p.discount','p.discount_start_date','p.discount_end_date','bundle_discount_type','bundle_discount_per_cost','bundle_discount_per_setup','bundle_cost','bundle_setup_cost'))
					->where('p.hp_id='.$id)
					->where('p.customer_id='.$customerId->customerId);
		$row = $db->fetchRow($select);
				
		if(!$row)
		{
			throw new Exception("Count not find row $id");
		}
		return $row;
	}
	
	public function updatePlan($hp_id,$hp_name,$hp_caption,$hp_sortorder,$hp_status,$discount,$discount_start_date,$discount_end_date,$Imagename,$bundle_discount_type,$bundle_discount_per_cost,$bundle_discount_per_setup,$bundle_discount_cost,$bundle_discount_setup) // Updating function for plan
	{
		$customerId = new Zend_Session_Namespace('customerId');
	/*	if($discount_start_date!='')
		{
			
			$fstartdate=explode("/",$discount_start_date);
			$discount_start_date=$fstartdate[2]."/".$fstartdate[0]."/".$fstartdate[1];
			
			$fenddate=explode("/",$discount_end_date);
			$discount_end_date=$fenddate[2]."/".$fenddate[0]."/".$fenddate[1];
		}
		*/
		if($Imagename!="")
		{
			$data = array(
					'customer_id'=>$customerId->customerId,
					'hp_name' => addslashes($hp_name),
					'hp_caption' => addslashes($hp_caption),
					'hp_sortorder' => $hp_sortorder,
					'hp_status' => $hp_status,
			        'bundle_discount_type'=>$bundle_discount_type,
			        'bundle_discount_per_cost'=>round($bundle_discount_per_cost),
			        'bundle_discount_per_setup'=>round($bundle_discount_per_setup),
			        'bundle_cost'=>round($bundle_discount_cost),
			        'bundle_setup_cost'=>round($bundle_discount_setup),
					'discount'=>$discount,
					'discount_start_date'=>$discount_start_date,
					'discount_end_date'=>$discount_end_date,
			        'Imagename'=>$Imagename
			);
		}
		else
		{
		    $data = array(
		    		'customer_id'=>$customerId->customerId,
		    		'hp_name' => addslashes($hp_name),
		    		'hp_caption' => addslashes($hp_caption),
		    		'hp_sortorder' => $hp_sortorder,
		    		'hp_status' => $hp_status,
		    		'bundle_discount_type'=>$bundle_discount_type,
		    		'bundle_discount_per_cost'=>round($bundle_discount_per_cost),
		    		'bundle_discount_per_setup'=>round($bundle_discount_per_setup),
		    		'bundle_cost'=>round($bundle_discount_cost),
		    		'bundle_setup_cost'=>round($bundle_discount_setup),
		    		'discount'=>round($discount),
		    		'discount_start_date'=>$discount_start_date,
		    		'discount_end_date'=>$discount_end_date
		    );
		}
		$this->update($data,'hp_id='.(int)$hp_id);
	}
	public function addPlanImg($pid,$Imagename)
	{
	    $data = array(
	    		'Imagename'=>$Imagename
	    );
	    $this->update($data,'hp_id='.$pid);
	}
	public function deletePlans($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $select = $db->delete('plan_products','idplan='.$id); // plan_products FK table data deleting first
	    
	    $select = $db->select()
	    ->from(array('p'=>'hosted_plans'),array('Imagename'))
	    ->where('p.hp_id='.$id);

	    $Imagename = $db->fetchOne($select);
	    if($Imagename!='')
	    {
	        $imgwithpath = str_replace("application", "public", APPLICATION_PATH).'\\uploads\\plans\\';
	        $fullPathNameFile=$imgwithpath."\\".$Imagename;
	        unlink($fullPathNameFile); // Delete Plan Image
	        
	    }
	    
		$this->delete('hp_id='.(int)$id);
	}
	public function plancost($pid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	  //  die;
	    // select sum(cost) from products,plan_products where  products.idproducts = plan_products.idproducts and plan_products.idplan=1
	   $select = $db->select()
			 -> from(array('p'=>'products'),array('sum(p.cost) as cost','sum(p.setup_fee) as setupfee'))
			 -> join(array('pp'=>'plan_products'),'p.idproducts=pp.idproducts')
		 	 -> where('pp.idplan='.$pid);
	   return $row = $db->fetchRow($select);
	   
	}
	
}

