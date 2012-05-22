<?php
/**
 *
 * @author openemr5
 * @version 
 */
require_once 'Zend/View/Interface.php';

/**
 * UserInfo helper
 *
 * @uses viewHelper Zend_View_Helper
 */
class Zend_View_Helper_UserInfo {
	
	/**
	 *
	 * @var Zend_View_Interface
	 */
	public $view;
	
	/**
	 *  
	 */
	/**public function userInfo() {
		// TODO Auto-generated Zend_View_Helper_UserInfo::userInfo() helper
		return null;
	}
	
	/**
	 * Sets the view field
	 * 
	 * @param $view Zend_View_Interface       	
	 */
	public function setView(Zend_View_Interface $view) {
		$sess = new Zend_Session_Namespace('MyNamespace');
		echo $sess->duser;
		$this->view = $view;
		
	}
}
