<?php /* COMPANIES $Id: companies.class.php 5872 2009-04-25 00:09:56Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

/**
 *	@package dotProject
 *	@subpackage modules
 *	@version $Revision: 5872 $
*/

require_once($AppUI->getSystemClass ('dp'));

/**
 *	Companies Class
 *	@todo Move the 'address' fields to a generic table
 */
class CCompany extends CDpObject {
/** @var int Primary Key */
	var $company_id = NULL;
/** @var string */
	var $company_name = NULL;

// these next fields should be ported to a generic address book
	var $company_phone1 = NULL;
	var $company_phone2 = NULL;
	var $company_fax = NULL;
	var $company_address1 = NULL;
	var $company_address2 = NULL;
	var $company_city = NULL;
	var $company_state = NULL;
	var $company_zip = NULL;
	var $company_email = NULL;

/** @var string */
	var $company_primary_url = NULL;
/** @var int */
	var $company_owner = NULL;
/** @var string */
	var $company_description = NULL;
/** @var int */
	var $company_type = null;
	
	var $company_custom = null;

	function CCompany() {
		$this->CDpObject('companies', 'company_id');
	}
    
// overload check
	function check() {
		if ($this->company_id === NULL) {
			return 'company id is NULL';
		}
		$this->company_id = intval($this->company_id);

		return NULL; // object is ok
	}

// overload canDelete
	function canDelete(&$msg, $oid=null) {
		$tables[] = array('label' => 'Projects', 'name' => 'projects', 'idfield' => 'project_id', 'joinfield' => 'project_company');
		$tables[] = array('label' => 'Departments', 'name' => 'departments', 'idfield' => 'dept_id', 'joinfield' => 'dept_company');
		$tables[] = array('label' => 'Users', 'name' => 'users', 'idfield' => 'user_id', 'joinfield' => 'user_company');
	// call the parent class method to assign the oid
		return CDpObject::canDelete($msg, $oid, $tables);
	}

	/*
	** Retrieve a hash list of companies filtered by company_type
	** @param		array		array of types, e.g. array(6,5)
	** @return	array 	HashList
	*/

	function listCompaniesByType ($type) {
		global $AppUI;
		$q = new DBQuery;
		$q->addQuery('company_id, company_name');
		$q->addTable('companies');
		foreach ($type as $t) { 
			$q->addWhere('company_type ='. $t);
		}
		$this->setAllowedSQL($AppUI->user_id, $q);
		$q->addOrder('company_name');

		return $q->loadHashList();
	}
}
?>
