<?php

class Admin_AclController extends Zend_Controller_Action
{

    public function init()
    {
        /*
         * Initialize action controller here
         */
    }

    public function indexAction()
    {
        // action body
    }

    public function rolelistAction()
    {
        $this->view->st=$this->_getParam('st'); // for display status
        $rolllist = new Admin_Model_DbTable_Acl();
        // $this->view->rolllist = $rolllist->rolllist();
        $Gn = new Application_Model_DbTable_General();
        
        $rolllist = $rolllist->rolllist();
        $si = 0;
        foreach ($rolllist as $RL) 
        {
            $rolllist[$si]['customer_id'] = $Gn->Resellername($RL['customer_id']);
            $si += 1;
        }
        $this->view->rolllist = $rolllist;
    
    }

    public function roleAddAction()
    {
        $DbAcl = new Admin_Model_DbTable_Acl();
        $this->view->ResellerList =  $DbAcl->ResellerList();
        $this->view->RoleList = $DbAcl->RoleList();
        
        if ($this->getRequest()->isPost()) 
        {
        	$formData = $this->getRequest()->getPost();
        	unset($formData['button']);
        	
        	$DbAcl = new Admin_Model_DbTable_Acl();
        	$this->view->AddResource = $DbAcl->AddRole($formData);
        
        	$this->_redirect('Admin/Acl/rolelist/st/1');
        }        
    }

    public function roleEditAction()
    {
   		 $RL = new Admin_Model_DbTable_Acl();
   		 $this->view->ResellerList =  $RL->ResellerList();
   		 $this->view->RoleList = $RL->RoleList();
        if ($this->getRequest()->isPost()) 
        {
            $formData = $this->getRequest()->getPost();
            unset($formData['button']);
            
            $RL->UpdateResource($formData);
            
            $this->_redirect('Admin/Acl/rolelist/st/2');
        } 
        else
        {
       		$RoleId = $this->view->Dcode($this->_getParam("id"));
       		$RoleData = $RL->RetriveRoleDetails($RoleId);
       		
       		$GD = new Application_Model_DbTable_General();
       		$this->view->custid=$GD->Resellername($RoleData[0]['customer_id']);
       		$this->view->RoleData = $RL->RetriveRoleDetails($RoleId);
        }
        
    }

    public function roleDeleteAction()
    {
        $RL = new Admin_Model_DbTable_Acl();
        $RoleId = $this->_getParam("id");
        $RL->DeleteRole($RoleId);
        $this->_redirect('Admin/Acl/rolelist/st/3');
    }

    public function resourcelistAction()
    {
        // Listing avaiable resources
        $this->view->st=$this->_getParam('st'); // for display status
        $RL = new Admin_Model_DbTable_Acl();
        $this->view->ResourceList = $RL->ResourceList();
    }

    public function resourceAddAction()
    {
        if ($this->getRequest()->isPost()) 
        {
            $formData = $this->getRequest()->getPost();
            unset($formData['button']);

            $DbAcl = new Admin_Model_DbTable_Acl();
            $this->view->AddResource = $DbAcl->AddResource($formData);
            
            $this->_redirect('Admin/Acl/resourcelist/st/1');
        }
        
    }

    public function resourceEditAction()
    {
        $RL = new Admin_Model_DbTable_Acl();
        if ($this->getRequest()->isPost()) 
        {
            $formData = $this->getRequest()->getPost();
            unset($formData['button']);
            
            $RL->UpdateResource($formData);
            
            $this->_redirect('Admin/Acl/resourcelist/st/2');
        } 
        else
        {
       		$ResourceId = $this->view->Dcode($this->_getParam("id"));
       		$this->view->ResourceData = $RL->RetriveResourceDetails($ResourceId);
        }
        
    }

    public function resourceDeleteAction()
    {
        $RL = new Admin_Model_DbTable_Acl();
        $ResourceId = $this->_getParam("id");
        $RL->DeleteResource($ResourceId);
        $this->_redirect('Admin/Acl/resourcelist/st/3');
    }

    public function privilegeAction()
    {
        $this->view->st=$this->_getParam('st'); // for display status
        $db = new Admin_Model_DbTable_Acl();
        $this->view->privilegelist = $db->listprivilege();
    }

    public function privilegeaddAction()
    {
        if ($this->getRequest()->isPost())
        {
	        $db = new Admin_Model_DbTable_Acl();
	    	$formData = $this->getRequest()->getPost();
	        unset($formData['button']);
	        $db->addPrivilege($formData);
	        $this->_redirect('Admin/Acl/privilege/st/1');
        }
        
    }

    public function privilegeeditAction()
    {
        $RL = new Admin_Model_DbTable_Acl(); 
        if ($this->getRequest()->isPost())
        {
            $formData = $this->getRequest()->getPost();
            unset($formData['button']);
            $RL->updatePrivilege($formData);
            $this->_redirect('Admin/Acl/privilege/st/2');
          
        }
        else 
        {
	    	$PrivilegeId = $this->view->Dcode($this->_getParam("id"));
	       	$this->view->PrivilegeData = $RL->RetrivePrivilegeDetails($PrivilegeId);
        }
        
    }

    public function privilegedeleteAction()
    {
        $RL = new Admin_Model_DbTable_Acl();
        $PrivilegeId = $this->_getParam("id");
        $RL->deletePrivilege($PrivilegeId);
        $this->_redirect('Admin/Acl/privilege/st/3');
    }

    public function linkResourceToRoleAction()
    {
        // Reseller Listing
        $db = new Admin_Model_DbTable_Acl();
        $this->view->resellerlist = $db->ResellerList();
        
    }

    public function resellerRoleListAction()
    {
        $this->_helper->layout()->disableLayout();
        $cusid=$this->_getParam("cusid");
        $sec = $this->_getParam("sec");
       	$db = new Admin_Model_DbTable_Acl();
       	$this->view->rolelist = $db->ResellerRoleList($cusid);
       	$this->view->sec=$sec;
       	$this->view->cusid=$cusid;
    }

    public function resellerUsersListAction()
    {
        $this->_helper->layout()->disableLayout();
        $cusid=$this->_getParam("cusid");
        $db = new Admin_Model_DbTable_Acl();
        $this->view->userlist = $db->ResellerUserList($cusid);
    }

    public function resellerResourceListAction()
    {
        $this->_helper->layout()->disableLayout();
        $cusid=$this->_getParam("cusid");
        $sec=$this->_getParam("sec");
        $roleid=$this->_getParam("id");
        $db = new Admin_Model_DbTable_Acl();
        $this->view->ControllerList = $db->ResellerControllerList($cusid,$roleid);
        $this->view->sec=$sec;
    }

    public function resellerActionListAction()
    {
        $this->_helper->layout()->disableLayout();
        $controller=$this->_getParam("id");
        $sec=$this->_getParam("sec");

        $db = new Admin_Model_DbTable_Acl();
        $this->view->ActionList = $db->ResellerActionList($controller);
        $this->view->sec=$sec;
    }

    public function groupPermissionAction()
    {
        $DbAcl = new Admin_Model_DbTable_Acl();
        $ck=$DbAcl->ResellerList();
        $this->view->ResellerList =  $DbAcl->ResellerList();
    }


}