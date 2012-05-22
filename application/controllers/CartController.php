<?php

class CartController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        $this->_helper->layout->setLayout('user'); 
        // action body
        $pid = $this->view->Dcode($this->_getParam('Pid'));
        $uid = $this->view->Dcode($this->_getParam("uID"));
        $this->view->pid = $this->_getParam('Pid');
        
        $username = new Application_Model_DbTable_Cart();
        $this->view->username = $username->username($uid);
        $this->view->planname = $username->planname($uid,$pid);
        $this->view->uid=$this->view->Ecode($uid);
        $this->view->pid=$this->view->Ecode($pid);
        $this->view->cart = $username->cart($uid,$pid);
        
        $products = new Application_Model_DbTable_Cart();
        $this->view->products = $products->cart_product_list($this->view->baseurl());
    }

    public function freeplanAction()
    {
        $pid = $this->view->Dcode($this->_getParam('pid'));
        $sessid=Session_id();
        
        $sess = new Zend_Session_Namespace('user');
    	$hf_id = $sess->hf_id;
    	
    	$pname = new Application_Model_DbTable_Paymentdb();
    	$this->view->planname = $pname->plan_name($pid);
    	$planname = $pname->plan_name($pid);
    	
    	$username = new Application_Model_DbTable_UserRegister();
    	$this->view->username = $username->UserName($hf_id);
		$username = $username->UserName($hf_id);
    	
    	$ActivateFreePlan = new Application_Model_DbTable_Cart();
    	$freestatus = $ActivateFreePlan->activatefreeplan($pid,$sessid,$hf_id);
    	
    	$userdeatils = new Application_Model_DbTable_General();
    	$userdata = $userdeatils->userdetails($hf_id);
    	
    	$MailLegal = new Zend_Session_Namespace('maillegal');
    	$mailbottom=$MailLegal->maillegal;
    	
    	$emailbody='<div class="normal-text" style="width:90%;margin-left:15px;">
					<p>Hi '.$username.', </p>
					<p>Thanks for registering with ZH Healthcare. Your plan registration ('.$planname.') completed successfully. </p>
					<p>We required 24 hours to setup the plan environment for you. Once the plan setup is completed, you will notify through your registered email address.	  </p>
					<p>Regards,</p>
					<p> ZH Healthcare Support Team </p>
					</div>'.$mailbottom;
    	 
    	$emailto = trim($userdata['hf_email']);
    	$nameto = $userdata['hf_facility_name'];
    	 
    	$mail = new Zend_Mail();
    	$mail->setType(Zend_Mime::MULTIPART_RELATED);
    	//$mail->setBodyText('Invoice Details attached');
    	$mail->setBodyHtml($emailbody);
    	$mail->setFrom('info@zhservices.com', 'ZH Healthcare');
    	$mail->addTo($emailto, $nameto);
    	$mail->setSubject($planname.' Registered Successfully');
    	$mail->send();
    }

    public function addAdditionalProductAction()
    {
       	$this->_helper->layout->disableLayout();
       	$ProductId = $this->_getParam('productid');
 		$providerno = $this->_getParam('providerno');
      	$action = $this->_getParam('add');
     
       
       	$products = new user_Model_DbTable_Products();
       	$result = $products->productaddtocart($ProductId,$providerno);
       	echo "Added Product Into Cart";
    }

    public function removeAdditionalProductAction()
    {
        $this->_helper->layout->disableLayout();
        $cartid = $this->_getParam('cartid');
        $products = new Application_Model_DbTable_Cart();
        $result = $products->deleteproductfromcart($cartid);
        echo "Successfully deleted Product from cart";
    }


}







