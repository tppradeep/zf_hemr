<?php

class User_ProfileController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->checkacl('0','0','0','1'); // Just for initiallization for helper call
        $this->view->checkaclresource('0','0',0); // Just for initiallization for helper call
    }

    public function indexAction()
    {
        $country = new Application_Model_DbTable_General();
        $this->view->country = $country->countrylist();
        
        $userdetails = new user_Model_DbTable_Profile();
        $this->view->formdata = $userdetails->retriveuserdetails();
        
        if ($this->getRequest()->isPost())
        {
        		
        	$formData = $this->getRequest()->getPost();
        		$hf_organization=$formData['hf_organization'];
        		$hf_facility_suffix=$formData['hf_facility_suffix'];
        		$hf_facility_name = $formData['hf_facility_name'];
        		$hf_facility_lname = $formData['hf_facility_lname'];
				$hf_speciality = $formData['hf_speciality'];
				$hf_address = $formData['hf_address'];
				$hf_city = $formData['hf_city'];
				$hf_state = $formData['hf_state'];
				$hf_zip = $formData['hf_zip'];
				$hf_country = $formData['hf_country'];
				$hf_phone = $formData['hf_phone'];
				$hf_fax = $formData['hf_fax'];
				$hf_tax_id = $formData['hf_tax_id'];
				$hf_npi = $formData['hf_npi'];

				$user = new user_Model_DbTable_Profile();
				$st=$user->updateuser($hf_organization,$hf_facility_suffix,$hf_facility_name,$hf_facility_lname,$hf_speciality,$hf_address,$hf_city,$hf_state,$hf_zip,$hf_country,$hf_phone,$hf_fax,$hf_tax_id,$hf_npi);
				
				$userdetails = new user_Model_DbTable_Profile();
				$this->view->formdata = $userdetails->retriveuserdetails();
				$this->view->st="y";
        }
    }


}

