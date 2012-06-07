<?php
require_once 'Zend/Http/Client.php';
class PaymentController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
        //$this->_helper->layout->setLayout('user');
    }

    public function indexAction()
    {
       
        //Retriving the user and plan detals to process the paypal
    	$uid 							= $this->view->Dcode($this->_getParam('uid'));
    	$pid 							= $this->view->Dcode($this->_getParam('pid'));
   // 	$PlanCustomFields				= $this->_getParam('PlanCustomFields');
    	
    	
    	$uname 							= new Application_Model_DbTable_UserRegister();
    	$this->view->uname 				= ucfirst(strtolower($uname->UserName($uid))); // for User Full Name
    	$this->view->ulogin 			= $uname->UserLoginInfo($uid); // for User Login and password info
    
    	if($pid!=0)
    	{
	    	$pname 							= new Application_Model_DbTable_PlanList();
	    	
	    	$this->view->planname 			= $pname->planname($pid);
	    	$this->view->custom				= $uid."_".$pid;
    	}
    	
    	$inv = new Application_Model_DbTable_Paymentdb();
    	$invnumber=$inv->Add_Invoice($pid,$uid);
    	$this->_redirect("Payment/Viewinvoice/inid/".$this->view->Ecode($invnumber)."", array('prependBase' => true));
    	 
    	
    	
    }

    public function confirmAction()
    {
    	
    		
    	 $this->_helper->layout()->disableLayout();
    	 $formData = $this->getRequest()->getParams();
    //	echo "<pre>";
    //	print_r($formData);
    //	echo "</pre>";
    	$req = 'cmd=_notify-validate';
    	 $i=1;
    	 foreach ($formData as $key => $value) {
    	 	if($i>3)
    	 	{
    	 		$value = urlencode(stripslashes($value));
    	 		$req .= "&$key=$value";
    	 	}
    	 	$i=$i+1;
    	 }
    	// echo $req;
    	 
    	 
    	// $header = "POST /cgi-bin/webscr HTTP/1.0\r\n";
    	 //$header .= "Content-Type: application/x-www-form-urlencoded\r\n";
    	// $header .= "Content-Length: " . strlen($req) . "\r\n\r\n";
    	 
    	// $fp = fsockopen ('https://www.sandbox.paypal.com', 80, $errno, $errstr, 30);
    	// $fp = fsockopen ('ssl://www.sandbox.paypal.com',443, $errno, $errstr, 30);
    	// fputs ($fp, $header . $req);
    	// echo $res = fgets ($fp, 1024);
    	 $res = file_get_contents('https://www.sandbox.paypal.com?'.$req.'');
    	 $paypaloutput=$res;
    	 
    	 $txn_type=$formData['txn_type'];
    	 $res="SUCCESS";
    	 
    	 
      	/*
      	 * The following section done with assumption that the #res is "SUCCESS"
      	 */
    	 if($res=="SUCCESS")
    	 {
	    	 	$fp = fopen('d://data.html', 'a');
	    	 	fwrite($fp, "<br>----------".date('Y-m-d')."-". $paypaloutput." Write Start Query Retrived---<br>");
	    	 	fwrite($fp, $req);
	    	 	fwrite($fp, "<br>--------------Write Query Retrived End-------------------<br>");
	    	 	fclose($fp);
    	 	
	    	 	
    	 	$payer_id 		= $formData['payer_id'];
    	 	$first_name 	= $formData['first_name'];
    	 	$particulars	= $formData['item_name'];
    	 	$transaction_id="";
    	 	if (array_key_exists('txn_id', $formData)) {
    	 	 	$transaction_id	= $formData['txn_id'];
    	 	}
    	 	$last_name 		= $formData['last_name'];
    	 	$payer_email 	= $formData['payer_email'];

    	 	//$payment_status = "Completed"; //This is hardcoded now have update while hosting
    	 	$payment_status	= $formData['payment_status'];
    	 	$paypal_string	= $req;
    	 	$invoice_number			= $formData['custom'];
    	 	$subscr_id="";
    	 	
    	// 	$payment_date 	= $formData['subscr_date'];
    	 	$payment_date   = date('Y-m-d');
    	 	
    	 //	$subscription_amount = $formData['mc_amount3'];
    	 	if (array_key_exists('subscr_id', $formData)) {
    	 	$subscr_id 		= $formData['subscr_id'];
    	 	}
    	 	
    	 	
    	 	$InvoiceAddress		= New Application_Model_DbTable_Paymentdb();
    	 	$invoiceaddress		= $InvoiceAddress->invoiceaddress_invoice($invoice_number);
    	 	
    	 	
    	 	$hf_id =$invoiceaddress[0]['hf_id'];
    	 	
    	 	
    	 	if($txn_type=="subscr_payment" || $txn_type=="web_accept") // when plan is signup first time payment
    	 	{
    	 	/*
    	 	 * Calling Confirm_invoice function to update Invoice Status after payment
    	 	 * This function is a backend process of IPN execution
    	 	 */
    	 	    
    	 	$inv = new Application_Model_DbTable_Paymentdb();
    	 	$uid=$inv->Confirm_invoice($hf_id,$invoice_number,$particulars,$payment_date,$payment_status,$transaction_id,$paypal_string,$subscr_id);
    	 	
    	 	
    	 	/*
    	 	 * Sending Mail with Payment Status
    	 	 */
    	 	/*
    	 	 * Email Template Section
    	 	*/
    	 	$MailLegal = new Zend_Session_Namespace('maillegal');
    	 	$mailbottom=$MailLegal->maillegal;
    	 	
    	 	$gendb = new Application_Model_DbTable_General();
    	 	$emldata = $gendb->emailtemplate('invoice_details');
    	 	$emailsubject =  str_replace('__invoiceno__', $invoice_number, $emldata['Subject']);
    	 	$emailbody = $emldata['content'];
    	 	$emailbody = str_replace('__invoiceno__', $invoice_number, $emailbody);
    	 	
    	 	$emailbody=$emailbody.$mailbottom;
    	 
    	 
    	
    	$emailto = trim($invoiceaddress[0]['hf_email']);
    	$nameto = $invoiceaddress[0]['hf_facility_name'];
    	
    	$config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' => 'pradeep@zhservices.com', 'password' => 'pradulmon');
    	
    	$transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
    	
    	$mail = new Zend_Mail();
    	$mail->setType(Zend_Mime::MULTIPART_RELATED);
    	//$mail->setBodyText('Invoice Details attached');
    	$mail->setBodyHtml($emailbody);
    	$mail->setFrom('pradeep@zhservices.com', 'ZH Healthcare');
    	$mail->addTo($emailto, $nameto);
    	$mail->setSubject($emailsubject);
    	try
		{
			$mail->send($transport);
		}
		catch(Zend_Exception $e)
		{
		    
		}
    	
    	if(strtolower($payment_status)=="completed")
    	{

    	    $ProductUpdateToPlan = new Application_Model_DbTable_Paymentdb();
    	    $uid=$ProductUpdateToPlan->ProductUpdateToPlan($hf_id,$invoice_number,$payment_date,$payment_status,$transaction_id);
    	    
    	}
    	
    	 	}
    	 
    	 
    	 	
    	 }    	 
    }

    public function thanksAction()
    {
        $formData = $this->getRequest()->getParams();
   //     echo "<pre>";
    //    print_r($_GET);
        
        $req="";
        foreach ($_GET as $key => $value) {
        	$value = urlencode(stripslashes($value));
        	$req .= "&$key=$value";
        }
      //  $UpdateInvoice = new Application_Model_DbTable_Paymentdb();
       // $UI=$UpdateInvoice->updateinvoice($formData);
     	$this->view->transaction=$formData;
    }

    public function viewinvoiceAction()
    {
        
       // $this->_helper->layout->disableLayout();
        
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Confirm Invoice');
        
    	$invoiceId	= $this->view->Dcode($this->_getParam('inid'));
    	
    	$invDetails = new Application_Model_DbTable_Paymentdb();

    	$invoicedetails 			    = $invDetails->invoicedetails($invoiceId);
    	$this->view->invoicedetails		= $invDetails->invoicedetails($invoiceId);
		$invoicedetails					= $invDetails->invoicedetails($invoiceId);
		//print_r($invoicedetails);
    	//die;
    	
    	$InvoiceAddress					= New Application_Model_DbTable_Paymentdb();
    	$this->view->invoiceaddress		= $InvoiceAddress->invoiceaddress($invoicedetails['hf_id']);
    	$invoiceaddress					= $InvoiceAddress->invoiceaddress($invoicedetails['hf_id']);
    	
    	$uname 							= new Application_Model_DbTable_UserRegister();
    	$this->view->uname 				= ucfirst(strtolower($uname->UserName($invoicedetails['hf_id']))); // for User Full Name
    	$this->view->ulogin 			= $uname->UserLoginInfo($invoicedetails['hf_id']); // for User Login and password info
		
    	$this->view->providerno			= $invDetails->plan_provider($invoicedetails['hf_id']);
    	if($invoicedetails['plan_id']!=0)
    	{
    	$pname 							= new Application_Model_DbTable_PlanList();
       	$planname 						= $pname->planname($invoicedetails['plan_id']);
       	$this->view->planname 			= $pname->planname($invoicedetails['plan_id']);
    	}
    	
    	$PayPal_Notification 			= new Application_Model_DbTable_Cms();
    	$this->view->paypaldtd 			= $PayPal_Notification->getcms('Paypal_intimation');
    	
    	$cms 							= new Application_Model_DbTable_Cms();
    	$this->view->cmsdtd 			= $cms->getcms('User_reg_Confirm');
    	
    	
    	/*
    	 * PDF Generation of Invoice
    	 */
    	$invoicePDF='
    	<style>
  .invoice-title
{
	font-family: Verdana, Geneva, sans-serif;
	font-size: 24px;
	font-weight: normal;
	color: #000;
	text-decoration: none;
	padding-left: 5px;
}
.invoice-table-title
{
	font-family: Verdana, Geneva, sans-serif;
	font-size: 24px;
	font-weight: bold;
	color: #000;
	text-decoration: none;
	padding-left: 5px;
}
.normal-text {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 20px;
	font-weight: normal;
	color: #373737;
}
.b {
	font-weight: bold;
}
.line {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #E2E2E2;
}
.form-label-main
{
	font-family: Tahoma, Arial, Verdana;
	font-size: 20px;
	font-weight: bold;
	color: #3C3C3C;
	text-decoration: none;
}
.form-label-sub
{
	font-family: Tahoma, Arial, Verdana;
	font-size: 20px;
	font-weight: normal;
	color: #3C3C3C;
	text-decoration: none;
	font-style: italic;
}
.sub-title
{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 20px;
	font-weight: bold;
	color: #400000;
	text-decoration: none;
}

</style>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tborder">
    	<tr>
    	<td width="25%" valign="middle"><img src="'.$this->view->baseUrl().'/images/zhhealthcare.jpg"  alt="Z&amp;H" /></td>
    	<td width="40%" valign="top" class="invoice-title">';
    	
    	$Address = new Zend_Session_Namespace('address');
    	$invoicePDF .= $Address->address;
    	
    	$invoicePDF .= '</td>
    	<td width="35%" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    	<td width="51%" class="normal-text">Invoice No</td>
    	<td width="2%" class="sub-title">:</td>
    	<td width="47%" nowrap="nowrap" class="form-label-main">'.$invoicedetails['invoice_number'].'</td>
    	</tr>
    	<tr>
    	<td class="normal-text">Currency</td>
    	<td class="sub-title">:</td>
    	<td class="form-label-main">USD</td>
    	</tr>
    	<tr>
    	<td class="normal-text">Date </td>
    	<td class="sub-title">:</td>
    	<td class="form-label-main">'.$invoicedetails['invoice_date'].'</td>
    	</tr>
    	</table></td>
    	</tr>
    	<tr>
    	<td colspan="3" valign="middle" class="line">&nbsp;</td>
    	</tr>
    	<tr>
    	<td valign="middle" class="invoice-title"><strong>Bill To :</strong><br />';
    	
    	$invoicePDF .= $invoiceaddress['hf_facility_name'];
    	$invoicePDF .= "<br/>";
    	$invoicePDF .= $invoiceaddress['hf_address'];
    	$invoicePDF .= "<br/>";
    	$invoicePDF .= $invoiceaddress['hf_city'];
    	$invoicePDF .= ", Zipcode:";
    	$invoicePDF .= $invoiceaddress['hf_zip'];
    	$invoicePDF .= "<br/>";
    	$invoicePDF .= $invoiceaddress['hf_state'];
    	$invoicePDF .= " - ";
    	$invoicePDF .= $invoiceaddress['hf_country'];
    	$invoicePDF .= "<br/>Email:";
    	$invoicePDF .= $invoiceaddress['hf_email'];
    	$invoicePDF .= "<br/>Phone :";
    	$invoicePDF .= $invoiceaddress['hf_phone'];
    	$invoicePDF .= "<br/> Fax:";
    	$invoicePDF .= $invoiceaddress['hf_fax'];
    	$invoicePDF .='</td>
    	<td valign="top" class="invoice-title">&nbsp;</td>
    	<td valign="bottom">&nbsp;</td>
    	</tr>
    	<tr>
    	<td colspan="3" valign="middle" class="line">&nbsp;</td>
    	</tr>
    	<tr>
    	<td colspan="3" valign="middle" class="invoice-title"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    	<td width="4%" height="25px" class="invoice-table-title line">&nbsp;</td>
    	<td width="78%" class="invoice-table-title line">SKU / Description</td>
    	<td width="2%" class="invoice-table-title line">&nbsp;</td>
    	<td width="12%" align="right" class="invoice-table-title line">Amount</td>
    	<td width="4%" class="invoice-table-title line">&nbsp;</td>
    	</tr>';
    	if($invoicedetails['plan_id']==0)
    	{
    	    $invoicePDF .= '<tr>
    	    <td height="35" class="normal-text b line">&nbsp;</td>
    	    <td class="normal-text line">'.$invoicedetails['particulars'].' </td>
    	    <td class="normal-text line">:</td>
    	    <td align="right" class="normal-text b line">';
    	    
    	    $MonthlyFee = new Zend_Currency('en_US');
    	    $invoicePDF .= $MonthlyFee->toCurrency($invoicedetails['amount']);
    	    $invoicePDF .='</td>
    	    <td align="right" class="normal-text b line">&nbsp;</td>
    	    </tr>';
    	}
    	else
    	{
	    	if($invoicedetails['amount']>0)
	    	{
	    	
	    	$invoicePDF .='<tr>
	    		<td height="50" class="normal-text b line">&nbsp;</td>
	    		<td class="normal-text line">Plan Onetime Fee </td>
	    		<td class="normal-text line">:</td>
	    		<td align="right" class="normal-text b line">';
	    	
	    		$OneTimeFee = new Zend_Currency('en_US');
	    		$invoicePDF .= $OneTimeFee->toCurrency($invoicedetails['setupfee']);
	    		$invoicePDF .='</td>
	    		<td align="right" class="normal-text b line">&nbsp;</td>
	    		</tr>';
	    	}
	    	if($invoicedetails['subscription_amount']>0)
	    	{
	    	
	    		$invoicePDF .= '<tr>
	    		<td height="35" class="normal-text b line">&nbsp;</td>
	    		<td class="normal-text line">Monthly Fee (advance payment) </td>
	    		<td class="normal-text line">:</td>
	    		<td align="right" class="normal-text b line">';
	    	
	    		$MonthlyFee = new Zend_Currency('en_US');
	    		$invoicePDF .= $MonthlyFee->toCurrency($invoicedetails['subscription_amount']);
	    		$invoicePDF .='</td>
	    		<td align="right" class="normal-text b line">&nbsp;</td>
	    		</tr>';
	    	}
    	}
    
    		/*if($invoicedetails['discount_amount']>0)
    		{
    			$invoicePDF .= '<tr>
    			<td height="35" class="normal-text b line">&nbsp;</td>
    			<td align="right" class="normal-text b line">Discount </td>
    			<td class="normal-text b line">:</td>
    			<td align="right" class="normal-text b line">
    			'.$MonthlyFee->toCurrency($invoicedetails['discount_amount']).'
    			</td>
    			<td align="right" class="normal-text b line">&nbsp;</td>
    			</tr>';
    		}*/
    			$invoicePDF .='<tr>
    			<td height="35" class="normal-text b line">&nbsp;</td>
    			<td align="right" class="normal-text b line">Gross Amount</td>
    			<td class="normal-text b line">:</td>
    			<td align="right" class="normal-text b line">';
    	
    			$totalFee = new Zend_Currency('en_US');
    			$invoicePDF .= $totalFee->toCurrency($invoicedetails['amount']+$invoicedetails['setupfee']);
    			$invoicePDF .='</td>
    			<td align="right" class="normal-text b line">&nbsp;</td>
    			</tr>';
    		
    	
    	
    	$invoicePDF .='</table></td>
    	</tr>
    	</table>';
    	
    	$invoicepath = str_replace("application", "public", APPLICATION_PATH).'\\uploads\\invoice\\'.$invoicedetails['invoice_number'].'.pdf';
   // 	$file = fopen($invoicepath,"w");
   // 	echo fwrite($file,$invoicePDF);
   // 	fclose($file);
    	
    	require_once('tcpdf/tcpdf.php');
    	$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
    	
    	$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
    	$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
    	$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
    	
    	$pdf->AddPage();
    	
    	//whole TCPDF's settings goes here
    	
    	//$htmlcontent = $this->view->render($invoicepath);
    	// output the HTML content
    	$pdf->writeHTML($invoicePDF, true, 0, true, 0);
   
    
    	
    	// Print text using writeHTMLCell()
    	$pdf->writeHTMLCell($w=0, $h=0, $x='', $y='', $html, $border=0, $ln=1, $fill=0, $reseth=true, $align='', $autopadding=true);
    	 
    	
    	$pdf->lastPage();
    	ob_clean(); // Important
    	$pdf->Output($invoicepath, 'F');
    	// die;
    	
    	/*
    	 * Sending Mail to User of Invoice Details
    	 */
    	
    	/*
    	 * Email Template Section
    	*/
    	$MailLegal = new Zend_Session_Namespace('maillegal');
    	$mailbottom=$MailLegal->maillegal;
    	 
    	$gendb = new Application_Model_DbTable_General();
    	$emldata = $gendb->emailtemplate('invoice_attachement_mail');
    	$emailsubject =  str_replace('__invoiceno__', $invoicedetails['invoice_number'], $emldata['Subject']);
    	$emailbody = $emldata['content'];
		$emailbody = str_replace('__username__', $invoiceaddress['hf_facility_name'], $emailbody);
    	$emailbody = str_replace('__invoiceno__', $invoicedetails['invoice_number'], $emailbody);
    	 
    	$emailbody=$emailbody.$mailbottom;
    	
    	
    	
    	$emailto = trim($invoiceaddress['hf_email']);
    	$nameto = $invoiceaddress['hf_facility_name'];
    	
    	$config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' => 'pradeep@zhservices.com', 'password' => 'pradulmon');
    	
    	$transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
    	$mail = new Zend_Mail();
    	$mail->setType(Zend_Mime::MULTIPART_RELATED);
    	//$mail->setBodyText('Invoice Details attached');
    	$mail->setBodyHtml($emailbody);
    	$mail->setFrom('pradeep@zhservices.com', 'ZH Healthcare');
    	$mail->addTo($emailto, $nameto);
    	$mail->setSubject($emailsubject);
    	
    	
    	$myImage = file_get_contents($invoicepath);
    	$at = $mail->createAttachment($myImage);
    	$at->type        = 'text/pdf';
    	$at->disposition = Zend_Mime::DISPOSITION_INLINE;
    	$at->encoding    = Zend_Mime::ENCODING_BASE64;
    	$at->filename    = $invoicedetails['invoice_number'].'.pdf';
    	
    	try
		{
			//$mail->send($transport);
		}
		catch(Zend_Exception $e)
		{
		    
		}
    	
    	/*
    	 * Mail Send End
    	 */
    }


}







