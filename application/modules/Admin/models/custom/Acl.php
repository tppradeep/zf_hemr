<?php

class Admin_Model_custom_Acl extends Zend_Acl{
	
	public static $_instance = null;
	
	public function __construct(){
	}
	
	public function __clone(){
	}
	
	public function _initialize(){
		
		$authUser_NameSpace = new Zend_Session_Namespace('Session_NameSpace');
		
		$role_privilege = new Admin_Model_DbTable_RolePrivilegeRelations();
		
		// fetch all the resources
		$resources = $role_privilege->fetchAll($role_privilege->select()
															  ->setIntegrityCheck(false)
															  ->from(array('p'=>'privileges'),array('id as privilege_id','name as privilege_name'))
															  ->joinLeft(array('c'=>'controllers'),'p.controller_id = c.id',array('id as controller_id','name as controller_name'))
															  ->joinLeft(array('m'=>'modules'),'c.module_id = m.id',array('id as module_id','name as module_name')));
		
		
		foreach($resources as $resource){
			
			if(!$this->has($resource->module_name.'_'.$resource->controller_name)){
				
				$module = $resource->module_name;
				$this->add(new Zend_Acl_Resource($module.'_'.$resource->controller_name));
			}
		}
		
		// user accessible privileges
		$roles = $role_privilege->fetchAll($role_privilege->select()
														  ->setIntegrityCheck(false)
														  ->from(array('rp'=>'role_privilege_relations'),array('role_id'))
														  ->joinInner(array('p'=>'privileges'),'rp.privilege_id = p.id',array('id as privilege_id','name as privilege_name'))
														  ->joinInner(array('c'=>'controllers'),'p.controller_id = c.id',array('id as controller_id','name as controller_name'))
														  ->joinInner(array('m'=>'modules'),'c.module_id = m.id',array('id as module_id','name as module_name'))
														  ->where('rp.role_id = '.$authUser_NameSpace->role_id));
		
		foreach($roles as $role){
			
			if (!$this->has($role->module_name.'_'.$role->controller_name)){
				
				$module = $role->module_name;
				$this->add(new Zend_Acl_Resource($module.'_'.$role->controller_name));
			}
			
			if (!$this->hasRole($role->role_id)){
				
				$this->addRole(new Zend_Acl_Role($role->role_id));
			}
		}
		
		$this->deny();
		
		foreach ($roles as $role){
			
			$module = $role->module_name;
			$this->allow($role->role_id, $module.'_'.$role->controller_name, $role->privilege_name);
		}
	}
	
	public static function getInstance(){
		
		if (null === self::$_instance){
			
			self::$_instance = new self();
			self::$_instance->_initialize();
		}
		
		return self::$_instance;
	}
	
	/**
	 * @version 1.0
	 * @Desc
	 * The function will be used to verfiy Access from the ACL object stored in session.
	 * The function will return either a boolean value or will render a file based on whether the ACL access is allowed or denied
	 * and what is the return type specified by user. default is set to file
	 *
	 * @param string - name of the module
	 * @param string - name of the controller
	 * @param string - name of the action
	 * @param string - return type (can take values 'file' or 'boolean' based on the return type the appropriate value will be returned)
	 * @return boolean - returns true or false based on whether the ACL access is allowed or denied
	 */
	public function checkAccess($module,$controller,$action,$return_type="file"){
		
		$authUser_NameSpace = new Zend_Session_Namespace('Session_NameSpace');
		
		$check_access = $authUser_NameSpace->acl->isAllowed($authUser_NameSpace->role_id, $module.'_'.$controller, $action) ? 'allowed':'denied';
		
		if($check_access=="denied"){
			
			if($return_type=="file")include_once(dirname(__FILE__)."/ErrorTemplates/access_denied.php");
			elseif($return_type=="boolean")return false;
			
			// terminate any further rendering
			exit;
		}
		elseif($check_access=="allowed" && $return_type=="boolean"){
			
			return true;
		}
	}
}
