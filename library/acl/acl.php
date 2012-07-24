<?php
require_once 'Zend/Acl.php';
$acl = new Zend_Acl();

require_once 'Zend/Acl/Role.php';
$acl->addRole(new Zend_Acl_Role('basic'));
$acl->addRole(new Zend_Acl_Role('Super Admin'));


require_once 'Zend/Acl/Resource.php';
$acl->add(new Zend_Acl_Resource('Plans'));

$acl->allow('Super Admin'); //this allows the premium role access to all defined resources
$acl->deny('basic', 'Plans'); //deny basic role access to Plans resource.


Zend_Registry::set('acl', $acl);
?>