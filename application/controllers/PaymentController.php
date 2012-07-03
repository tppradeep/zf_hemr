<?php
require_once 'Zend/Http/Client.php';
require_once 'CallerService.php';
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

    public function confirmAction() // This is for IPN now it integrated into paypal pro so, no need of IPN
    {
    	
    	
    }

    public function thanksAction()
    {
    	$cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Payment Success');
     	
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
    	<td valign="middle" class="invoice-title"><strong>Bill To :';
    	$invoicePDF .= $invoiceaddress['hf_facility_suffix'];
    	$invoicePDF .= "&nbsp;";
    	$invoicePDF .= $invoiceaddress['hf_facility_name'];
    	$invoicePDF .= "&nbsp;";
    	$invoicePDF .= $invoiceaddress['hf_facility_lname'];
    	$invoicePDF .= "</strong><br />";
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
    	if($invoicedetails['amount']>0)
    	{
    	    $invoicePDF .= '<tr>
    	    <td class="normal-text line"  valign="middle" height="25px">&nbsp;</td>
    	    <td class="normal-text line" valign="middle">'.str_replace(",","<br/>",$invoicedetails['particulars']).' </td>
    	    <td class="normal-text line" valign="middle">:</td>
    	    <td align="right" class="normal-text line" valign="middle">';
    	    
    	    $MonthlyFee = new Zend_Currency('en_US');
    	    $invoicePDF .= $MonthlyFee->toCurrency($invoicedetails['amount']+$invoicedetails['discount_amount']);
    	    $invoicePDF .='</td>
    	    <td align="right" class="normal-text b line">&nbsp;</td>
    	    </tr>';
    	}
	    	if($invoicedetails['setupfee']>0)
	    	{
	    	
	    	$invoicePDF .='<tr>
	    		<td class="normal-text line" valign="middle" height="25px">&nbsp;</td>
	    		<td class="normal-text line" valign="middle">Onetime Fee </td>
	    		<td class="normal-text line" valign="middle">:</td>
	    		<td align="right" class="normal-text line" valign="middle">';
	    	
	    		$OneTimeFee = new Zend_Currency('en_US');
	    		$invoicePDF .= $OneTimeFee->toCurrency($invoicedetails['setupfee']);
	    		$invoicePDF .='</td>
	    		<td align="right" class="normal-text b line">&nbsp;</td>
	    		</tr>';
	    	}
	    	if($invoicedetails['discount_amount']>0)
	    	{
	    	
	    		$invoicePDF .= '<tr>
	    		<td class="normal-text line" valign="middle" height="25px">&nbsp;</td>
	    		<td class="normal-text line" valign="middle">Discount </td>
	    		<td class="normal-text line" valign="middle">:</td>
	    		<td align="right" class="normal-text line" valign="middle">';
	    	
	    		$MonthlyFee = new Zend_Currency('en_US');
	    		$invoicePDF .= $MonthlyFee->toCurrency($invoicedetails['discount_amount']);
	    		$invoicePDF .='</td>
	    		<td align="right" class="normal-text b line">&nbsp;</td>
	    		</tr>';
	    	}

    			$invoicePDF .='<tr>
    			<td class="normal-text b line" valign="middle" style="padding:10px;" height="25px">&nbsp;</td>
    			<td align="right" class="normal-text b line" valign="middle" style="padding:10px;">Gross Amount</td>
    			<td class="normal-text b line" valign="middle" style="padding:10px;">:</td>
    			<td align="right" class="normal-text b line" valign="middle" style="padding:10px;">';
    	
    			$totalFee = new Zend_Currency('en_US');
    			$invoicePDF .= $totalFee->toCurrency($invoicedetails['amount']+$invoicedetails['setupfee']);
    			$invoicePDF .='</td>
    			<td align="right" class="normal-text b line" style="padding:10px;">&nbsp;</td>
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

    public function makePaymentAction()
    {
        $Gndb = new Application_Model_DbTable_General();
         
        $PayPal_Notification 			= new Application_Model_DbTable_Cms();
        $this->view->paypaldtd 			= $PayPal_Notification->getcms('Paypal_intimation');
        
        $sess = new Zend_Session_Namespace('user');
        $hf_id=$sess->hf_id;
        
        if ($this->getRequest()->isPost()) // Making Payment
        {
	        $this->view->hfdata = $Gndb->identifierdetails($hf_id);
	    	$formData = $this->getRequest()->getParams();
	    	$this->view->formdata = $formData;
        }
    }
    
    public function doPaymentAction()
    {
    	if($this->getRequest()->isPost())
    	{
    	    
    	    $formData = $this->getRequest()->getParams();
    	    
    	//    echo "<pre>";
    	//    print_r($formData);
    	//    echo "</pre>";
    	  //  die;
    	    $this->view->formdata = $formData;

    	    $paymentType =urlencode( $formData['cmd']);
    	    $firstName =urlencode( $formData['firstName']);
    	    $lastName =urlencode( $formData['lastName']);
    	    $creditCardType =urlencode( $formData['creditCardType']);
    	    $creditCardNumber = urlencode($formData['creditCardNumber']);
    	    $expDateMonth =urlencode( $formData['expDateMonth']);
    	    
    	    // Month must be padded with leading zero
    	    $padDateMonth = str_pad($expDateMonth, 2, '0', STR_PAD_LEFT);
    	    
    	    $expDateYear =urlencode( $formData['expDateYear']);
    	    $cvv2Number = urlencode($formData['cvv2Number']);
    	    $address1 = urlencode($formData['address1']);
    	    $address2 = urlencode($formData['address2']);
    	    $city = urlencode($formData['city']);
    	    $state =urlencode( $formData['state']);
    	    $zip = urlencode($formData['zip']);
    	    $amount = urlencode($formData['amount']);
    	    $currencyCode="USD";
    	    
    	    $profileDesc = urlencode($formData['item_name']);
    	    $invoice_no = urlencode($formData['item_number']);
    	    $billingPeriod = "Month";
    	    $billingFrequency = 1;
    	    $totalBillingCycles = 0;
    	    
    	  
    	    $initamt = urlencode($formData['a1']);
    	    
    	    if($initamt==0)
    	        $initamt=$amount; // if there is no setup fee then assign first month subscription amount to initial amount
    	    
    	   
    	    
    	    $profileStartDateDay = date("d");
    	    // Day must be padded with leading zero
    	    $padprofileStartDateDay = str_pad($profileStartDateDay, 2, '0', STR_PAD_LEFT);
    	    $profileStartDateMonth = date("m");
    	    // Month must be padded with leading zero
    	    $padprofileStartDateMonth = str_pad($profileStartDateMonth, 2, '0', STR_PAD_LEFT);
    	    $profileStartDateYear = date("Y");
    	    
    	    $profileStartDate = urlencode($profileStartDateYear . '-' . $padprofileStartDateMonth . '-' . $padprofileStartDateDay . 'T00:00:00Z');
    	    
    	    /* Construct the request string that will be sent to PayPal.
    	     The variable $nvpstr contains all the variables and is a
    	    name value pair string with & as a delimiter */
    	    $direct = 0;
    	    
    	   
    	    if($amount==0) //Direct Payment section
    	    {
    	       // echo "direct";
				$direct = 1;
    	    	$amount=$initamt;
    	        $nvpstr="&AMT=$amount&PAYMENTACTION=Sale&IPADDRESS=192.168.0.1&INITAMT=$initamt&CREDITCARDTYPE=$creditCardType&ACCT=$creditCardNumber&EXPDATE=".$padDateMonth.$expDateYear."&CVV2=$cvv2Number&FIRSTNAME=$firstName&LASTNAME=$lastName&STREET=$address1&CITY=$city&STATE=$state".
    	        		"&ZIP=$zip&COUNTRYCODE=US&CURRENCYCODE=$currencyCode&PROFILESTARTDATE=$profileStartDate&DESC=$profileDesc&BILLINGPERIOD=$billingPeriod&BILLINGFREQUENCY=$billingFrequency&TOTALBILLINGCYCLES=$totalBillingCycles";
    	        	
    	     
    	        $resArray=hash_call_direct("DoDirectPayment",$nvpstr);
    	    }
    	    else // recurrering section 
    	    {
    	       
    	    	 $nvpstr="&AMT=$amount&INITAMT=$initamt&CREDITCARDTYPE=$creditCardType&ACCT=$creditCardNumber&EXPDATE=".$padDateMonth.$expDateYear."&CVV2=$cvv2Number&FIRSTNAME=$firstName&LASTNAME=$lastName&STREET=$address1&CITY=$city&STATE=$state".
    	    		"&ZIP=$zip&COUNTRYCODE=US&CURRENCYCODE=$currencyCode&PROFILESTARTDATE=$profileStartDate&DESC=$profileDesc&BILLINGPERIOD=$billingPeriod&BILLINGFREQUENCY=$billingFrequency&TOTALBILLINGCYCLES=$totalBillingCycles";
    	
    	   		$resArray=hash_call("CreateRecurringPaymentsProfile",$nvpstr);
    	    }
    	   // echo $nvpstr;
    	   // die;
    	   // echo  $_SESSION['curl_error_msg'];
		//	echo "<pre>";
			//print_r($resArray);
		//	die;
			
    	    
    	    /* Display the API response back to the browser.
    	     If the response from PayPal was a success, display the response parameters'
    	    If the response was an error, display the errors received using APIError.php.
    	    */
    	    $ack = strtoupper($resArray["ACK"]);
    	  //  die;
    	    if($ack=="SUCCESS") 
    	    {

    	      	
    	        // Updating the tables and sending mail
    	        $sess = new Zend_Session_Namespace('user');
    	        $hf_id = $sess->hf_id;
    	        
    	        
    	        $particulars = $formData['item_name'];
    	        $payment_date = date('Y-m-d');
    	        $payment_status = "COMPLETED";
    	        $transaction_id = $resArray['TRANSACTIONID'];
				if($direct==0)
    	        	$subscr_id = $resArray['PROFILEID'];
    	        $paypal_string = json_encode($resArray);
    	        
    	        $invoice_number = $formData['item_number'];
    	        
    	        $inv = new Application_Model_DbTable_Paymentdb();
    	        $uid=$inv->Confirm_invoice($hf_id,$invoice_number,$particulars,$payment_date,$payment_status,$transaction_id,$paypal_string,$subscr_id);
    	       
    	        
    	        /*
    	         * CALLING PLAN SETTUP SECTION
    	         * 
    	         */

    	        
			    	   
							
						//	die;
    	        /*
    	         * The above code section using to auto setup the oemr section. deleting or altering the section will affect the automatic plan setup
    	         * 
    	         */
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
    	        $emailbody = str_replace('__name__', $firstName." ".$lastName, $emailbody);
    	         
    	        $emailbody=$emailbody.$mailbottom;
    	        
    	        $InvoiceAddress		= New Application_Model_DbTable_Paymentdb();
    	        $invoiceaddress		= $InvoiceAddress->invoiceaddress_invoice($invoice_number);
    	         
    	        $emailto = trim($invoiceaddress[0]['hf_email']);
    	        $nameto = $invoiceaddress[0]['hf_facility_name'];
    	         
    	        
    	        $mailconfig = new Zend_Session_Namespace('mail');
    	        
    	        $config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' =>  $mailconfig->userid, 'password' => $mailconfig->password);
    	         
    	        $transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
    	         
    	        $mail = new Zend_Mail();
    	        $mail->setType(Zend_Mime::MULTIPART_RELATED);
    	        //$mail->setBodyText('Invoice Details attached');
    	        $mail->setBodyHtml($emailbody);
    	        
    	        
    	        $mail->setFrom($mailconfig->userid, 'ZH Healthcare');
    	        $mail->addTo($emailto, $nameto);
    	        $mail->setSubject($emailsubject);
    	        
    	        $gendb->messageadd($hf_id,addslashes($emailsubject),addslashes($emailbody));
    	        try
    	        {
    	        	$mail->send($transport);
    	        	
    	        }
    	        catch(Zend_Exception $e)
    	        {
    	        
    	        }
 	        	$ProductUpdateToPlan = new Application_Model_DbTable_Paymentdb();
   	        	$uid=$ProductUpdateToPlan->ProductUpdateToPlan($hf_id,$invoice_number,$payment_date,$payment_status,$transaction_id);
				
   	        	//$this->_helper->redirector('thanks','Payment',null,array('st' => 'success'));
   	        	//$this->_helper->redirector('PlanSetup','Index',null,array('st' => 'success','hfid'=>base64_encode($hf_id)));
				
    	        	$this->_redirect('/PlanSetup/index/st/success/hfid/'.base64_encode($hf_id).'/invno/'.base64_encode($invoice_no));
   	        	 
    	    }
    	    else // Payment is fail 
    	    {
    	        $this->_helper->redirector('fail','Payment',null,array('st' => 'fail'));
    		}
    	}
    }
    public function failAction()
    {
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Payment Fail');
    }
}






