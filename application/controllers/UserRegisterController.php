<?php

class UserRegisterController extends Zend_Controller_Action
{

    public function init()
    {
        
    }

    public function indexAction()
    {
    	
    }

    public function adduserAction()
    {
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Register User');
        
    	$Gndb = new Application_Model_DbTable_General();
    	$this->view->country = $Gndb->countrylist();
    	$this->view->speciality = $Gndb->SpecialityList();
    	$this->view->state = $Gndb->statelist('USA');
    	

    	if ($this->getRequest()->isPost())
    	{
    	
		   	$formData = $this->getRequest()->getPost();
		  
		  
		   	if($formData['_sec']=="plan")
		   	{
	    	$this->view->plandetails=$formData;
			$pid = $this->view->Dcode($formData['pid']);
			
			$spv = new Application_Model_DbTable_PlanList();
			$this->view->sp_view = $spv->planname($pid);
		   	}
		   	if($formData['_sec']=="register")
		   	{
		   	   // $formData = $this->getRequest()->getPost();
		   	    
		   	    /*
		   	     * Plan Details Start
		   	    */
		   	    $this->view->plandetails=$formData; // important to get plan price
		   	    
		   	    $apid = $formData['apid'];
		   	    $pid = $formData['pid'];
		   	    $bpcost=$formData['bpcost'];
		   	    $btotalfee=$formData['btotalfee'];
		   	    $pcost=$formData['pcost'];
		   	    $setupfee=$formData['setupfee'];
		   	    $totalfee=$formData['totalfee'];
		   	    
		   	    
		   	    /*
		   	     * Plan Details End
		   	    */
		   	    $hf_organization = $formData['hf_organization'];
		   	    $hf_facility_identifier = $formData['hf_facility_identifier'];
		   	    $hf_facility_suffix = $formData['hf_facility_suffix'];
		   	    $hf_facility_name = $formData['hf_facility_name'];
		   	    $hf_facility_lname = $formData['hf_facility_lname'];
		   	    
		   	    $userfullname = new Zend_Session_Namespace('UserFullName');
		   	    $userfullname->UserFullName = $hf_facility_suffix.' '.$hf_facility_name.' '.$hf_facility_lname;
		   	    
		   	    $hf_speciality = $formData['hf_speciality'];
		   	    if($hf_speciality=="Other")
		   	    {
		   	        $hf_speciality = $formData['hf_speciality_other'];
		   	    }
		   	    $dashboard_password = $formData['dashboard_password'];
		   	    $dashboard_password_confirm = $formData['dashboard_password_confirm'];
		   	    $hf_email = $formData['hf_email'];
		   	    $hf_address = $formData['hf_address'];
		   	    $hf_city = $formData['hf_city'];
		   	   
		   	    $hf_zip = $formData['hf_zip'];
		   	    $hf_country = $formData['hf_country'];
		   	    if($hf_country=="USA")
		   	    {
		   	        $hf_state = $formData['hf_state'];
		   	    }
		   	    else
		   	    {
		   	        $hf_state = $formData['hf_state_other'];
		   	    }
		   	    $hf_phone = $formData['hf_phone'];
		   	    $hf_fax = 0;
		   	    $hf_tax_id = 0;
		   	    $hf_npi = 0;
		   	     
		   	    //$formData['error']="";
		   	     
		   	    // calling model db to insert values
		   	     
		   	    $customerId = new Zend_Session_Namespace('customerId');
		   	    $cusid=$customerId->customerId;
		   	     
		   	    $user = new Application_Model_DbTable_UserRegister();
		   	    $uid=$user->addUser($hf_organization,$hf_facility_identifier,$cusid,$hf_facility_suffix,$hf_facility_name,$hf_facility_lname,$hf_speciality,$dashboard_password,$dashboard_password_confirm,$hf_email,$hf_address,$hf_city,$hf_state,$hf_zip,$hf_country,$hf_phone,$hf_fax,$hf_tax_id,$hf_npi,$pid,$apid,$bpcost,$pcost,$setupfee,$totalfee);
		   	    if($uid=="schemaexist")
		   	    {
		   	    	$formData['error']="facility"; // Adding the error cause;
		   	    	$this->view->formdata=$formData;
		   	    }
		   	    elseif($uid=="dashboarduserid")
		   	    {
		   	    	$formData['error']="dashboarduser"; // Adding the error cause;
		   	    	$this->view->formdata=$formData;
		   	    	 
		   	    }
		   	    else
		   	    {
		   	    	$userid = new Application_Model_DbTable_UserRegister();
		   	    	$hf_id=$userid->hf_idInfo($hf_email);
		   	    	 
		   	    
		   	    	$session = new Zend_Session_Namespace('user');
		   	    	unset($session->hf_id);
		   	    	unset($session->duser);
		   	    	 
		   	    
		   	    	 
		   	    	Zend_Session::start();
		   	    	$sess = new Zend_Session_Namespace('user');
		   	    	$sess->duser = $hf_email;
		   	    	$sess->hf_id = $hf_id;
		   	    	 
		   	    	unset($formData);
		   	    	$this->_redirect('Cart/index/uID/'.$this->view->Ecode($uid).'/Pid/'.$pid);
		   	    }
		   	}
    	}
		
		
    }

    public function facilityAction()
    {
		//echo $fcval = $this->_getParam('fc');
		$this->_helper->layout()->disableLayout();
      //  $fc = new Application_Model_DbTable_UserRegister();
		//$this->view->sp_view = $fc->facilitycheck($fcval);
    }

    public function userregisterAction()
    {
       
  
    }

    public function emailcheckAction()
    {
        $this->_helper->layout()->disableLayout();
        $fieldValue = $this->_getParam('fieldValue');
        $fieldId = $this->_getParam('fieldId');
        
        $GnDb = new Application_Model_DbTable_General();
        $email = $GnDb->emailchecking($fieldValue);
        if($email==1)
        {
            echo '["'.$fieldId.'",true]';
        }
        else
        {
            echo '["'.$fieldId.'",false]';
        
    	}
    }
  
    public function hostedidentifiercheckAction()
    {
    	$this->_helper->layout()->disableLayout();
        $fieldValue = $this->_getParam('fieldValue');
        $fieldId = $this->_getParam('fieldId');
        
        $GnDb = new Application_Model_DbTable_General();
        $idval = $GnDb->identifierchecking($fieldValue);
        if($idval==1)
        {
            echo '["'.$fieldId.'",true]';
        }
        else
        {
            echo '["'.$fieldId.'",false]';
        
    	}
    }

}






?>








