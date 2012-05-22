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
        $pid = $this->view->Dcode($this->_getParam('id'));
        $planname = new Application_Model_DbTable_PlanList();
        $this->view->pid = $pid;
        $this->view->planname = $planname->planname($pid);
		$this->view->productdetails = $planname->productdetails($pid);
		
		$MonthlyVariableProductCostTotal=0;
		$MonthlyVariableProductSetupFeeTotal=0;
		
		$OnetimeVariableProductCostTotal=0;  // IF Payment Term is One Time and multiply with selection of provider
		$OnetimeVariableProductSetupFeeTotal=0; // IF Payment Term is One Time and multiply with selection of provider
		
		$MonthlyFixedProductCostTotal=0;
		$MonthlyFixedProductSetupFeeTotal=0;
		
		$OnetimeFixedProductCostTotal=0; // IF Payment Term is One Time and not varry with selection of provider
		$OnetimeFixedProductSetupfeeTotal=0; // IF Payment Term is One Time not varry with selection of provider
		
		$PaymentDetails = $planname->productdetails($pid); 
		
		foreach($PaymentDetails as $PD)
		{
		  //  echo $PD['payment_term'];
		  //  echo "<br>";
		  //  echo $PD['cost'];
		  //  echo "<br>";
		  //  echo $PD['setup_fee'];
		  //  echo "================";
			if($PD['payment_term']==0) // One Time Payment
			{
			    //========= Product Cost Section===========//
			    if($PD['provider_cost_nature']==0)//Not Increment with selected provider
			    {
			        $OnetimeFixedProductCostTotal = $OnetimeFixedProductCostTotal + $PD['cost'];
			    }
			    if($PD['provider_cost_nature']==1)//Increment with selected provider
			    {
			        $OnetimeVariableProductCostTotal = $OnetimeVariableProductCostTotal + $PD['cost'];
			    }
			    
			    //==========Setup Section ===========//
			    if($PD['provider_setup_nature']==0)//Setup fee not increment with provider selection
			    {
			        $OnetimeFixedProductSetupfeeTotal = $OnetimeFixedProductSetupfeeTotal + $PD['setup_fee'];
			    }
			    if($PD['provider_setup_nature']==1)//Setup fee increment with provider selection
			    {
			        $OnetimeVariableProductSetupFeeTotal = $OnetimeVariableProductSetupFeeTotal + $PD['setup_fee'];
			    }
			}
			elseif($PD['payment_term']==1) // Monthly Payment
			{
			    //========= Product Cost Section===========//
			    if($PD['provider_cost_nature']==0)//Not Increment with selected provider
			    {
			    	$MonthlyFixedProductCostTotal = $MonthlyFixedProductCostTotal + $PD['cost'];
			    }
			    if($PD['provider_cost_nature']==1)//Increment with selected provider
			    {
			    	$MonthlyVariableProductCostTotal = $MonthlyVariableProductCostTotal + $PD['cost'];
			    }
			     
			    //==========Setup Section ===========//
			    if($PD['provider_setup_nature']==0)//Setup fee not increment with provider selection
			    {
			    	$MonthlyFixedProductSetupFeeTotal = $MonthlyFixedProductSetupFeeTotal + $PD['setup_fee'];
			    }
			    if($PD['provider_setup_nature']==1)//Setup fee increment with provider selection
			    {
			    	$MonthlyVariableProductSetupFeeTotal = $MonthlyVariableProductSetupFeeTotal + $PD['setup_fee'];
			    }
			}
		}
		
		$this->view->MonthlyVariableProductCostTotal=$MonthlyVariableProductCostTotal;
		$this->view->MonthlyVariableProductSetupFeeTotal=$MonthlyVariableProductSetupFeeTotal;
		
		$this->view->OnetimeVariableProductCostTotal=$OnetimeVariableProductCostTotal;
		$this->view->OnetimeVariableProductSetupFeeTotal=$OnetimeVariableProductSetupFeeTotal;
		
		$this->view->MonthlyFixedProductCostTotal=$MonthlyFixedProductCostTotal;
		$this->view->MonthlyFixedProductSetupFeeTotal=$MonthlyFixedProductSetupFeeTotal;
		
		$this->view->OnetimeFixedProductCostTotal=$OnetimeFixedProductCostTotal;
		$this->view->OnetimeFixedProductSetupfeeTotal=$OnetimeFixedProductSetupfeeTotal; 
		
		//echo "<pre>";
		//print_r($PaymentDetails);
		//echo "</pre>";
		//die;
		
    }

    public function compareplansAction()
    {
        $this->_helper->layout->setLayout('user_noright'); 
        
        
        $allplans = new Application_Model_DbTable_PlanList();
        $this->view->allplans = $allplans->allplans();
        
       
        
    }
	public function productdtd($pid)
	{
	    
	}

}


?>


