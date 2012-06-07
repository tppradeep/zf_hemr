<?php

class PlanListController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
    		
    }

    public function listplanAction()
    {
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Plan List Page');
        
        $pid = $this->view->Dcode($this->_getParam('id'));
        $planname = new Application_Model_DbTable_PlanList();
      
        $this->view->pid = $pid;
        $this->view->planname = $planname->planname($pid);
        
        $P_name = $planname->planname($pid);
        
        $SelectedPlan = new Zend_Session_Namespace('SelectedPlan');
        $SelectedPlan->SelectedPlan = $P_name['hp_name'];
        
		$this->view->productdetails = $planname->productdetails($pid);
		
		$VariableProductCostTotal=0;
		$VariableProductSetupFeeTotal=0;

		$FixedProductCostTotal=0;
		$FixedProductSetupFeeTotal=0;
		
	
		$PaymentDetails = $planname->productdetails($pid); 
		
		foreach($PaymentDetails as $PD)
		{

			    //========= Product Cost Section===========//
			    if($PD['provider_cost_nature']==0)//Not Increment with selected provider
			    {
			        $FixedProductCostTotal = $FixedProductCostTotal + $PD['cost'];
			    }
			    if($PD['provider_cost_nature']==1)//Increment with selected provider
			    {
			        $VariableProductCostTotal = $VariableProductCostTotal + $PD['cost'];
			    }
			    
			    //==========Setup Section ===========//
			    if($PD['provider_setup_nature']==0)//Setup fee not increment with provider selection
			    {
			        $FixedProductSetupFeeTotal = $FixedProductSetupFeeTotal + $PD['setup_fee'];
			    }
			    if($PD['provider_setup_nature']==1)//Setup fee increment with provider selection
			    {
			        $VariableProductSetupFeeTotal = $VariableProductSetupFeeTotal + $PD['setup_fee'];
			    }
			
		}
		
		$this->view->VariableProductCostTotal=$VariableProductCostTotal;
		$this->view->FixedProductCostTotal=$FixedProductCostTotal;
		
		$this->view->VariableProductSetupFeeTotal=$VariableProductSetupFeeTotal;
		$this->view->FixedProductSetupFeeTotal=$FixedProductSetupFeeTotal;
		
		
		
    }

    public function compareplansAction()
    {
       // $this->_helper->layout->setLayout('user_noright'); 
        
       
        $allplans = new Application_Model_DbTable_PlanList();
        $this->view->allplans = $allplans->allplans();
        
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Compare Plans');
            
        $this->view->cmssupport = $cmsObj->getcms('ZHOpen EMR Support Scope');
        
    }

    public function productdtd($pid)
    {
	    
    }

    public function productDetailsAction()
    {
        $this->_helper->layout->setLayout('ajax');
        $pid = $this->_getParam('id');
        $GnDb = new Application_Model_DbTable_General();
        $this->view->ProDtd = $GnDb->ProductDetails($pid);
    }


}



?>



