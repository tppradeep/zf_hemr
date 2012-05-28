<?php

class UsercheckController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
         if ($this->getRequest()->isPost()) 
		{
		
			$formData = $this->getRequest()->getPost();
		
			$uid = $formData['uid'];
			$pwd = sha1(trim($formData['pwd']));
			$usertype = $formData['usertype'];
			
			$db = Zend_Db_Table::getDefaultAdapter();
			
		//	if($usertype==1)// Customer
	//		{
				$adapter = new Zend_Auth_Adapter_DbTable(
	                $db,
	                'hosted_facilities',
	                'hf_email',
	                'dashboard_password'
	                );
				$adapter->setIdentity($uid);
	            $adapter->setCredential($pwd);
				
				$auth   = Zend_Auth::getInstance();
	            $result = $auth->authenticate($adapter);
	           
	            if ($result->isValid()) 
				{
					
					$select = $db->select()
					->from(array('h'=>'hosted_facilities'),array('h.hf_id'))
					->where('h.hf_email="'.$uid.'"');
					
					$hf_id = $db->fetchOne($select);
					
					
					Zend_Session::start();
					$sess = new Zend_Session_Namespace('user');
	    			$sess->duser = $uid;
	    			$sess->hf_id = $hf_id;
					
					//$userName = $sess->duser;
					
					$this->_helper->FlashMessenger('Successful Login');
	              	$this->_redirect('user');
	                return;
	            }
				else
				{
					/*
					 * presently redirecting to index page. this section has to modify with login error section
					 */
		//			$emes=$this->view->Ecode("not");
		//			$this->_redirect("/?emes=".$emes."");	
	//			}
		//	}
			//==================================================
	//		if($usertype==2)// Reseller ie admin login
	//		{
			    $db = Zend_Db_Table::getDefaultAdapter();
			    	
			    $adapter = new Zend_Auth_Adapter_DbTable(
			    		$db,
			    		'admin_details',
			    		'AdminEmail',
			    		'AdminPassword',
			            'role'
			    );
			    $adapter->setIdentity($formData['uid']);
			    $adapter->setCredential($formData['pwd']);
			    	
			    $auth   = Zend_Auth::getInstance();
			    $result = $auth->authenticate($adapter);
			    
			    if ($result->isValid())
			    {
			        
			        $data = $adapter->getResultRowObject(null, 'pwd');
			        $auth->getStorage()->write($data);
			     //   $userdata = $auth->getIdentity();
			      //  echo "<pre>";
			       // print_r($userdata);
			        //die;
			    	Zend_Session::start();
			    	$sess = new Zend_Session_Namespace('MyNamespace');
			    	$sess->username = $uid;
			    	
			    	$userdtd = new Application_Model_DbTable_Usercheck();
			    	$userdata = $userdtd->userdtd($formData['uid'],$formData['pwd']);
			    	
			    	
			    	
			    	$AdminFullName = $userdata['AdminFullName'];
			    	$sess->displayname = $userdata['AdminFullName'];
			    	$sess->adminid = $userdata['AdminId'];
			    	
			    
			    	$customerId = new Zend_Session_Namespace('customerId');
			    	$customerId->customerId = $userdata['customer_id'];
			    	//	echo $userName = $sess->username;
			    
			    	$this->_helper->FlashMessenger('Successful Login');
			    	$this->_redirect('Admin/admin');
			    	return;
			    }
			    else
			    {
			    	/*
			    	 * presently redirecting to index page. this section has to modify with login error section
			    	*/
			    	$emes=$this->view->Ecode("not");
			    	$this->_redirect("/?emes=".$emes."");
			    }
			}
		}
    }


}

