<?php

class Admin_Model_DbTable_Acl extends Zend_Db_Table_Abstract
{

    protected $_name = 'acl_roles';

	public function rolllist() // For listing the Rolls from database
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cusid=$customerId->customerId;
	    
	    $db = Zend_Db_Table::getDefaultAdapter();

		$sql = 'SELECT id,customer_id,name,default_val,modified,created 
                        FROM acl_roles ';
		if(1!=$cusid) {
			$sql .= 'WHERE customer_id ='.$cusid;
		}
			$sql .= ' order by customer_id';
		
		$row = $db->fetchAll($sql);
   
	    if (!$row)
	    {
	    	//throw new Exception("Could not find row");
	    }
	    
	    return $row;
	}
	public function ResourceList()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql='select * from acl_resources order by module,controller,action';
	    return $db->fetchAll($sql);
	}
	public function AddResource($formData)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $data = array(
	    		'module_display_name'=>$formData['module_display_name'],
	    		'module'=>$formData['module'],
	            'controller_display_name'=>$formData['controller_display_name'],
	            'controller'=>$formData['controller'],
	            'action_display_name'=>$formData['action_display_name'],
	            'action'=>$formData['action'],
	            'listing_order'=>$formData['listing_order'],
	    		'created'=>date('Y-m-d'),
	            'modified'=>date('Y-m-d')
	    );
	    $numRows = $db->insert('acl_resources', $data);
	}
	public function RetriveResourceDetails($Rid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = "select * from acl_resources where id=".$Rid;
	    return $db->fetchRow($sql);
	}
	public function UpdateResource($formData)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $data = array(
	    		'module_display_name'=>$formData['module_display_name'],
	    		'module'=>$formData['module'],
	    		'controller_display_name'=>$formData['controller_display_name'],
	    		'controller'=>$formData['controller'],
	    		'action_display_name'=>$formData['action_display_name'],
	    		'action'=>$formData['action'],
	    		'listing_order'=>$formData['listing_order'],
	    		'modified'=>date('Y-m-d')
	    );
	    $numRows = $db->update('acl_resources', $data,'id='.$formData['id']);
	}
	public function DeleteResource($resourceid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $db->delete('acl_resources','id='.$resourceid);
	}
	public function ResellerList()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select id,Name from reseller_details order by id asc';
	    return $db->fetchAll($sql);
	}
	public function RoleList()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select distinct(name) from acl_roles';
	    return $db->fetchAll($sql);
	}
	public function AddRole($formData)
	{
//	echo "<pre>";
//	print_r($formData);
//	die;	
	    $db = Zend_Db_Table::getDefaultAdapter();
	    if($formData['ex_cusid']=='0' && $formData['new_reseller']!='') // New Reseller Adding
	    {
	        $data = array(
	        		'Name'=>$formData['new_reseller']
	        );
	        $db->insert('reseller_details', $data); // Adding new reseller Details into master table
	        $reseller=$db->lastInsertId();
	    } // From Selection
	    else
	    {
	        $reseller=$formData['ex_cusid'];
	    }
	    if($formData['ex_role']!='0')
	    {
	        $roll = $formData['ex_role']; 
	    }
	    else
	    {
	     	$roll = $formData['new_role'];   
	    }
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cusid=$customerId->customerId;
	    $data = array(
	    		'customer_id'=>$reseller,
	    		'name'=>$roll,
	    		'default_val'=>0,
	    		'created'=>date('Y-m-d'),
	    		'modified'=>date('Y-m-d')
	    );
//	    echo "<pre>";
//	    print_r($data);
	  //  die;
	    $numRows = $db->insert('acl_roles', $data);
	}
	function RetriveRoleDetails($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select * from acl_roles where id='.$id;
	    return $db->fetchAll($sql);
	}
	public function DeleteRole($roleid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
		$db->delete('acl_roles','id='.$roleid);
	}
	public function listprivilege()//listing the added privilages
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select * from acl_privilege';
	    return $db->fetchAll($sql);
	}
	public function addPrivilege($formData)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $data = array(
	    		'privilege'=>$formData['privilege'],
	    		'created'=>date('Y-m-d'),
	    		'modified'=>date('Y-m-d')
	    );
	    $numRows = $db->insert('acl_privilege', $data);
	}
	public function RetrivePrivilegeDetails($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = "select * from acl_privilege where id=".$id;
	    return $db->fetchRow($sql);
	}
	public function updatePrivilege($formData)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $data = array(
	    		'privilege'=>$formData['privilege'],
	    		'modified'=>date('Y-m-d')
	    );
	    $numRows = $db->update('acl_privilege', $data,'id='.$formData['id']);
	}
	public function deletePrivilege($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $db->delete('acl_privilege','id='.$id);
	}
	/*
	 * BELLOW SECTION IS USING FOR LINKING THE RESOURCE AND ROLL WITH RESELLER SECTION
	 */
	public function modulelist($cusid) //for link resource to role
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql='select id,name from acl_roles where customer_id='.$cusid.'';
	    return $db->fetchAll($sql);
	}
	public function ResellerRoleList($cusid)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$sql = 'select id,customer_id,name from acl_roles where customer_id='.$cusid.'';
		return $db->fetchAll($sql);
	}
	public function ResellerUserList($cusid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select AdminId,AdminFullName,AdminEmail from admin_details where customer_id='.$cusid.'';
	    return $db->fetchAll($sql);
	}
	public function ResellerControllerList($cusid,$roleid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select distinct(controller_display_name),controller from acl_resources where controller in (select distinct(controller) from acl_resources where module=\'Admin\'  order by module,controller,action)  order by module,controller,action';
	    return $db->fetchAll($sql);
	}
	public function ResellerActionList($id)
	{
	    $id=str_replace(',','","',$id);
	    $id='"'.$id.'"';
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select id,controller_display_name,action_display_name from acl_resources where controller in ('.$id.')  order by module,controller,action';
	    return $db->fetchAll($sql);
	}
}

