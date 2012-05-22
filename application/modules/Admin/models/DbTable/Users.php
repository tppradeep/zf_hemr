<?php

class Admin_Model_DbTable_Users extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function userlist()
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('hosted_facilities'),array('hf_id','hf_facility_identifier','hf_facility_name','hf_email','reg_date','user_status'))
	    ->where('customer_id='.$customerId->customerId)
	    ->order('hf_id DESC');
	     
	    $row = $db->fetchAll($select);
	
	    
	    if (!$row)
	    {
	    	//throw new Exception("Could not find row");
	    }
	     
	    return $row;
	}
	public function retriveuserdetails($hf_id)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('hosted_facilities'),array('hf_facility_name','hf_speciality','hf_email','hf_phone','hf_address','hf_fax','hf_city','hf_zip','hf_state','hf_tax_id','hf_country','hf_npi'))
		->where('hf_id="'.$hf_id.'"');
		return $db->fetchRow($select);
	}
	public function deleteUser($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->delete('hosted_facilities','hf_id='.$hf_id);
	    $select = $db->delete('customer_selected_plan','hf_id='.$hf_id);
	    $select = $db->delete('customer_products','hf_id='.$hf_id);
	    $select = $db->delete('customer_invoice','hf_id='.$hf_id);
	    
	}
	public function userinvoice($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('customer_invoice'),array('idcustomer_invoice','plan_id','invoice_number','invoice_date','payment_date','amount','setupfee','payment_status'))
	    ->where('hf_id="'.$hf_id.'"');
	    return $db->fetchAll($select);
	}
	public function planname($hf_id)
	{
		
	
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_selected_plan'),array('plan_name','plan_activated_date'))
		->where('hf_id="'.$hf_id.'"');
		return $db->fetchRow($select);
	}
	
	
	public function productdetails($hf_id)
	{
	    $hf = $hf_id;
		$pdtd = $this->listplanfeatures($hf);
		$pid = $pdtd['plan_id'];
	
		 
		//select p.idproducts,p.product_name,p.product_feature,p.cost,p.payment_term from products p, plan_products pp where pp.idproducts=p.idproducts and pp.idplan=1
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		-> from(array('p'=>'customer_products'),array('p.idproducts','p.product_name','p.product_feature','p.cost','p.setup_fee','p.payment_term'))
		-> where('p.hf_id='.$hf_id)
		-> where('p.hp_id='.$pid);
			
		$row = $db->fetchAll($select);
			
		if (!$row)
		{
			throw new Exception("Could not find row");
		}
		return $row;
	}
	public function listplanfeatures($hf_id)
	{
	
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_selected_plan'),array('idcustomer_selected_plan','plan_id','plan_name'))
		->where('hf_id="'.$hf_id.'"');
		return $plandtd = $db->fetchRow($select);
	
	}
	public function providerno($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('customer_selected_plan'),array('provider_no'))
	    ->where('hf_id="'.$hf_id.'"');
	    return $plandtd = $db->fetchOne($select);
	}
	public function userresourcelist($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql = 'select acl_resource,acl_action from acl_user_setting where hf_id='.$hf_id;
	    $acl_dtd = $db->fetchAll($sql);
	    echo "<pre>";
	    print_r($acl_dtd);
	    die;
	   	$acl_resource = $acl_dtd[0]['acl_resource'];
		$acl_action = $acl_dtd[0]['acl_action']; 	
    
	    
		
		
		
	    
	    $sql = 'select distinct(controller_display_name),controller from acl_resources where controller in (select distinct(controller) from acl_resources where module=\'user\' order by listing_order asc)';
		$control_list =  $db->fetchAll($sql);

		$output = '<table width="100%" border="0" cellspacing="2" cellpadding="2">';

		foreach($control_list as $RL)
		{
		  $output .= '<tr>';
		  $pos = strpos($acl_resource, $RL['controller']);
		  if($pos !== false)
		  {
		      $chk_string = 'checked';
		  }
		  else
		  {
		      $chk_string='';
		  }
		  $output .= '<td class="shadowlight">';
		  $output .= '<input name="cont" type="checkbox" value="'.$RL['controller'].'" '.$chk_string.' onclick="userprivilage(this.value,\''. $hf_id.'\')" /></td>';
		  $output .= '<td width="100%" class="shadowlight">'.$RL['controller_display_name'].'</td>';
		  $pos=false;
		}

		$output .='</tr>';
		$output .= '</table>';
		
		$output ='<td valign="top">'.$output.'</td>';
		$UserAction = $this->useractionlist($acl_resource, $hf_id);
		//print_r($UserAction);
		
		
		/*
		 * Action Set
		*/
		$output2 = '<td valign="top" id="privilegelist">'.$UserAction.'</td>';
		
		
		return $output.$output2;
	}
	public function useractionlist($id,$hf_id)
	{
	   /*
	    * UPDATE THE SELECTED RESOURCES INTO USER TABLE
	    */
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql = 'select acl_resource,acl_action from acl_user_setting where hf_id='.$hf_id;
	    $acl_dtd = $db->fetchAll($sql);
	     
	    
	    $acl_action = $acl_dtd[0]['acl_action'];
	    $acl_resource = $acl_dtd[0]['acl_resource'];

	    
	    $sql = 'select count(id) from acl_user_setting where hf_id='.$hf_id;
	    if($db->fetchOne($sql)==0)
	    {
	        $data = array(
	                'hf_id'=>$hf_id,
	        		'acl_resource' => $id
	        );
	        
	        $db->update('acl_user_setting', $data,'hf_id = "'.$hf_id.'"');
	    }   
	    else 
	    { 
		    $data = array(
		    		'acl_resource' => $id
		    );
		    
		    $db->update('acl_user_setting', $data,'hf_id = "'.$hf_id.'"');
	    }
	    /*
	     * Udate End
	     */
	    
		$id=str_replace(',','","',$id);
		$id='"'.$id.'"';
		$db = Zend_Db_Table::getDefaultAdapter();
		$sql = 'select id,controller_display_name,action,action_display_name from acl_resources where controller in ('.$id.') order by module,controller,action';
		$UserAction = $db->fetchAll($sql);
		
		
		$output2 = '<table width="99%">';
		
		$con_d_name='';
		$acl_action = explode(",",$acl_action);
	//	print_r($acl_action);
		foreach($UserAction as $AL)
		{
			if($con_d_name=="" || $AL['controller_display_name']<>$con_d_name)
			{
				$con_d_name=$AL['controller_display_name'];
				$output2 .= '<tr><td colspan="2" class="sub-head">'.$AL['controller_display_name'].'</td></tr>';
			}
				
			foreach($acl_action as $aa)
			{
				if($aa == $AL['id'])
				{
					$chk_string = 'checked';
					break;
				}
				else
				{
					$chk_string='';
				}
			}
			//die;
			$output2 .=	'<tr>';
			$output2 .= '<td><input type="checkbox" name="act" value="'.$AL['id'].'" '.$chk_string.' onclick="useraction(this.value,\''.$hf_id.'\')"></td>';
			$output2 .= '<td class="label b shadowlight" width="100%">'.$AL['action_display_name'].'</td>';
			$output2 .= '</tr>';
				
		}
		$output2 .'</table>';
		
		return $output2;
	}
	public function useractionupdate($id,$hf_id)
	{
	    /*
	     * UPDATE THE SELECTED action INTO USER TABLE
	    */
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql = 'select count(id) from acl_user_setting where hf_id='.$hf_id;
	    if($db->fetchOne($sql)==0)
	    {
	        $data = array(
	                'hf_id'=>$hf_id,
	        		'acl_action' => $id
	        );
	         
	        $db->insert('acl_user_setting', $data,'hf_id = "'.$hf_id.'"');
	    }
	    else
	    {
		    $data = array(
		    		'acl_action' => $id
		    );
		     
		    $db->update('acl_user_setting', $data,'hf_id = "'.$hf_id.'"');
	    }
	    /*
	     * Udate End
	    */
	}
}