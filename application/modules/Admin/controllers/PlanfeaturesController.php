<?php

class Admin_PlanfeaturesController extends Zend_Controller_Action
{
    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) {
    		$this->_redirect('/');
    	} else {
    		$useremail = $auth->getIdentity();
    		//$this->view->username = $userdata->username;
    	}
    }
    public function init()
    {
    	/*
    	 * This section is using for displaying the status of action
    	 * if st=1 then add success
    	 * if st=2 then update success
    	 * if st=3 then delete success
    	 */
    	$id=$this->_getParam('st');
    	$ps = new Admin_Model_DbTable_Planfeatures();
    	$this->view->ps = $ps->viewStatus($id);
    }

    public function indexAction()
    {
        // action body
    	$pf = new Admin_Model_DbTable_AdminUser();
    	$this->view->pf = $pf->planfeature();
    	
    }

    public function addAction()
    {
    if ($this->getRequest()->isPost()) 
		{
		
			
			$formData = $this->getRequest()->getPost();
		
			
			
				$hpcm_type_name = $formData['hpcm_type_name'];
				$hpcm_order = $formData['hpcm_order'];
				$status = $formData['status'];
				$min_val = $formData['min_val'];
				$delete	= $formData['delete'];
		
					
				// calling model db to insert values			
				$pfeature = new Admin_Model_DbTable_Planfeatures();
				$pfeature->addPlanFeatures($hpcm_type_name,$hpcm_order,$status,$delete);
				
				$this->_redirect('Admin/Planfeatures/index/st/1');
			}
		
    }

    public function editAction()
    {
        $id=$this->view->Dcode($this->_getParam('id'));
        
        
        
        if ($this->getRequest()->isPost())
        {
        
        		
        	$formData = $this->getRequest()->getPost();
        
        		
        	$hpcm_type_id = $formData['hpcm_type_id'];
        	$hpcm_type_name = $formData['hpcm_type_name'];
        	$hpcm_order = $formData['hpcm_order'];
        	$status = $formData['status'];
        	$min_val = $formData['min_val'];
        
        		
        	// calling model db to insert values (Planfeatures.php)
        	$pfeature = new Admin_Model_DbTable_Planfeatures();
        	$pfeature->editPlanFeatures($hpcm_type_id,$hpcm_type_name,$hpcm_order,$status,$min_val);
        	
        	$this->_redirect('Admin/Planfeatures/index/st/2');
        	
        }
        else //####### Retrive values to show in form
        {
        	$pfeature = new Admin_Model_DbTable_Planfeatures();
        	$this->view->fvalues = $pfeature->editPlanfeaturesvalues($id);
        	
        }
        
    }

    public function deleteAction()
    {
        // action body
    	$id=$this->_getParam('id');
    	$pfeature = new Admin_Model_DbTable_Planfeatures();
    	$this->view->fvalues = $pfeature->deletePlanFeatures($id);
    	$this->_redirect('Admin/Planfeatures/index/st/3');
    }


}









