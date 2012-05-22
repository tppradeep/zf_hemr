<?php

class Admin_Model_DbTable_Planfeatures extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_plan_content_mapping';

    public function addPlanFeatures($hpcm_type_name,$hpcm_order,$status,$delete)
    {
    	$customerId = new Zend_Session_Namespace('customerId');
    	$data = array(
    			'customer_id'=>$customerId->customerId,
    			'hpcm_type_name' => $hpcm_type_name,
    			'hpcm_order' => $hpcm_order,
    			'hpcm_level' => 1,
    			'status' => $status,
    			'delete'=>$delete
    	);
    
    	$this->insert($data);
    }
    public function viewStatus($ival)
    {
    	if($ival==1)
    	{
    		return "Successfully Added New Record";
    	}
    	elseif($ival==2)
    	{
    		return "Successfully updated the Record";
    	}
    	elseif($ival==3)
    	{
    		return "Successfuly deleted the Record";
    	}
    }
    
    public function editPlanfeaturesvalues($id)
    {
    	$row=$this->fetchRow('hpcm_type_id='.$id);
    	if(!$row)
    	{
    		throw new Exception("Count not find row $id");
    	}
    	return $row->toArray();
    }
    public function editPlanFeatures($hpcm_type_id,$hpcm_type_name,$hpcm_order,$status,$min_val)
    {
    	$customerId = new Zend_Session_Namespace('customerId');
    	$data = array(
    			'customer_id'=>$customerId->customerId,
    			'hpcm_type_name' => $hpcm_type_name,
    			'hpcm_order' => $hpcm_order,
    			'hpcm_level' => 1,
    			'min_val'=>$min_val
    			);
    	$this->update($data,'hpcm_type_id='.(int)$hpcm_type_id);
    }
    public function deletePlanFeatures($hpcm_type_id)
    {
    	$this->delete('hpcm_type_id='.(int)$hpcm_type_id);
    }
}

