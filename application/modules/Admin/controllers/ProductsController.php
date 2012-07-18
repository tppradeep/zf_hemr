<?php

class Admin_ProductsController extends Zend_Controller_Action
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
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        $ps = new Admin_Model_DbTable_Products();
        $this->view->products = $ps->products();
        $this->view->st=$this->_getParam('st');
    	
    }

    public function addAction()
    {
        $gndb = new Application_Model_DbTable_General();
        $this->view->emrlist = $gndb->emrfeature();
    	if ($this->getRequest()->isPost()) 
		{
		    $customerId = new Zend_Session_Namespace('customerId');
		    $customer_id=$customerId->customerId;
			$formData = $this->getRequest()->getPost();
				$category = $formData['category'];
				$product_name = $formData['product_name'];
				$product_feature = $formData['product_feature'];
				$cost = $formData['cost'];
				$setup_fee = $formData['setup_fee'];
				$product_sort_order = $formData['product_sort_order'];
				$product_status=$formData['product_status'];
				$ProductType=$formData['ProductType'];
				$provider_cost_nature = $formData['provider_cost_nature'];
				$provider_setup_nature = $formData['provider_setup_nature'];
				$emrfeature = $formData['emrfeature'];					
				// calling model db to insert values			
				$pfeature = new Admin_Model_DbTable_Products();
				$pid=$pfeature->addProduct($category,$idproducts,$product_name,$customer_id,$product_feature,$cost,$setup_fee,$product_sort_order,$product_status,$ProductType,$provider_cost_nature,$provider_setup_nature,$emrfeature);
				
						
				$this->_redirect('Admin/Products/index/st/1');
			}
    }

    public function editAction()
    {
        $gndb = new Application_Model_DbTable_General();
        $this->view->emrlist = $gndb->emrfeature();
        
    	$id=$this->view->Dcode($this->_getParam('id')); // Retriving id from query string
    	
    	if ($this->getRequest()->isPost())
    	{
    	    $customerId = new Zend_Session_Namespace('customerId');
    	    $customer_id=$customerId->customerId;
    	
    		$formData = $this->getRequest()->getPost();
    		
    		$category = $formData['category'];
    		$idproducts = $formData['idproducts'];
    		$product_name = $formData['product_name'];
			$product_feature = $formData['product_feature'];
			$cost = $formData['cost'];
			$setup_fee = $formData['setup_fee'];
			$product_sort_order = $formData['product_sort_order'];
			$product_status=$formData['product_status'];
			$ProductType=$formData['ProductType'];
			$provider_cost_nature = $formData['provider_cost_nature'];
			$provider_setup_nature = $formData['provider_setup_nature'];
			$emrfeature = $formData['emrfeature'];
    	
    		// calling model db to insert values (Planfeatures.php)
    		$pss = new Admin_Model_DbTable_Products();
    		$pss->updateProduct($category,$idproducts,$product_name,$customer_id,$product_feature,$cost,$setup_fee,$product_sort_order,$product_status,$ProductType,$provider_cost_nature,$provider_setup_nature,$emrfeature);
    		 
    		$this->_redirect('Admin/Products/index/st/2');
    		 
    	}
    	else 
    	{
        	$id=$this->view->Dcode($this->_getParam('id'));
	    	$productview = new Admin_Model_DbTable_Products(); // initializing the class
	    	$this->view->productview = $productview->viewProducts($id); // Calling values to display
    	} 
    }

    public function deleteAction()
    {
        $id=$this->_getParam('id');
    	
    	$pfdel = new Admin_Model_DbTable_Products();
    	try {
    	    $this->view->ffpg = $pfdel->deleteproduct($id);
    	}
   		 catch (Zend_Http_Client_Adapter_Exception $e) {
    // ah ha
			} catch (Zend_Some_other_Exception $e) {
    // ah ha
		} catch (Exception $e) {
		    $this->view->ffpg = "3not";
		   
    // And the final fallback catch that grabs all exceptions
		}
    	
    	
    	
    	$this->_redirect('Admin/Products/index/st/3');
    }
    public function deleteallAction()
    {
    	$id=$this->_getParam('id');
    	$delids = explode(",",$id);
    	
	   	$pss = new Admin_Model_DbTable_Products();
	   	foreach($delids as $id)
	   	{
	   	    base64_decode($id);
	   	    
	   	    if($id<>'0')
	   	    	$this->del = $pss->deleteproduct(base64_decode($id));
	   	}
    	
    	$this->_redirect('Admin/Products/index/st/3');
    }
    public function viewAction()
    {
    	$this->_helper->layout()->disableLayout();
    	$id=$this->_getParam('id');
    	$productview = new Admin_Model_DbTable_Products(); // initializing the class
    	$this->view->productview = $productview->viewProducts($id); // Calling values to display
    	
    	$ps = new Admin_Model_DbTable_Productprice();
    	$this->view->productprice = $ps->productprice($id);
    }
}