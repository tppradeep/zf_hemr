<?php

class User_ProductsController extends Zend_Controller_Action
{

    public function init()
    {
         $this->view->checkacl('0','0','0','1'); // Just for initiallization for helper call
        $sess = new Zend_Session_Namespace('user');
        $this->view->hf_id=$sess->hf_id;
    }

    public function indexAction()
    {
        
        $sess = new Zend_Session_Namespace('user');
        $hf_id=$sess->hf_id;
        $PrimaryProductAdd = new user_Model_DbTable_Products();
        if ($this->getRequest()->isPost())
        {
           $formData = $this->getRequest()->getPost();
        //   echo "<pre>";
       //    print_r($formData);
           $fdkey = array_keys($formData);
           foreach($fdkey as $ffk)
           {
               //echo $ffk;
               if($formData[$ffk]=="on")
               {
                  $ivalue = str_replace("_cart", '', $ffk);
                  $providerno	= $this->_getParam($ivalue);
                 
              //     if($formData[$ivalue]==1) // There is only one provider, basic price of product have to pick
             //      {
                       $dval = $PrimaryProductAdd->productaddtocart($ivalue,$providerno);
             //      }
             //      else // Picking the correct product cost based on provider range from product_price and updating cart
             //      {
               //        $idval = $PrimaryProductAdd->CustomePriceAddToCart($ivalue,$formData[$ivalue]);
             //      }
                      
               }
           }
           $this->_redirect("/Cart/index/uID/".$this->view->Ecode($hf_id)."/Pid/".$this->view->Ecode(0)."");
           
           die;
        }
        else
        {
	        $products = new user_Model_DbTable_Products();
	       
	                
	        $this->view->products = $products->cart_product_list($this->view->baseurl(),$this->view->checkacl('user','Products','addtocart',$hf_id));
	            
	        $sess = new Zend_Session_Namespace('user');
	        $this->hf_id=$sess->hf_id;
        }
        
    }

    public function productfeatureAction()
    {
        $this->_helper->layout()->disableLayout();
    	$id=$this->view->Dcode($this->_getParam('id'));
    	$productview = new user_Model_DbTable_Products(); // initializing the class
    	$this->view->productview = $productview->viewProducts($id); // Calling values to display
    }

    public function addtocartAction()
    {
        $this->_helper->layout()->disableLayout();
    	$id=$this->view->Dcode($this->_getParam('id'));
    	$producttocart = new user_Model_DbTable_Products(); // initializing the class
    	$this->view->addtocart = $producttocart->productaddtocart($id);
    }


}





